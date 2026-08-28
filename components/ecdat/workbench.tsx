"use client";

import { useCallback, useEffect, useMemo, useState } from "react";
import {
  AlertCircle,
  Binary,
  ChevronRight,
  FileCode2,
  Loader2,
  ShieldAlert,
  Upload,
} from "lucide-react";
import {
  AppShell,
  PreviewCard,
  SetupCard,
  StepCircle,
  WorkbenchPanel,
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

  const secondaryConfig = useMemo(() => {
    if (view === "discover") {
      return {
        title: "Discover",
        items: [
          { id: "feed", label: "Feed" },
          { id: "weak", label: "Weak / deprecated" },
          { id: "channels", label: "Channels" },
        ],
      };
    }
    if (view === "corpus") {
      return {
        title: "Corpus",
        items: [
          { id: "all", label: "All samples" },
          { id: "elf", label: "Binary (.o/.so)" },
          { id: "ir", label: "LLVM IR" },
        ],
      };
    }
    if (view === "inventory") {
      return {
        title: "Inventory",
        items: [
          { id: "export", label: "Export" },
          { id: "metadata", label: "Asset metadata" },
        ],
      };
    }
    return {
      title: "Ingest",
      items: [
        { id: "upload", label: "Upload" },
        { id: "paste", label: "Paste IR" },
      ],
    };
  }, [view]);

  const breadcrumb =
    view === "discover"
      ? report
        ? `Feed / ${report.filename}`
        : "Feed"
      : view === "ingest"
        ? "Ingest"
        : view === "corpus"
          ? "Corpus"
          : "Inventory";

  const shellActions =
    loading ? (
      <button type="button" className="btn-tactile-primary h-8 px-3" disabled>
        <Loader2 className="size-3.5 animate-spin" />
        Analyzing…
      </button>
    ) : (
      <button
        type="button"
        className="btn-tactile-primary h-8 px-3"
        onClick={() => {
          if (ir.trim()) void runAnalysis(ir, filename);
          else setView("ingest");
        }}
      >
        Save as
      </button>
    );

  return (
    <AppShell
      view={view}
      onView={setView}
      secondaryTitle={secondaryConfig.title}
      secondaryItems={secondaryConfig.items}
      secondaryActive={navSection}
      onSecondarySelect={setNavSection}
      breadcrumb={breadcrumb}
      actions={shellActions}
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
      <SetupCard className="p-6">
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
      </SetupCard>
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
      <WorkbenchPanel>
        <div className="mb-6">
          <h1 className="text-[22px] font-bold text-white">
            Get Started with ECDAT
          </h1>
          <p className="mt-1 text-[13px] text-[#c4c1d2]">
            Upload LLVM IR or a stripped binary to discover AES, SHA, TLS,
            RSA-shaped modexp, and weak primitives — with evidence from three
            static channels.
          </p>
        </div>
        <div className="grid gap-4 lg:grid-cols-2">
          <SetupCard>
            <h2 className="text-[15px] font-semibold text-white">
              Set up the ECDAT analyzer
            </h2>
            <div className="mt-5 flex gap-3">
              <StepCircle n={1} active />
              <div className="min-w-0 flex-1">
                <p className="text-[13px] font-semibold text-white">Install</p>
                <p className="mt-1 text-[12px] text-[#a09aab]">
                  Upload an artifact or load a corpus sample:
                </p>
                <div className="mt-3 overflow-hidden rounded-lg border border-[#34343f] bg-[#1a1a22]">
                  <div className="flex items-center justify-between border-b border-[#34343f] px-3 py-1.5">
                    <span className="text-[11px] text-[#8b8794]">cli</span>
                    <button
                      type="button"
                      className="text-[11px] text-[#a78bfa] hover:underline"
                    >
                      Copy instructions
                    </button>
                  </div>
                  <pre className="overflow-x-auto p-3 font-mono text-[12px] text-[#c4b5fd]">
                    curl -F file=@artifact.o /api/analyze
                  </pre>
                </div>
                <div className="mt-4 flex flex-wrap gap-2">
                  <Button onClick={onGoIngest}>
                    <Upload />
                    Upload artifact
                  </Button>
                  <Button variant="tactile" onClick={onLoadDemo}>
                    <Binary />
                    Load enterprise mix
                  </Button>
                </div>
              </div>
            </div>
            <div className="mt-6 flex items-center gap-3 opacity-50">
              <StepCircle n={2} />
              <span className="text-[13px] text-[#8b8794]">Configure asset metadata</span>
            </div>
            <div className="mt-3 flex items-center gap-3 opacity-50">
              <StepCircle n={3} />
              <span className="text-[13px] text-[#8b8794]">Verify findings & export inventory</span>
            </div>
          </SetupCard>

          <div>
            <h2 className="mb-3 text-[15px] font-semibold text-white">
              Preview a cryptographic finding
            </h2>
            <PreviewCard>
              <PreviewIssueList />
              <div className="flex items-center justify-between bg-[#6c5fc7] px-4 py-2 text-[12px] font-medium text-white">
                <span>1/3 · Select a finding</span>
                <span className="opacity-80">← →</span>
              </div>
            </PreviewCard>
          </div>
        </div>
      </WorkbenchPanel>
    );
  }

  return (
    <WorkbenchPanel className="flex h-full min-h-0 flex-col p-0">
      <div className="flex min-h-0 flex-1 flex-col lg:flex-row">
        <div className="flex w-full shrink-0 flex-col border-b border-[#34343f] lg:w-[360px] lg:border-r lg:border-b-0">
          <div className="grid grid-cols-3 gap-px border-b border-[#34343f] bg-[#34343f]">
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
              <p className="p-4 text-[13px] text-[#c4c1d2]">
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
                        "flex w-full gap-3 border-b border-[#34343f] px-4 py-3 text-left transition-colors",
                        selectedFinding === f.id
                          ? "bg-[#6c5fc7]/20"
                          : "hover:bg-[#24242c]",
                      )}
                    >
                      <SeverityDot severity={f.severity} />
                      <div className="min-w-0 flex-1">
                        <div className="flex items-start justify-between gap-2">
                          <p className="truncate text-[13px] font-medium text-white">
                            {f.primitive}
                          </p>
                          <span className="shrink-0 font-mono text-[11px] text-[#8b8794]">
                            {(f.confidence * 100).toFixed(0)}%
                          </span>
                        </div>
                        <p className="mt-0.5 truncate text-[12px] text-[#a09aab]">
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

        <div className="min-w-0 flex-1 overflow-auto p-5">
          {activeFinding ? (
            <PreviewCard>
              <div className="p-4">
                <FindingDetail
                  report={report}
                  finding={activeFinding}
                  activeFn={activeFn}
                  onSelectFn={onSelectFn}
                />
              </div>
            </PreviewCard>
          ) : (
            <p className="text-[13px] text-[#c4c1d2]">
              Select a finding from the feed.
            </p>
          )}
        </div>
      </div>
    </WorkbenchPanel>
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
            <SetupCard key={`${ev.summary}-${i}`} className="p-4">
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
            </SetupCard>
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
      <WorkbenchPanel>
        <h2 className="text-[18px] font-semibold text-white">No inventory yet</h2>
        <p className="mt-2 max-w-lg text-[13px] text-[#c4c1d2]">
          Run an analysis first — then tag the asset and export a JSON or HTML
          cryptographic inventory report.
        </p>
      </WorkbenchPanel>
    );
  }

  return (
    <div className="p-6">
      <div className="grid gap-6 lg:grid-cols-[minmax(0,1fr)_minmax(0,1.4fr)]">
        <SetupCard className="p-5">
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
        </SetupCard>

        <SetupCard className="overflow-hidden">
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
        </SetupCard>
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

function PreviewIssueList() {
  const rows = [
    {
      dot: "bg-[#6c5fc7]",
      title: "AES-256-GCM",
      path: "enterprise_mix_stripped.o",
      badge: "IR table",
      trend: [2, 4, 3, 6, 5, 8, 7],
      status: "Ongoing",
    },
    {
      dot: "bg-[#f55459]",
      title: "MD5",
      path: "vendor_openssl_aes_stripped.o",
      badge: "weak",
      trend: [1, 1, 2, 1, 3, 2, 4],
      status: "Escalating",
    },
    {
      dot: "bg-[#57bcf0]",
      title: "TLS stack",
      path: "pe_tls_blob.exe",
      badge: "bytes",
      trend: [3, 2, 4, 3, 2, 3, 2],
      status: "Ongoing",
    },
  ];

  return (
    <ul>
      {rows.map((row) => (
        <li
          key={row.title}
          className="flex items-center gap-3 border-b border-[#ececf0] px-4 py-3 last:border-b-0"
        >
          <span className={cn("size-2 shrink-0 rounded-full", row.dot)} />
          <div className="min-w-0 flex-1">
            <p className="truncate text-[13px] font-medium">{row.title}</p>
            <p className="truncate text-[11px] text-[#6b6b76]">{row.path}</p>
            <span className="mt-1 inline-block rounded bg-[#f0f0f4] px-1.5 py-0.5 text-[10px] font-medium text-[#4a4a55]">
              {row.badge}
            </span>
          </div>
          <div className="flex shrink-0 flex-col items-end gap-1">
            <Sparkline values={row.trend} />
            <span className="text-[10px] text-[#8b8794]">{row.status}</span>
          </div>
        </li>
      ))}
    </ul>
  );
}

function Sparkline({ values }: { values: number[] }) {
  const max = Math.max(...values, 1);
  return (
    <div className="flex h-5 items-end gap-px">
      {values.map((v, i) => (
        <div
          key={i}
          className="w-[3px] rounded-sm bg-[#6c5fc7]/70"
          style={{ height: `${(v / max) * 100}%`, minHeight: 2 }}
        />
      ))}
    </div>
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
