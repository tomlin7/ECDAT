"use client";

import { useCallback, useEffect, useMemo, useState } from "react";
import {
  AlertCircle,
  Binary,
  ChevronRight,
  FileCode2,
  Loader2,
  Search,
  ShieldAlert,
  Upload,
} from "lucide-react";
import {
  AppShell,
  EmptyState,
  FilterPill,
  Panel,
  SecondaryNav,
  TopBar,
  type AppView,
} from "@/components/ecdat/app-shell";
import { Alert, AlertDescription, AlertTitle } from "@/components/ui/alert";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { ScrollArea } from "@/components/ui/scroll-area";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Textarea } from "@/components/ui/textarea";
import type {
  AnalysisReport,
  EnterpriseInventory,
  Finding,
  FunctionRecord,
} from "@/lib/ir/types";
import { inventoryToHtml, inventoryToJson } from "@/lib/report";
import type { SampleMeta } from "@/lib/samples/catalog";
import { cn } from "@/lib/utils";

type FindingFilter = "all" | "weak" | "ir" | "bytes" | "ml";

export function Workbench() {
  const [view, setView] = useState<AppView>("discover");
  const [navSection, setNavSection] = useState("feed");
  const [findingFilter, setFindingFilter] = useState<FindingFilter>("all");
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
    setView("discover");
    setError(null);
  }, []);

  const runAnalysis = useCallback(
    async (source: string, name: string) => {
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
        setError("Could not reach the analyzer.");
      } finally {
        setLoading(false);
      }
    },
    [applyReport],
  );

  const runAnalysisBytes = useCallback(
    async (bytes: ArrayBuffer, name: string) => {
      setLoading(true);
      setError(null);
      try {
        const form = new FormData();
        form.append("file", new Blob([bytes]), name);
        const res = await fetch("/api/analyze", { method: "POST", body: form });
        await applyReport(res);
      } catch {
        setReport(null);
        setError("Could not reach the analyzer.");
      } finally {
        setLoading(false);
      }
    },
    [applyReport],
  );

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

  const filteredFindings = useMemo(() => {
    if (!report) return [];
    return report.findings.filter((f) => {
      if (findingFilter === "weak") return f.severity === "weak";
      if (findingFilter === "ir") return f.source === "signature";
      if (findingFilter === "bytes") return f.source === "binary";
      if (findingFilter === "ml") return f.source === "ml";
      return true;
    });
  }, [report, findingFilter]);

  const sidebar =
    view === "discover" ? (
      <SecondaryNav
        title="Discover"
        active={navSection}
        onSelect={setNavSection}
        items={[
          { id: "feed", label: "Feed", count: report?.findings.length },
          {
            id: "weak",
            label: "Weak / deprecated",
            count: report?.weakCount,
          },
          { id: "channels", label: "Channels", count: 3 },
        ]}
      />
    ) : view === "corpus" ? (
      <SecondaryNav
        title="Corpus"
        active={navSection}
        onSelect={setNavSection}
        items={[
          { id: "all", label: "All samples", count: samples.length },
          {
            id: "elf",
            label: "Binary (.o/.so)",
            count: samples.filter((s) => s.format === "elf").length,
          },
          {
            id: "ir",
            label: "LLVM IR",
            count: samples.filter((s) => s.format === "ir").length,
          },
        ]}
      />
    ) : view === "inventory" ? (
      <SecondaryNav
        title="Inventory"
        active={navSection}
        onSelect={setNavSection}
        items={[
          { id: "export", label: "Export" },
          { id: "metadata", label: "Asset metadata" },
        ]}
      />
    ) : (
      <SecondaryNav
        title="Ingest"
        active={navSection}
        onSelect={setNavSection}
        items={[
          { id: "upload", label: "Upload" },
          { id: "paste", label: "Paste IR" },
        ]}
      />
    );

  const topbar = (
    <TopBar
      title={
        view === "discover"
          ? report
            ? `Findings — ${report.filename}`
            : "Cryptographic discovery"
          : view === "ingest"
            ? "Ingest artifact"
            : view === "corpus"
              ? "Corpus samples"
              : "Enterprise inventory"
      }
      subtitle="SIH26164 · NTRO · ECDAT · static analysis only"
      actions={
        <>
          {loading ? (
            <Button size="sm" disabled>
              <Loader2 className="animate-spin" />
              Analyzing…
            </Button>
          ) : (
            <Button
              size="sm"
              onClick={() => {
                if (ir.trim()) void runAnalysis(ir, filename);
                else setView("ingest");
              }}
              disabled={!ir.trim() && view !== "ingest"}
            >
              <FileCode2 />
              Analyze
            </Button>
          )}
        </>
      }
      filters={
        view === "discover" && report ? (
          <>
            <FilterPill
              active={findingFilter === "all"}
              onClick={() => setFindingFilter("all")}
            >
              All
            </FilterPill>
            <FilterPill
              active={findingFilter === "weak"}
              onClick={() => setFindingFilter("weak")}
            >
              Weak
            </FilterPill>
            <FilterPill
              active={findingFilter === "ir"}
              onClick={() => setFindingFilter("ir")}
            >
              IR tables
            </FilterPill>
            <FilterPill
              active={findingFilter === "bytes"}
              onClick={() => setFindingFilter("bytes")}
            >
              Raw bytes
            </FilterPill>
            <FilterPill
              active={findingFilter === "ml"}
              onClick={() => setFindingFilter("ml")}
            >
              CFG model
            </FilterPill>
            <div className="ml-auto flex items-center gap-1.5 text-[11px] text-muted-foreground">
              <Search className="size-3.5" />
              <span className="font-mono">{report.ingest.kind}</span>
              <span>·</span>
              <span>{report.ingest.bytes} B</span>
            </div>
          </>
        ) : null
      }
    />
  );

  return (
    <AppShell
      view={view}
      onView={setView}
      topbar={topbar}
      sidebar={sidebar}
    >
      {error ? (
        <div className="p-4">
          <Alert variant="destructive">
            <AlertCircle />
            <AlertTitle>Analysis error</AlertTitle>
            <AlertDescription>{error}</AlertDescription>
          </Alert>
        </div>
      ) : null}

      {view === "ingest" ? (
        <IngestView
          ir={ir}
          filename={filename}
          loading={loading}
          dragOver={dragOver}
          onDragOver={setDragOver}
          onFile={onFile}
          onIrChange={setIr}
          onAnalyze={() => void runAnalysis(ir, filename)}
        />
      ) : null}

      {view === "corpus" ? (
        <CorpusView
          samples={samples}
          section={navSection}
          loading={loading}
          onLoad={loadSample}
        />
      ) : null}

      {view === "inventory" ? (
        <InventoryView
          inventory={patchedInventory}
          assetId={assetId}
          businessUnit={businessUnit}
          orgSite={orgSite}
          onAssetId={setAssetId}
          onBusinessUnit={setBusinessUnit}
          onOrgSite={setOrgSite}
        />
      ) : null}

      {view === "discover" ? (
        <DiscoverView
          loading={loading}
          report={report}
          findings={filteredFindings}
          selectedFinding={selectedFinding}
          activeFinding={activeFinding}
          activeFn={activeFn}
          onSelectFinding={(id) => {
            setSelectedFinding(id);
            const f = report?.findings.find((x) => x.id === id);
            if (f?.functions[0]) setSelectedFn(f.functions[0]);
          }}
          onSelectFn={setSelectedFn}
          onGoIngest={() => setView("ingest")}
          onLoadDemo={() => void loadSample("enterprise_mix")}
        />
      ) : null}
    </AppShell>
  );
}

function IngestView({
  ir,
  filename,
  loading,
  dragOver,
  onDragOver,
  onFile,
  onIrChange,
  onAnalyze,
}: {
  ir: string;
  filename: string;
  loading: boolean;
  dragOver: boolean;
  onDragOver: (v: boolean) => void;
  onFile: (f: File) => void;
  onIrChange: (v: string) => void;
  onAnalyze: () => void;
}) {
  return (
    <div className="mx-auto max-w-3xl p-6">
      <Panel className="p-6">
        <h2 className="text-[15px] font-semibold">Upload or paste</h2>
        <p className="mt-1 text-[13px] text-muted-foreground">
          LLVM IR, ELF/PE objects, or Clang{" "}
          <span className="font-mono">.o</span> /{" "}
          <span className="font-mono">.so</span>. Max 8 MB.
        </p>
        <label
          onDragOver={(e) => {
            e.preventDefault();
            onDragOver(true);
          }}
          onDragLeave={() => onDragOver(false)}
          onDrop={(e) => {
            e.preventDefault();
            onDragOver(false);
            const file = e.dataTransfer.files[0];
            if (file) void onFile(file);
          }}
          className={cn(
            "mt-4 flex cursor-pointer flex-col items-center justify-center gap-2 rounded-md border border-dashed px-4 py-10 text-center transition-colors",
            dragOver
              ? "border-primary bg-primary/10"
              : "border-border bg-[#1a1a23] hover:border-primary/40",
          )}
        >
          <Upload className="size-5 text-muted-foreground" />
          <span className="text-[13px]">
            Drop <span className="font-mono">.ll / .o / ELF / PE</span> or
            browse
          </span>
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
        <Textarea
          value={ir}
          onChange={(e) => onIrChange(e.target.value)}
          placeholder={"; ModuleID = 'module'\ndefine i32 @main() {\n  ret i32 0\n}"}
          className="mt-4 min-h-40 border-border bg-[#1a1a23] font-mono text-[12px]"
        />
        <div className="mt-3 flex items-center justify-between">
          <span className="font-mono text-[11px] text-muted-foreground">
            {filename}
            {ir ? ` · ${(ir.length / 1024).toFixed(1)} KB` : ""}
          </span>
          <Button onClick={onAnalyze} disabled={loading || !ir.trim()}>
            {loading ? <Loader2 className="animate-spin" /> : <FileCode2 />}
            Analyze IR
          </Button>
        </div>
      </Panel>
    </div>
  );
}

function CorpusView({
  samples,
  section,
  loading,
  onLoad,
}: {
  samples: SampleMeta[];
  section: string;
  loading: boolean;
  onLoad: (id: string) => void;
}) {
  const filtered = samples.filter((s) => {
    if (section === "elf") return s.format === "elf";
    if (section === "ir") return s.format === "ir";
    return true;
  });

  return (
    <div className="p-6">
      <div className="grid gap-2 sm:grid-cols-2 lg:grid-cols-3">
        {filtered.map((s) => (
          <button
            key={s.id}
            type="button"
            disabled={loading}
            onClick={() => void onLoad(s.id)}
            className="group rounded-lg border border-border bg-[#1e1e29] p-4 text-left transition-colors hover:border-primary/40 hover:bg-[#24242f]"
          >
            <div className="flex items-start justify-between gap-2">
              <span className="text-[13px] font-medium text-foreground">
                {s.title}
              </span>
              <Badge variant="outline" className="shrink-0">
                {s.format}
              </Badge>
            </div>
            <p className="mt-2 text-[12px] leading-relaxed text-muted-foreground">
              {s.blurb}
            </p>
            <p className="mt-2 font-mono text-[10px] text-muted-foreground">
              {s.expected.length
                ? s.expected.join(" · ")
                : "negative control"}
            </p>
            <ChevronRight className="mt-2 size-4 text-muted-foreground opacity-0 transition-opacity group-hover:opacity-100" />
          </button>
        ))}
      </div>
    </div>
  );
}

function DiscoverView({
  loading,
  report,
  findings,
  selectedFinding,
  activeFinding,
  activeFn,
  onSelectFinding,
  onSelectFn,
  onGoIngest,
  onLoadDemo,
}: {
  loading: boolean;
  report: AnalysisReport | null;
  findings: Finding[];
  selectedFinding: string | null;
  activeFinding: Finding | null;
  activeFn: FunctionRecord | null;
  onSelectFinding: (id: string) => void;
  onSelectFn: (name: string) => void;
  onGoIngest: () => void;
  onLoadDemo: () => void;
}) {
  if (loading && !report) {
    return (
      <div className="flex h-full items-center justify-center text-muted-foreground">
        <Loader2 className="mr-2 size-5 animate-spin" />
        Walking IR, matching constant tables…
      </div>
    );
  }

  if (!report) {
    return (
      <EmptyState
        title="Get started with ECDAT"
        description="Upload LLVM IR or a stripped binary to discover AES, SHA, TLS, RSA-shaped modexp, and weak primitives — with evidence from three static channels."
        action={
          <div className="flex flex-wrap justify-center gap-2">
            <Button onClick={onGoIngest}>
              <Upload />
              Upload artifact
            </Button>
            <Button variant="outline" onClick={onLoadDemo}>
              <Binary />
              Load enterprise mix
            </Button>
          </div>
        }
      />
    );
  }

  return (
    <div className="flex h-full min-h-0">
      {/* Issue list */}
      <div className="flex w-[360px] shrink-0 flex-col border-r border-border">
        <div className="grid grid-cols-3 gap-px border-b border-border bg-border">
          <MetricCell label="Functions" value={String(report.functionCount)} />
          <MetricCell label="Primitives" value={String(report.findings.length)} />
          <MetricCell
            label="Weak"
            value={String(report.weakCount)}
            warn={report.weakCount > 0}
          />
        </div>
        <ScrollArea className="flex-1">
          {findings.length === 0 ? (
            <p className="p-4 text-[13px] text-muted-foreground">
              No findings match this filter.
            </p>
          ) : (
            <ul>
              {findings.map((f) => (
                <li key={f.id}>
                  <button
                    type="button"
                    onClick={() => onSelectFinding(f.id)}
                    className={cn(
                      "flex w-full gap-3 border-b border-border px-4 py-3 text-left transition-colors",
                      selectedFinding === f.id
                        ? "bg-primary/10"
                        : "hover:bg-[#1e1e29]",
                    )}
                  >
                    <SeverityDot severity={f.severity} />
                    <div className="min-w-0 flex-1">
                      <div className="flex items-start justify-between gap-2">
                        <p className="truncate text-[13px] font-medium text-foreground">
                          {f.primitive}
                        </p>
                        <span className="shrink-0 font-mono text-[11px] text-muted-foreground">
                          {(f.confidence * 100).toFixed(0)}%
                        </span>
                      </div>
                      <p className="mt-0.5 truncate text-[12px] text-muted-foreground">
                        {f.title}
                      </p>
                      <div className="mt-1.5 flex flex-wrap gap-1">
                        <SourceBadge source={f.source} />
                        {f.severity === "weak" ? (
                          <Badge variant="warning">weak</Badge>
                        ) : null}
                      </div>
                    </div>
                  </button>
                </li>
              ))}
            </ul>
          )}
        </ScrollArea>
      </div>

      {/* Detail */}
      <div className="min-w-0 flex-1 overflow-auto p-5">
        {activeFinding ? (
          <FindingDetail
            report={report}
            finding={activeFinding}
            activeFn={activeFn}
            onSelectFn={onSelectFn}
          />
        ) : (
          <p className="text-[13px] text-muted-foreground">
            Select a finding from the feed.
          </p>
        )}
      </div>
    </div>
  );
}

function FindingDetail({
  report,
  finding,
  activeFn,
  onSelectFn,
}: {
  report: AnalysisReport;
  finding: Finding;
  activeFn: FunctionRecord | null;
  onSelectFn: (name: string) => void;
}) {
  return (
    <div className="space-y-4">
      <div>
        <div className="flex flex-wrap items-center gap-2">
          <h2 className="text-lg font-semibold">{finding.primitive}</h2>
          <SeverityBadge severity={finding.severity} />
          <SourceBadge source={finding.source} />
          <span className="font-mono text-[12px] text-muted-foreground">
            {finding.id} · {(finding.confidence * 100).toFixed(0)}% confidence
          </span>
        </div>
        <p className="mt-2 text-[13px] text-muted-foreground">
          {finding.rationale}
        </p>
        {report.targetTriple ? (
          <p className="mt-1 font-mono text-[11px] text-muted-foreground">
            {report.targetTriple}
            {report.ml
              ? ` · holdout ${(report.ml.holdoutAccuracy * 100).toFixed(0)}%`
              : ""}
          </p>
        ) : null}
      </div>

      <Tabs defaultValue="evidence">
        <TabsList variant="line">
          <TabsTrigger value="evidence">Evidence</TabsTrigger>
          <TabsTrigger value="ir">Function IR</TabsTrigger>
          <TabsTrigger value="mix">Opcode mix</TabsTrigger>
        </TabsList>
        <TabsContent value="evidence" className="mt-4 space-y-3">
          {finding.evidence.map((ev, i) => (
            <Panel key={`${ev.summary}-${i}`} className="p-4">
              <p className="text-[11px] font-semibold tracking-wide text-muted-foreground uppercase">
                {ev.kind}
                {ev.line ? ` · line ${ev.line}` : ""}
                {ev.offset != null
                  ? ` · offset 0x${ev.offset.toString(16)}`
                  : ""}
              </p>
              <p className="mt-2 text-[13px]">{ev.summary}</p>
              {ev.snippet ? (
                <pre className="mt-2 overflow-x-auto rounded-md border border-border bg-[#12121a] p-3 font-mono text-[11px] text-[#c4b5fd]">
                  {ev.snippet}
                </pre>
              ) : null}
            </Panel>
          ))}
          {finding.notes.length ? (
            <Alert>
              <ShieldAlert />
              <AlertTitle>Posture notes</AlertTitle>
              <AlertDescription>
                <ul className="list-disc space-y-1 pl-4">
                  {finding.notes.map((n) => (
                    <li key={n}>{n}</li>
                  ))}
                </ul>
              </AlertDescription>
            </Alert>
          ) : null}
        </TabsContent>
        <TabsContent value="ir" className="mt-4 space-y-2">
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
            <ScrollArea className="h-80 rounded-md border border-border bg-[#12121a]">
              <pre className="p-4 font-mono text-[11px] leading-relaxed text-[#c4b5fd]">
                {activeFn.ir}
              </pre>
            </ScrollArea>
          ) : (
            <p className="text-[13px] text-muted-foreground">
              No function selected.
            </p>
          )}
        </TabsContent>
        <TabsContent value="mix" className="mt-4">
          {activeFn ? (
            <OpcodeBars fn={activeFn} />
          ) : (
            <p className="text-[13px] text-muted-foreground">
              No function selected.
            </p>
          )}
        </TabsContent>
      </Tabs>
    </div>
  );
}

function InventoryView({
  inventory,
  assetId,
  businessUnit,
  orgSite,
  onAssetId,
  onBusinessUnit,
  onOrgSite,
}: {
  inventory: EnterpriseInventory | null;
  assetId: string;
  businessUnit: string;
  orgSite: string;
  onAssetId: (v: string) => void;
  onBusinessUnit: (v: string) => void;
  onOrgSite: (v: string) => void;
}) {
  if (!inventory) {
    return (
      <EmptyState
        title="No inventory yet"
        description="Run an analysis first — then tag the asset and export a JSON or HTML cryptographic inventory report."
      />
    );
  }

  return (
    <div className="p-6">
      <div className="grid gap-6 lg:grid-cols-[minmax(0,1fr)_minmax(0,1.4fr)]">
        <Panel className="p-5">
          <h2 className="text-[15px] font-semibold">Asset metadata</h2>
          <div className="mt-4 space-y-3">
            <label className="block space-y-1">
              <span className="text-[11px] font-medium text-muted-foreground uppercase">
                Asset ID
              </span>
              <Input
                className="font-mono"
                value={assetId}
                onChange={(e) => onAssetId(e.target.value)}
              />
            </label>
            <label className="block space-y-1">
              <span className="text-[11px] font-medium text-muted-foreground uppercase">
                Business unit
              </span>
              <Input
                value={businessUnit}
                onChange={(e) => onBusinessUnit(e.target.value)}
              />
            </label>
            <label className="block space-y-1">
              <span className="text-[11px] font-medium text-muted-foreground uppercase">
                Org site
              </span>
              <Input
                value={orgSite}
                onChange={(e) => onOrgSite(e.target.value)}
                placeholder="dc-east / firmware/build-42"
              />
            </label>
          </div>
          <div className="mt-5 flex flex-wrap gap-2">
            <Button
              size="sm"
              variant="outline"
              onClick={() => downloadBlob(inventoryToJson(inventory), "application/json", `${inventory.assetId}-inventory.json`)}
            >
              Export JSON
            </Button>
            <Button
              size="sm"
              onClick={() => downloadBlob(inventoryToHtml(inventory), "text/html", `${inventory.assetId}-inventory.html`)}
            >
              Export HTML
            </Button>
          </div>
        </Panel>

        <Panel className="overflow-hidden">
          <div className="border-b border-border px-4 py-3">
            <h2 className="text-[15px] font-semibold">Cryptographic inventory</h2>
            <p className="text-[12px] text-muted-foreground">
              {inventory.primitiveCount} primitives · {inventory.weakCount} weak
            </p>
          </div>
          <ScrollArea className="h-[420px]">
            <table className="w-full text-left text-[12px]">
              <thead className="sticky top-0 bg-[#24242f] text-[11px] text-muted-foreground uppercase">
                <tr>
                  <th className="px-4 py-2 font-medium">ID</th>
                  <th className="px-4 py-2 font-medium">Primitive</th>
                  <th className="px-4 py-2 font-medium">Sev</th>
                  <th className="px-4 py-2 font-medium">Conf</th>
                  <th className="px-4 py-2 font-medium">Location</th>
                </tr>
              </thead>
              <tbody>
                {inventory.rows.map((row) => (
                  <tr
                    key={row.id}
                    className="border-t border-border hover:bg-[#24242f]/50"
                  >
                    <td className="px-4 py-2.5 font-mono">{row.id}</td>
                    <td className="px-4 py-2.5">{row.primitive}</td>
                    <td className="px-4 py-2.5">
                      <SeverityBadge severity={row.severity} />
                    </td>
                    <td className="px-4 py-2.5 font-mono">
                      {(row.confidence * 100).toFixed(0)}%
                    </td>
                    <td className="max-w-[200px] truncate px-4 py-2.5 font-mono text-muted-foreground">
                      {row.locations.slice(0, 2).join(" · ")}
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </ScrollArea>
        </Panel>
      </div>
    </div>
  );
}

function MetricCell({
  label,
  value,
  warn,
}: {
  label: string;
  value: string;
  warn?: boolean;
}) {
  return (
    <div className="bg-[#1e1e29] px-3 py-2.5">
      <p className="text-[10px] font-medium tracking-wide text-muted-foreground uppercase">
        {label}
      </p>
      <p
        className={cn(
          "mt-0.5 font-mono text-lg",
          warn ? "text-[#f5a623]" : "text-foreground",
        )}
      >
        {value}
      </p>
    </div>
  );
}

function SeverityDot({ severity }: { severity: Finding["severity"] }) {
  const color =
    severity === "weak"
      ? "bg-[#f55459]"
      : severity === "info"
        ? "bg-[#57bcf0]"
        : "bg-[#57d9a3]";
  return <span className={cn("mt-1.5 size-2 shrink-0 rounded-full", color)} />;
}

function SourceBadge({ source }: { source: Finding["source"] }) {
  if (source === "ml") return <Badge variant="info">model</Badge>;
  if (source === "binary") return <Badge variant="secondary">bytes</Badge>;
  return <Badge variant="outline">IR</Badge>;
}

function SeverityBadge({ severity }: { severity: Finding["severity"] }) {
  if (severity === "weak") return <Badge variant="warning">weak</Badge>;
  if (severity === "info") return <Badge variant="info">review</Badge>;
  return <Badge variant="success">ok</Badge>;
}

function OpcodeBars({ fn }: { fn: FunctionRecord }) {
  const entries = Object.entries(fn.opcodes)
    .filter(([, n]) => n > 0)
    .sort((a, b) => b[1] - a[1]);
  const max = Math.max(1, ...entries.map(([, n]) => n));
  if (!entries.length) {
    return (
      <p className="text-[13px] text-muted-foreground">No counted opcodes.</p>
    );
  }
  return (
    <ul className="space-y-2">
      {entries.map(([op, n]) => (
        <li
          key={op}
          className="grid grid-cols-[4.5rem_1fr_2rem] items-center gap-2"
        >
          <span className="font-mono text-[11px]">{op}</span>
          <div className="h-1.5 overflow-hidden rounded-full bg-[#2a2a35]">
            <div
              className="h-full bg-primary"
              style={{ width: `${(n / max) * 100}%` }}
            />
          </div>
          <span className="font-mono text-[11px] text-muted-foreground">
            {n}
          </span>
        </li>
      ))}
      <li className="pt-1 text-[11px] text-muted-foreground">
        bitwise density {fn.bitwiseDensity.toFixed(2)} · {fn.instructionCount}{" "}
        inst
      </li>
    </ul>
  );
}

function downloadBlob(content: string, mime: string, filename: string) {
  const blob = new Blob([content], { type: mime });
  const url = URL.createObjectURL(blob);
  const a = document.createElement("a");
  a.href = url;
  a.download = filename.replace(/[^a-z0-9._-]+/gi, "_");
  a.click();
  URL.revokeObjectURL(url);
}
