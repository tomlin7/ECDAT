"use client";

import { useCallback, useEffect, useMemo, useState } from "react";
import {
  AlertCircle,
  Binary,
  CheckCircle2,
  FileCode2,
  Loader2,
  ShieldAlert,
  Upload,
} from "lucide-react";
import { Alert, AlertDescription, AlertTitle } from "@/components/ui/alert";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from "@/components/ui/card";
import { ScrollArea } from "@/components/ui/scroll-area";
import { Separator } from "@/components/ui/separator";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Textarea } from "@/components/ui/textarea";
import type { AnalysisReport, EnterpriseInventory, Finding, FunctionRecord } from "@/lib/ir/types";
import { inventoryToHtml, inventoryToJson } from "@/lib/report";
import type { SampleMeta } from "@/lib/samples/catalog";
import { cn } from "@/lib/utils";
import { buttonVariants } from "@/components/ui/button";

export function Workbench() {
  const [samples, setSamples] = useState<SampleMeta[]>([]);
  const [ir, setIr] = useState("");
  const [filename, setFilename] = useState("pasted.ll");
  const [report, setReport] = useState<AnalysisReport | null>(null);
  const [error, setError] = useState<string | null>(null);
  const [loading, setLoading] = useState(false);
  const [dragOver, setDragOver] = useState(false);
  const [selectedFn, setSelectedFn] = useState<string | null>(null);
  const [selectedFinding, setSelectedFinding] = useState<string | null>(null);
  const [assetId, setAssetId] = useState("");
  const [businessUnit, setBusinessUnit] = useState("unspecified");
  const [orgSite, setOrgSite] = useState("");

  useEffect(() => {
    fetch("/api/samples")
      .then((r) => r.json())
      .then((d) => setSamples(d.samples ?? []))
      .catch(() => setSamples([]));
  }, []);

  const applyReport = useCallback(async (res: Response) => {
    const data = await res.json();
    if (!res.ok) {
      setReport(null);
      setError(data.error ?? "Analysis failed");
      return;
    }
    setReport(data as AnalysisReport);
    setAssetId(data.filename ?? "unknown-asset");
    setSelectedFinding(data.findings[0]?.id ?? null);
    setSelectedFn(
      data.findings[0]?.functions[0] ?? data.functions[0]?.name ?? null,
    );
  }, []);

  const runAnalysis = useCallback(async (source: string, name: string) => {
    setLoading(true);
    setError(null);
    try {
      const res = await fetch("/api/analyze", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ ir: source, filename: name }),
      });
      await applyReport(res);
    } catch {
      setReport(null);
      setError("Could not reach the analyzer. Check that the dev server is running.");
    } finally {
      setLoading(false);
    }
  }, [applyReport]);

  const runAnalysisBytes = useCallback(async (bytes: ArrayBuffer, name: string) => {
    setLoading(true);
    setError(null);
    try {
      const form = new FormData();
      form.append("file", new Blob([bytes]), name);
      const res = await fetch("/api/analyze", { method: "POST", body: form });
      await applyReport(res);
    } catch {
      setReport(null);
      setError("Could not reach the analyzer. Check that the dev server is running.");
    } finally {
      setLoading(false);
    }
  }, [applyReport]);

  async function onFile(file: File) {
    setFilename(file.name);
    const bytes = await file.arrayBuffer();
    const head = new TextDecoder("utf-8", { fatal: false }).decode(
      new Uint8Array(bytes).slice(0, 4000),
    );
    if (
      file.name.endsWith(".ll") ||
      file.name.endsWith(".ir") ||
      head.includes("target triple") ||
      head.includes("; ModuleID") ||
      /\bdefine\s+/.test(head)
    ) {
      setIr(new TextDecoder("utf-8", { fatal: false }).decode(bytes));
    } else {
      setIr("");
    }
    await runAnalysisBytes(bytes, file.name);
  }

  async function loadSample(id: string) {
    setLoading(true);
    setError(null);
    try {
      const res = await fetch(`/api/samples/${id}`);
      const data = await res.json();
      if (!res.ok) {
        setError(data.error ?? "Could not load sample");
        return;
      }
      setIr(data.ir ?? "");
      setFilename(data.filename);
      if (data.base64) {
        const raw = Uint8Array.from(atob(data.base64), (c) => c.charCodeAt(0));
        await runAnalysisBytes(raw.buffer, data.filename);
      } else {
        await runAnalysis(data.ir, data.filename);
      }
    } catch {
      setError("Failed to load corpus sample.");
    } finally {
      setLoading(false);
    }
  }

  const activeFinding: Finding | null = useMemo(() => {
    if (!report || !selectedFinding) return report?.findings[0] ?? null;
    return report.findings.find((f) => f.id === selectedFinding) ?? null;
  }, [report, selectedFinding]);

  const activeFn: FunctionRecord | null = useMemo(() => {
    if (!report) return null;
    const name =
      selectedFn ??
      activeFinding?.functions[0] ??
      report.functions[0]?.name ??
      null;
    if (!name) return null;
    return report.functions.find((f) => f.name === name) ?? null;
  }, [report, selectedFn, activeFinding]);

  const patchedInventory: EnterpriseInventory | null = useMemo(() => {
    if (!report?.inventory) return null;
    return {
      ...report.inventory,
      assetId: assetId || report.inventory.assetId,
      businessUnit: businessUnit || report.inventory.businessUnit,
      summary: orgSite
        ? `${report.summary} · site ${orgSite}`
        : report.summary,
    };
  }, [report, assetId, businessUnit, orgSite]);

  return (
    <div className="flex min-h-full flex-1 flex-col">
      <header className="border-b border-border/80 bg-card/40">
        <div className="mx-auto flex max-w-7xl flex-col gap-3 px-4 py-4 sm:flex-row sm:items-center sm:justify-between sm:px-6">
          <div className="flex items-start gap-3">
            <div className="mt-0.5 flex size-10 items-center justify-center rounded-lg border border-emerald-500/30 bg-emerald-500/10 text-emerald-400">
              <Binary className="size-5" />
            </div>
            <div>
              <p className="font-mono text-[11px] tracking-wide text-emerald-400/90">
                SIH26164 · NTRO · Blockchain &amp; Cybersecurity
              </p>
              <h1 className="text-lg font-semibold tracking-tight sm:text-xl">
                ECDAT — Enterprise Cryptographic Discovery
              </h1>
              <p className="text-sm text-muted-foreground">
                Lift Clang LLVM IR, match FIPS/RFC constant tables, flag weak
                primitives.
              </p>
            </div>
          </div>
          <div className="flex flex-wrap items-center gap-2">
            <Badge variant="secondary" className="font-mono">
              LLVM IR frontend
            </Badge>
            <Badge variant="outline" className="font-mono">
              no execution
            </Badge>
            <a
              href="/pitch/sih-deck.html"
              target="_blank"
              rel="noreferrer"
              className={cn(
                buttonVariants({ variant: "outline", size: "sm" }),
                "inline-flex",
              )}
            >
              Pitch deck
            </a>
          </div>
        </div>
      </header>

      <main className="mx-auto flex w-full max-w-7xl flex-1 flex-col gap-6 px-4 py-6 sm:px-6">
        <section className="grid gap-4 lg:grid-cols-[minmax(0,1.05fr)_minmax(0,1.4fr)]">
          <Card>
            <CardHeader className="pb-3">
              <CardTitle className="text-base">Ingest</CardTitle>
              <CardDescription>
                Textual <span className="font-mono">.ll</span>, ELF/PE objects, or
                Clang <span className="font-mono">.o</span>. Signatures, CFG
                model, and raw constant-table scan.
              </CardDescription>
            </CardHeader>
            <CardContent className="space-y-4">
              <label
                onDragOver={(e) => {
                  e.preventDefault();
                  setDragOver(true);
                }}
                onDragLeave={() => setDragOver(false)}
                onDrop={(e) => {
                  e.preventDefault();
                  setDragOver(false);
                  const file = e.dataTransfer.files[0];
                  if (file) void onFile(file);
                }}
                className={cn(
                  "flex cursor-pointer flex-col items-center justify-center gap-2 rounded-xl border border-dashed px-4 py-8 text-center transition-colors",
                  dragOver
                    ? "border-emerald-400 bg-emerald-500/10"
                    : "border-border hover:border-emerald-500/40 hover:bg-muted/40",
                )}
              >
                <Upload className="size-5 text-muted-foreground" />
                <div className="text-sm">
                  Drop <span className="font-mono">.ll / .o / ELF / PE</span> or
                  click to browse
                </div>
                <p className="text-xs text-muted-foreground">Max 2 MB · UTF-8 IR</p>
                <input
                  type="file"
                  accept=".ll,.ir,.txt,.bc,.o,.so,.exe,.bin,.elf"
                  className="sr-only"
                  onChange={(e) => {
                    const file = e.target.files?.[0];
                    if (file) void onFile(file);
                  }}
                />
              </label>

              <div>
                <p className="mb-2 text-xs font-medium tracking-wide text-muted-foreground uppercase">
                  Clang corpus (O0, value names kept)
                </p>
                <div className="flex flex-wrap gap-2">
                  {samples.map((s) => (
                    <Button
                      key={s.id}
                      type="button"
                      size="sm"
                      variant="outline"
                      onClick={() => void loadSample(s.id)}
                      disabled={loading}
                    >
                      {s.title}
                    </Button>
                  ))}
                </div>
              </div>

              <Textarea
                value={ir}
                onChange={(e) => setIr(e.target.value)}
                placeholder={"; ModuleID = 'module'\ndefine i32 @main() {\n  ret i32 0\n}"}
                className={cn("font-mono text-xs", report ? "min-h-24" : "min-h-40")}
              />
              <div className="flex flex-wrap items-center gap-2">
                <Button
                  type="button"
                  onClick={() => void runAnalysis(ir, filename)}
                  disabled={loading || !ir.trim()}
                >
                  {loading ? (
                    <Loader2 className="animate-spin" />
                  ) : (
                    <FileCode2 />
                  )}
                  Analyze IR
                </Button>
                <span className="font-mono text-xs text-muted-foreground">
                  {filename}
                  {ir ? ` · ${(ir.length / 1024).toFixed(1)} KB` : ""}
                </span>
              </div>
            </CardContent>
          </Card>

          <ResultsPane
            loading={loading}
            error={error}
            report={report}
            inventory={patchedInventory}
            assetId={assetId}
            businessUnit={businessUnit}
            orgSite={orgSite}
            onAssetId={setAssetId}
            onBusinessUnit={setBusinessUnit}
            onOrgSite={setOrgSite}
            selectedFinding={selectedFinding}
            activeFinding={activeFinding}
            activeFn={activeFn}
            onSelectFinding={(id) => {
              setSelectedFinding(id);
              const f = report?.findings.find((x) => x.id === id);
              if (f?.functions[0]) setSelectedFn(f.functions[0]);
            }}
            onSelectFn={setSelectedFn}
          />
        </section>

        <footer className="border-t border-border/60 pt-4 pb-2 text-xs text-muted-foreground">
          Lift path: <span className="font-mono">clang -S -emit-llvm -O0 -fno-discard-value-names file.c</span>
          . ECDAT never runs the module. Weak findings (MD5, SHA-1, DES, CRC)
          are inventory flags, not exploits.
        </footer>
      </main>
    </div>
  );
}

function ResultsPane({
  loading,
  error,
  report,
  inventory,
  assetId,
  businessUnit,
  orgSite,
  onAssetId,
  onBusinessUnit,
  onOrgSite,
  selectedFinding,
  activeFinding,
  activeFn,
  onSelectFinding,
  onSelectFn,
}: {
  loading: boolean;
  error: string | null;
  report: AnalysisReport | null;
  inventory: EnterpriseInventory | null;
  assetId: string;
  businessUnit: string;
  orgSite: string;
  onAssetId: (v: string) => void;
  onBusinessUnit: (v: string) => void;
  onOrgSite: (v: string) => void;
  selectedFinding: string | null;
  activeFinding: Finding | null;
  activeFn: FunctionRecord | null;
  onSelectFinding: (id: string) => void;
  onSelectFn: (name: string) => void;
}) {
  if (loading && !report) {
    return (
      <Card className="flex min-h-72 items-center justify-center">
        <div className="flex flex-col items-center gap-2 text-muted-foreground">
          <Loader2 className="size-6 animate-spin" />
          <p className="text-sm">Walking IR, matching constant tables…</p>
        </div>
      </Card>
    );
  }

  if (error) {
    return (
      <Alert variant="destructive">
        <AlertCircle />
        <AlertTitle>Analyzer rejected the input</AlertTitle>
        <AlertDescription>{error}</AlertDescription>
      </Alert>
    );
  }

  if (!report) {
    return (
      <Card className="flex min-h-72 flex-col justify-center">
        <CardHeader>
          <CardTitle className="text-base">Waiting for a module</CardTitle>
          <CardDescription>
            Load the enterprise mix or the AES ELF object. Signatures, a CFG
            softmax model, and raw constant-table scan.
          </CardDescription>
        </CardHeader>
        <CardContent className="text-sm text-muted-foreground">
          Static analysis only. Nothing is executed, injected, or packed.
        </CardContent>
      </Card>
    );
  }

  return (
    <Card>
      <CardHeader className="pb-3">
        <CardTitle className="text-base">Findings</CardTitle>
        <CardDescription>{report.summary}</CardDescription>
      </CardHeader>
      <CardContent className="space-y-4">
        <div className="grid grid-cols-3 gap-2">
          <Stat label="Functions" value={String(report.functionCount)} />
          <Stat label="Primitives" value={String(report.findings.length)} />
          <Stat
            label="Weak / deprecated"
            value={String(report.weakCount)}
            warn={report.weakCount > 0}
          />
        </div>
        {report.targetTriple ? (
          <p className="font-mono text-[11px] text-muted-foreground">
            triple {report.targetTriple}
          </p>
        ) : null}
        {report.ingest ? (
          <p className="font-mono text-[11px] text-muted-foreground">
            ingest {report.ingest.kind} · {report.ingest.bytes} bytes
            {report.ingest.channels.signatures ? " · IR tables" : ""}
            {report.ingest.channels.ml ? " · CFG model" : ""}
            {report.ingest.channels.binary ? " · raw bytes" : ""}
            {report.ml
              ? ` · holdout ${(report.ml.holdoutAccuracy * 100).toFixed(0)}% n=${report.ml.trainedOn}`
              : ""}
          </p>
        ) : null}
        <Separator />
        {report.findings.length === 0 ? (
          <div className="flex items-start gap-2 rounded-lg border border-border/80 p-3 text-sm">
            <CheckCircle2 className="mt-0.5 size-4 text-emerald-400" />
            <p>
              No FIPS/RFC tables or RSA-shaped modexp matched. This is the
              expected result for business logic IR such as the benign sample.
            </p>
          </div>
        ) : (
          <ul className="space-y-2">
            {report.findings.map((f) => (
              <li key={f.id}>
                <button
                  type="button"
                  onClick={() => onSelectFinding(f.id)}
                  className={cn(
                    "w-full rounded-xl border px-3 py-3 text-left transition-colors",
                    selectedFinding === f.id
                      ? "border-emerald-500/40 bg-emerald-500/10"
                      : "border-border/80 hover:bg-muted/50",
                  )}
                >
                  <div className="flex flex-wrap items-center justify-between gap-2">
                    <div className="flex items-center gap-2">
                      <span className="font-mono text-xs text-muted-foreground">
                        {f.id}
                      </span>
                      <span className="text-sm font-medium">{f.title}</span>
                    </div>
                    <div className="flex items-center gap-2">
                      <SeverityBadge severity={f.severity} />
                      <SourceBadge source={f.source} />
                      <span className="font-mono text-xs">
                        {(f.confidence * 100).toFixed(0)}%
                      </span>
                    </div>
                  </div>
                  <p className="mt-1 font-mono text-[11px] text-muted-foreground">
                    {f.functions.length
                      ? f.functions.map((n) => `@${n}`).join("  ")
                      : "module-level constant"}
                  </p>
                </button>
              </li>
            ))}
          </ul>
        )}

        <Tabs defaultValue="evidence" className="pt-1">
          <TabsList>
            <TabsTrigger value="evidence">Evidence</TabsTrigger>
            <TabsTrigger value="inventory">Inventory</TabsTrigger>
            <TabsTrigger value="ir">Function IR</TabsTrigger>
            <TabsTrigger value="mix">Opcode mix</TabsTrigger>
            <TabsTrigger value="fns">Functions</TabsTrigger>
          </TabsList>
          <TabsContent value="evidence" className="mt-3">
            {activeFinding ? (
              <div className="space-y-3">
                <p className="text-sm">{activeFinding.rationale}</p>
                <ul className="space-y-2">
                  {activeFinding.evidence.map((ev, i) => (
                    <li
                      key={`${ev.summary}-${i}`}
                      className="rounded-lg border border-border/80 bg-muted/30 p-3"
                    >
                      <p className="text-xs font-medium tracking-wide text-muted-foreground uppercase">
                        {ev.kind}
                        {ev.line ? ` · line ${ev.line}` : ""}
                      </p>
                      <p className="mt-1 text-sm">{ev.summary}</p>
                      {ev.snippet ? (
                        <pre className="mt-2 overflow-x-auto font-mono text-[11px] leading-relaxed text-muted-foreground">
                          {ev.snippet}
                        </pre>
                      ) : null}
                    </li>
                  ))}
                </ul>
                {activeFinding.notes.length ? (
                  <Alert>
                    <ShieldAlert />
                    <AlertTitle>Posture notes</AlertTitle>
                    <AlertDescription>
                      <ul className="list-disc space-y-1 pl-4">
                        {activeFinding.notes.map((n) => (
                          <li key={n}>{n}</li>
                        ))}
                      </ul>
                    </AlertDescription>
                  </Alert>
                ) : null}
              </div>
            ) : (
              <p className="text-sm text-muted-foreground">
                Select a finding to see constant-table and CFG evidence.
              </p>
            )}
          </TabsContent>
          <TabsContent value="inventory" className="mt-3 space-y-3">
            {inventory ? (
              <>
                <div className="grid gap-2 sm:grid-cols-3">
                  <label className="space-y-1 text-xs">
                    <span className="text-muted-foreground">Asset ID</span>
                    <input
                      className="w-full rounded-md border border-border bg-background px-2 py-1.5 font-mono text-xs"
                      value={assetId}
                      onChange={(e) => onAssetId(e.target.value)}
                    />
                  </label>
                  <label className="space-y-1 text-xs">
                    <span className="text-muted-foreground">Business unit</span>
                    <input
                      className="w-full rounded-md border border-border bg-background px-2 py-1.5 text-xs"
                      value={businessUnit}
                      onChange={(e) => onBusinessUnit(e.target.value)}
                    />
                  </label>
                  <label className="space-y-1 text-xs">
                    <span className="text-muted-foreground">Org site (optional)</span>
                    <input
                      className="w-full rounded-md border border-border bg-background px-2 py-1.5 text-xs"
                      value={orgSite}
                      onChange={(e) => onOrgSite(e.target.value)}
                      placeholder="e.g. dc-east / firmware/build-42"
                    />
                  </label>
                </div>
                <div className="grid grid-cols-3 gap-2">
                  <Stat label="Asset" value={inventory.assetId.slice(0, 18)} />
                  <Stat label="OK" value={String(inventory.counts.ok)} />
                  <Stat
                    label="Review"
                    value={String(inventory.counts.review)}
                  />
                </div>
                <div className="flex flex-wrap gap-2">
                  <Button
                    type="button"
                    size="sm"
                    variant="outline"
                    onClick={() => {
                      const blob = new Blob([inventoryToJson(inventory)], {
                        type: "application/json",
                      });
                      const url = URL.createObjectURL(blob);
                      const a = document.createElement("a");
                      a.href = url;
                      a.download = `${inventory.assetId.replace(/[^a-z0-9._-]+/gi, "_")}-inventory.json`;
                      a.click();
                      URL.revokeObjectURL(url);
                    }}
                  >
                    Export JSON
                  </Button>
                  <Button
                    type="button"
                    size="sm"
                    variant="outline"
                    onClick={() => {
                      const blob = new Blob([inventoryToHtml(inventory)], {
                        type: "text/html",
                      });
                      const url = URL.createObjectURL(blob);
                      const a = document.createElement("a");
                      a.href = url;
                      a.download = `${inventory.assetId.replace(/[^a-z0-9._-]+/gi, "_")}-inventory.html`;
                      a.click();
                      URL.revokeObjectURL(url);
                    }}
                  >
                    Export HTML
                  </Button>
                </div>
                <ScrollArea className="h-64 rounded-lg border border-border/80">
                  <table className="w-full text-left text-xs">
                    <thead className="sticky top-0 bg-muted/80">
                      <tr>
                        <th className="px-2 py-1.5">ID</th>
                        <th className="px-2 py-1.5">Primitive</th>
                        <th className="px-2 py-1.5">Sev</th>
                        <th className="px-2 py-1.5">Conf</th>
                        <th className="px-2 py-1.5">Location</th>
                      </tr>
                    </thead>
                    <tbody>
                      {inventory.rows.map((row) => (
                        <tr key={row.id} className="border-t border-border/60">
                          <td className="px-2 py-1.5 font-mono">{row.id}</td>
                          <td className="px-2 py-1.5">{row.primitive}</td>
                          <td className="px-2 py-1.5">{row.severity}</td>
                          <td className="px-2 py-1.5 font-mono">
                            {(row.confidence * 100).toFixed(0)}%
                          </td>
                          <td className="px-2 py-1.5 font-mono text-muted-foreground">
                            {row.locations.slice(0, 2).join(" · ")}
                          </td>
                        </tr>
                      ))}
                    </tbody>
                  </table>
                </ScrollArea>
                {inventory.rows[0] ? (
                  <p className="text-sm text-muted-foreground">
                    {inventory.rows[0].recommendation}
                  </p>
                ) : null}
              </>
            ) : (
              <p className="text-sm text-muted-foreground">No inventory rows.</p>
            )}
          </TabsContent>
          <TabsContent value="ir" className="mt-3 space-y-2">
            {report.functions.length ? (
              <div className="flex flex-wrap gap-1">
                {report.functions.map((fn) => (
                  <Button
                    key={fn.name}
                    type="button"
                    size="xs"
                    variant={activeFn?.name === fn.name ? "default" : "outline"}
                    onClick={() => onSelectFn(fn.name)}
                    className="font-mono"
                  >
                    @{fn.name}
                  </Button>
                ))}
              </div>
            ) : null}
            {activeFn ? (
              <ScrollArea className="h-72 rounded-lg border border-border/80 bg-black/40">
                <pre className="p-3 font-mono text-[11px] leading-relaxed text-emerald-100/90">
                  {activeFn.ir}
                </pre>
              </ScrollArea>
            ) : (
              <p className="text-sm text-muted-foreground">
                No function selected.
              </p>
            )}
          </TabsContent>
          <TabsContent value="mix" className="mt-3">
            {activeFn ? (
              <OpcodeBars fn={activeFn} />
            ) : (
              <p className="text-sm text-muted-foreground">
                No function selected.
              </p>
            )}
          </TabsContent>
          <TabsContent value="fns" className="mt-3">
            {report.functions.length === 0 ? (
              <p className="text-sm text-muted-foreground">
                No <span className="font-mono">define</span> functions in this
                module.
              </p>
            ) : (
              <ul className="space-y-1">
                {report.functions.map((fn) => {
                  const tagged = report.findings.some((f) =>
                    f.functions.includes(fn.name),
                  );
                  return (
                    <li key={fn.name}>
                      <button
                        type="button"
                        onClick={() => onSelectFn(fn.name)}
                        className={cn(
                          "flex w-full items-center justify-between rounded-lg px-3 py-2 text-left text-sm transition-colors",
                          activeFn?.name === fn.name
                            ? "bg-muted"
                            : "hover:bg-muted/60",
                        )}
                      >
                        <span className="font-mono text-xs sm:text-sm">
                          @{fn.name}
                        </span>
                        <span className="flex items-center gap-2 text-[11px] text-muted-foreground">
                          {tagged ? (
                            <Badge variant="secondary">crypto</Badge>
                          ) : null}
                          {fn.blocks} bb · {fn.edges} br
                        </span>
                      </button>
                    </li>
                  );
                })}
              </ul>
            )}
          </TabsContent>
        </Tabs>
      </CardContent>
    </Card>
  );
}

function Stat({
  label,
  value,
  warn,
}: {
  label: string;
  value: string;
  warn?: boolean;
}) {
  return (
    <div className="rounded-lg border border-border/80 px-3 py-2">
      <p className="text-[11px] tracking-wide text-muted-foreground uppercase">
        {label}
      </p>
      <p
        className={cn(
          "font-mono text-xl",
          warn ? "text-amber-400" : "text-foreground",
        )}
      >
        {value}
      </p>
    </div>
  );
}

function SourceBadge({ source }: { source: Finding["source"] }) {
  if (source === "ml") return <Badge variant="secondary">model</Badge>;
  if (source === "binary")
    return (
      <Badge variant="outline" className="border-sky-500/40 text-sky-400">
        bytes
      </Badge>
    );
  return <Badge variant="outline">IR table</Badge>;
}

function SeverityBadge({ severity }: { severity: Finding["severity"] }) {
  if (severity === "weak")
    return <Badge variant="destructive">weak</Badge>;
  if (severity === "info") return <Badge variant="secondary">review</Badge>;
  return (
    <Badge variant="outline" className="border-emerald-500/40 text-emerald-400">
      expected
    </Badge>
  );
}

function OpcodeBars({ fn }: { fn: FunctionRecord }) {
  const entries = Object.entries(fn.opcodes)
    .filter(([, n]) => n > 0)
    .sort((a, b) => b[1] - a[1]);
  const max = Math.max(1, ...entries.map(([, n]) => n));
  if (!entries.length) {
    return (
      <p className="text-sm text-muted-foreground">No counted opcodes.</p>
    );
  }
  return (
    <ul className="space-y-2">
      {entries.map(([op, n]) => (
        <li key={op} className="grid grid-cols-[4.5rem_1fr_2rem] items-center gap-2">
          <span className="font-mono text-xs">{op}</span>
          <div className="h-2 overflow-hidden rounded-full bg-muted">
            <div
              className="h-full bg-emerald-500/80"
              style={{ width: `${(n / max) * 100}%` }}
            />
          </div>
          <span className="font-mono text-xs text-muted-foreground">{n}</span>
        </li>
      ))}
      <li className="pt-1 text-xs text-muted-foreground">
        bitwise density {fn.bitwiseDensity.toFixed(2)} · {fn.instructionCount}{" "}
        inst
      </li>
    </ul>
  );
}
