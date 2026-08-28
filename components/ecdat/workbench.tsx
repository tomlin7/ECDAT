"use client";

import { useCallback, useEffect, useMemo, useState } from "react";
import {
  AlertCircle,
  ChevronDown,
  ChevronRight,
  ChevronUp,
  FileCode2,
  Loader2,
  ShieldAlert,
  Upload,
} from "lucide-react";
import {
  AppShell,
  FilterChip,
  SetupCard,
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
  const [searchQuery, setSearchQuery] = useState("");
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
    const q = searchQuery.trim().toLowerCase();
    return report.findings.filter((f) => {
      if (findingFilter === "weak") return f.severity === "weak";
      if (findingFilter === "ir") return f.source === "signature";
      if (findingFilter === "bytes") return f.source === "binary";
      if (findingFilter === "ml") return f.source === "ml";
      if (!q) return true;
      return (
        f.primitive.toLowerCase().includes(q) ||
        f.title.toLowerCase().includes(q) ||
        f.id.toLowerCase().includes(q)
      );
    });
  }, [report, findingFilter, searchQuery]);

  const channelCounts = useMemo(() => {
    if (!report) return { ir: 0, bytes: 0, ml: 0 };
    return {
      ir: report.findings.filter((f) => f.source === "signature").length,
      bytes: report.findings.filter((f) => f.source === "binary").length,
      ml: report.findings.filter((f) => f.source === "ml").length,
    };
  }, [report]);

  function handleViewChange(next: AppView) {
    setView(next);
    if (next === "discover") setNavSection("feed");
    if (next === "corpus") setNavSection("all");
    if (next === "inventory") setNavSection("export");
    if (next === "ingest") setNavSection("upload");
  }

  function handleSecondarySelect(id: string) {
    setNavSection(id);
    if (view === "discover") {
      if (id === "feed") setFindingFilter("all");
      if (id === "weak") setFindingFilter("weak");
      if (id === "ir") setFindingFilter("ir");
      if (id === "bytes") setFindingFilter("bytes");
      if (id === "ml") setFindingFilter("ml");
    }
  }

  const secondaryConfig = useMemo(() => {
    if (view === "discover") {
      return {
        title: "Findings",
        items: [
          { id: "feed", label: "All findings", count: report?.findings.length },
          { id: "weak", label: "Weak / deprecated", count: report?.weakCount },
          { id: "ir", label: "IR signatures", count: channelCounts.ir },
          { id: "bytes", label: "Raw-byte scan", count: channelCounts.bytes },
          { id: "ml", label: "CFG model", count: channelCounts.ml },
        ],
      };
    }
    if (view === "corpus") {
      return {
        title: "Corpus",
        items: [
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
        ],
      };
    }
    if (view === "inventory") {
      return {
        title: "Inventory",
        items: [
          { id: "export", label: "Export report" },
          { id: "metadata", label: "Asset metadata" },
        ],
      };
    }
    return {
      title: "Ingest",
      items: [
        { id: "upload", label: "Upload file" },
        { id: "paste", label: "Paste IR" },
      ],
    };
  }, [view, report, samples, channelCounts]);

  const breadcrumb =
    view === "discover"
      ? report
        ? report.filename
        : "No artifact loaded"
      : view === "ingest"
        ? "Ingest artifact"
        : view === "corpus"
          ? "Evaluation corpus"
          : "Enterprise inventory";

  const toolbarMeta = report ? (
  <>
      <span className="btn-tactile h-8 px-2.5 font-mono text-[12px]">
        {report.ingest.kind}
      </span>
      <span className="btn-tactile h-8 px-2.5 font-mono text-[12px]">
        {report.ingest.bytes.toLocaleString()} B
      </span>
      <span className="btn-tactile h-8 px-2.5 text-[12px]">
        {report.findings.length} primitives
      </span>
    </>
  ) : null;

  const toolbarFilters =
    view === "discover" && report ? (
      <>
        <FilterChip
          label="All"
          active={findingFilter === "all" && navSection === "feed"}
          onClick={() => {
            setNavSection("feed");
            setFindingFilter("all");
          }}
        />
        <FilterChip
          label="Weak"
          active={findingFilter === "weak"}
          onClick={() => {
            setNavSection("weak");
            setFindingFilter("weak");
          }}
        />
      </>
    ) : null;

  const shellActions = loading ? (
    <button type="button" className="btn-tactile-primary h-8 px-3" disabled>
      <Loader2 className="size-3.5 animate-spin" />
      Analyzing…
    </button>
  ) : view === "inventory" && patchedInventory ? (
    <>
      <Button
        size="sm"
        variant="tactile"
        onClick={() =>
          downloadBlob(
            inventoryToJson(patchedInventory),
            "application/json",
            `${patchedInventory.assetId}-inventory.json`,
          )
        }
      >
        Export JSON
      </Button>
      <Button
        size="sm"
        onClick={() =>
          downloadBlob(
            inventoryToHtml(patchedInventory),
            "text/html",
            `${patchedInventory.assetId}-inventory.html`,
          )
        }
      >
        Export HTML
      </Button>
    </>
  ) : view === "ingest" && ir.trim() ? (
    <Button size="sm" onClick={() => void runAnalysis(ir, filename)}>
      <FileCode2 />
      Analyze
    </Button>
  ) : report ? (
    <Button size="sm" onClick={() => handleViewChange("inventory")}>
      View inventory
    </Button>
  ) : (
    <Button size="sm" onClick={() => handleViewChange("ingest")}>
      <Upload />
      Upload artifact
    </Button>
  );

  return (
    <AppShell
      view={view}
      onView={handleViewChange}
      secondaryTitle={secondaryConfig.title}
      secondaryItems={secondaryConfig.items}
      secondaryActive={navSection}
      onSecondarySelect={handleSecondarySelect}
      breadcrumb={breadcrumb}
      searchQuery={searchQuery}
      onSearchChange={setSearchQuery}
      searchPlaceholder={
        view === "discover"
          ? "Filter by primitive or title…"
          : view === "corpus"
            ? "Filter samples…"
            : "Search…"
      }
      meta={toolbarMeta}
      toolbarFilters={toolbarFilters}
      actions={shellActions}
      footerAction={
        patchedInventory
          ? {
              label: "Export inventory",
              onClick: () => handleViewChange("inventory"),
            }
          : {
              label: "Analyze an artifact",
              onClick: () => handleViewChange("ingest"),
            }
      }
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
          section={navSection}
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
          searchQuery={searchQuery}
          loading={loading}
          onLoad={loadSample}
        />
      ) : null}

      {view === "inventory" ? (
        <InventoryView
          inventory={patchedInventory}
          section={navSection}
          assetId={assetId}
          businessUnit={businessUnit}
          orgSite={orgSite}
          onAssetId={setAssetId}
          onBusinessUnit={setBusinessUnit}
          onOrgSite={setOrgSite}
          onGoAnalyze={() => handleViewChange("ingest")}
        />
      ) : null}

      {view === "discover" ? (
        <DiscoverView
          loading={loading}
          report={report}
          findings={filteredFindings}
          samples={samples}
          selectedFinding={selectedFinding}
          activeFinding={activeFinding}
          activeFn={activeFn}
          channelCounts={channelCounts}
          onSelectFinding={(id) => {
            setSelectedFinding(id);
            const f = report?.findings.find((x) => x.id === id);
            if (f?.functions[0]) setSelectedFn(f.functions[0]);
          }}
          onSelectFn={setSelectedFn}
          onGoIngest={() => handleViewChange("ingest")}
          onGoCorpus={() => handleViewChange("corpus")}
          onLoadSample={loadSample}
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
  section,
  onDragOver,
  onFile,
  onIrChange,
  onAnalyze,
}: {
  ir: string;
  filename: string;
  loading: boolean;
  dragOver: boolean;
  section: string;
  onDragOver: (v: boolean) => void;
  onFile: (f: File) => void;
  onIrChange: (v: string) => void;
  onAnalyze: () => void;
}) {
  const [irExpanded, setIrExpanded] = useState(true);
  const showUpload = section !== "paste";
  const showPaste = section !== "upload";
  const lineCount = ir ? ir.split("\n").length : 0;
  const irPreview = ir.trim().split("\n")[0] ?? "";

  useEffect(() => {
    if (section === "paste" && ir.trim()) setIrExpanded(true);
  }, [section, ir]);

  return (
    <div className="mx-auto max-w-3xl">
      <WorkbenchPanel>
        <h2 className="text-[18px] font-semibold text-white">Ingest artifact</h2>
        <p className="mt-1 text-[13px] text-[#c4c1d2]">
          LLVM IR, ELF/PE objects, or Clang{" "}
          <span className="font-mono">.o</span> /{" "}
          <span className="font-mono">.so</span>. Max 8 MB. Analysis runs three
          static channels: IR constant tables, CFG softmax, and raw-byte scan.
        </p>
        {showUpload ? (
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
            <Upload className="size-5 text-[#8b8794]" />
            <span className="text-[13px] text-[#c4c1d2]">
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
        ) : null}
        {showPaste ? (
          <>
            <div className="mt-4 overflow-hidden rounded-lg border border-[#34343f]">
              <div className="flex items-center justify-between gap-3 border-b border-[#34343f] bg-[#1a1a22] px-3 py-2.5">
                <div className="min-w-0">
                  <p className="text-[13px] font-medium text-white">
                    LLVM IR source
                  </p>
                  <p className="truncate font-mono text-[11px] text-[#8b8794]">
                    {filename}
                    {ir
                      ? ` · ${lineCount.toLocaleString()} lines · ${(ir.length / 1024).toFixed(1)} KB`
                      : " · empty"}
                  </p>
                </div>
                <Button
                  type="button"
                  size="xs"
                  variant="tactile"
                  onClick={() => setIrExpanded((open) => !open)}
                >
                  {irExpanded ? (
                    <ChevronUp className="size-3.5" />
                  ) : (
                    <ChevronDown className="size-3.5" />
                  )}
                  {irExpanded ? "Collapse" : "Expand"}
                </Button>
              </div>
              {irExpanded ? (
                <Textarea
                  value={ir}
                  onChange={(e) => onIrChange(e.target.value)}
                  placeholder={"; ModuleID = 'module'\ndefine i32 @main() {\n  ret i32 0\n}"}
                  className="max-h-96 min-h-48 rounded-none border-0 bg-[#12121a] font-mono text-[12px] shadow-none focus-visible:ring-0"
                />
              ) : (
                <div className="bg-[#12121a] px-3 py-3">
                  <p className="truncate font-mono text-[11px] text-[#a09aab]">
                    {irPreview || "No IR pasted yet."}
                  </p>
                  {lineCount > 1 ? (
                    <p className="mt-1 text-[11px] text-[#8b8794]">
                      + {lineCount - 1} more lines hidden
                    </p>
                  ) : null}
                </div>
              )}
            </div>
            <div className="mt-3 flex items-center justify-end">
              <Button onClick={onAnalyze} disabled={loading || !ir.trim()}>
                {loading ? <Loader2 className="animate-spin" /> : <FileCode2 />}
                Analyze IR
              </Button>
            </div>
          </>
        ) : null}
      </WorkbenchPanel>
    </div>
  );
}

function CorpusView({
  samples,
  section,
  searchQuery,
  loading,
  onLoad,
}: {
  samples: SampleMeta[];
  section: string;
  searchQuery: string;
  loading: boolean;
  onLoad: (id: string) => void;
}) {
  const q = searchQuery.trim().toLowerCase();
  const filtered = samples.filter((s) => {
    if (section === "elf" && s.format !== "elf") return false;
    if (section === "ir" && s.format !== "ir") return false;
    if (!q) return true;
    return (
      s.title.toLowerCase().includes(q) ||
      s.id.toLowerCase().includes(q) ||
      s.blurb.toLowerCase().includes(q) ||
      s.expected.some((e) => e.toLowerCase().includes(q))
    );
  });

  return (
    <div>
      <WorkbenchPanel className="mb-4">
        <h2 className="text-[18px] font-semibold text-white">Evaluation corpus</h2>
        <p className="mt-1 text-[13px] text-[#c4c1d2]">
          {samples.length} labeled samples for SIH demo — click any card to
          analyze and jump to findings.
        </p>
      </WorkbenchPanel>
      <div className="grid gap-2 sm:grid-cols-2 lg:grid-cols-3">
        {filtered.map((s) => (
          <button
            key={s.id}
            type="button"
            disabled={loading}
            onClick={() => void onLoad(s.id)}
            className="group rounded-lg border border-[#34343f] bg-[#24242c] p-4 text-left transition-colors hover:border-[#6c5fc7]/40 hover:bg-[#2a2638]"
          >
            <div className="flex items-start justify-between gap-2">
              <span className="text-[13px] font-medium text-white">
                {s.title}
              </span>
              <Badge variant="outline" className="shrink-0">
                {s.format}
              </Badge>
            </div>
            <p className="mt-2 text-[12px] leading-relaxed text-[#a09aab]">
              {s.blurb}
            </p>
            <p className="mt-2 font-mono text-[10px] text-[#8b8794]">
              {s.expected.length
                ? s.expected.join(" · ")
                : "negative control"}
            </p>
            <ChevronRight className="mt-2 size-4 text-[#8b8794] opacity-0 transition-opacity group-hover:opacity-100" />
          </button>
        ))}
      </div>
    </div>
  );
}

const DEMO_SAMPLE_IDS = [
  "enterprise_mix_stripped",
  "vendor_openssl_stripped",
  "crypto_firmware_pe",
  "vendor_aes_so",
] as const;

function DiscoverView({
  loading,
  report,
  findings,
  samples,
  selectedFinding,
  activeFinding,
  activeFn,
  channelCounts,
  onSelectFinding,
  onSelectFn,
  onGoIngest,
  onGoCorpus,
  onLoadSample,
}: {
  loading: boolean;
  report: AnalysisReport | null;
  findings: Finding[];
  samples: SampleMeta[];
  selectedFinding: string | null;
  activeFinding: Finding | null;
  activeFn: FunctionRecord | null;
  channelCounts: { ir: number; bytes: number; ml: number };
  onSelectFinding: (id: string) => void;
  onSelectFn: (name: string) => void;
  onGoIngest: () => void;
  onGoCorpus: () => void;
  onLoadSample: (id: string) => void;
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
    const demoSamples = DEMO_SAMPLE_IDS.map((id) =>
      samples.find((s) => s.id === id),
    ).filter((s): s is SampleMeta => Boolean(s));

    return (
      <WorkbenchPanel>
        <h1 className="text-[22px] font-bold text-white">
          Cryptographic discovery workbench
        </h1>
        <p className="mt-2 max-w-2xl text-[13px] leading-relaxed text-[#c4c1d2]">
          ECDAT statically inventories primitives in LLVM IR and stripped
          binaries using three independent channels — constant-table signatures,
          CFG opcode softmax, and raw-byte anchors — with evidence attached to
          every finding.
        </p>
        <div className="mt-5 flex flex-wrap gap-2">
          <Button onClick={onGoIngest}>
            <Upload />
            Upload artifact
          </Button>
          <Button variant="tactile" onClick={onGoCorpus}>
            Browse full corpus
          </Button>
        </div>
        <h2 className="mt-8 text-[15px] font-semibold text-white">
          Demo-ready samples
        </h2>
        <p className="mt-1 text-[12px] text-[#a09aab]">
          One click loads and analyzes — ideal for tomorrow&apos;s presentation.
        </p>
        <div className="mt-3 grid gap-2 sm:grid-cols-2">
          {demoSamples.map((s) => (
            <button
              key={s.id}
              type="button"
              disabled={loading}
              onClick={() => void onLoadSample(s.id)}
              className="group rounded-lg border border-[#34343f] bg-[#24242c] p-4 text-left transition-colors hover:border-[#6c5fc7]/50 hover:bg-[#2a2638]"
            >
              <div className="flex items-start justify-between gap-2">
                <span className="text-[13px] font-medium text-white">
                  {s.title}
                </span>
                <Badge variant="outline">{s.format}</Badge>
              </div>
              <p className="mt-2 text-[12px] text-[#a09aab]">{s.blurb}</p>
              <p className="mt-2 font-mono text-[10px] text-[#8b8794]">
                expects: {s.expected.join(" · ") || "none"}
              </p>
            </button>
          ))}
        </div>
        <div className="mt-6 grid gap-3 sm:grid-cols-3">
          <ChannelCard
            title="IR signatures"
            detail="AES S-box, SHA K constants, ChaCha sigma"
            count={null}
          />
          <ChannelCard
            title="CFG softmax"
            detail="Opcode mix classifier on holdout corpus"
            count={null}
          />
          <ChannelCard
            title="Raw-byte scan"
            detail="TLS OIDs, RSA exponents, Curve25519 clamp"
            count={null}
          />
        </div>
      </WorkbenchPanel>
    );
  }

  return (
    <WorkbenchPanel className="flex h-full min-h-0 flex-col p-0">
      <div className="border-b border-[#34343f] px-5 py-3">
        <div className="flex flex-wrap items-center gap-4 text-[12px] text-[#c4c1d2]">
          <span>
            <strong className="text-white">{report.functionCount}</strong>{" "}
            functions
          </span>
          <span>
            <strong className="text-white">{report.findings.length}</strong>{" "}
            primitives
          </span>
          <span>
            <strong
              className={report.weakCount > 0 ? "text-[#f5a623]" : "text-white"}
            >
              {report.weakCount}
            </strong>{" "}
            weak
          </span>
          <span className="text-[#8b8794]">·</span>
          <span>
            IR {channelCounts.ir} · bytes {channelCounts.bytes} · model{" "}
            {channelCounts.ml}
          </span>
          {report.summary ? (
            <>
              <span className="text-[#8b8794]">·</span>
              <span className="text-[#a09aab]">{report.summary}</span>
            </>
          ) : null}
        </div>
      </div>
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
            <FindingDetail
              report={report}
              finding={activeFinding}
              activeFn={activeFn}
              onSelectFn={onSelectFn}
            />
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
    <SetupCard className="flex min-h-[520px] flex-col overflow-hidden p-0">
      <div className="border-b border-[#34343f] px-5 py-4">
        <div className="flex flex-wrap items-center gap-2">
          <h2 className="text-[18px] font-semibold text-white">
            {finding.primitive}
          </h2>
          <SeverityBadge severity={finding.severity} />
          <SourceBadge source={finding.source} />
          <span className="font-mono text-[12px] text-[#8b8794]">
            {finding.id} · {(finding.confidence * 100).toFixed(0)}% confidence
          </span>
        </div>
        <p className="mt-2 text-[13px] leading-relaxed text-[#c4c1d2]">
          {finding.rationale}
        </p>
        {report.targetTriple ? (
          <p className="mt-2 font-mono text-[11px] text-[#8b8794]">
            {report.targetTriple}
            {report.ml
              ? ` · holdout ${(report.ml.holdoutAccuracy * 100).toFixed(0)}%`
              : ""}
          </p>
        ) : null}
      </div>

      <div className="flex-1 overflow-auto px-5 py-4">
        <Tabs defaultValue="evidence">
          <TabsList
            variant="line"
            className="h-9 w-full border-[#34343f] text-[#8b8794]"
          >
            <TabsTrigger
              value="evidence"
              className="data-active:border-[#6c5fc7] data-active:text-white"
            >
              Evidence
            </TabsTrigger>
            <TabsTrigger
              value="ir"
              className="data-active:border-[#6c5fc7] data-active:text-white"
            >
              Function IR
            </TabsTrigger>
            <TabsTrigger
              value="mix"
              className="data-active:border-[#6c5fc7] data-active:text-white"
            >
              Opcode mix
            </TabsTrigger>
          </TabsList>

          <TabsContent value="evidence" className="mt-4 space-y-3">
            {finding.evidence.map((ev, i) => (
              <div
                key={`${ev.summary}-${i}`}
                className="rounded-lg border border-[#3d3d48] bg-[#1a1a22] p-4"
              >
                <p className="text-[11px] font-semibold tracking-wide text-[#8b8794] uppercase">
                  {ev.kind}
                  {ev.line ? ` · line ${ev.line}` : ""}
                  {ev.offset != null
                    ? ` · offset 0x${ev.offset.toString(16)}`
                    : ""}
                </p>
                <p className="mt-2 text-[13px] text-[#e8e6ef]">{ev.summary}</p>
                {ev.snippet ? (
                  <pre className="mt-3 overflow-x-auto rounded-md border border-[#34343f] bg-[#12121a] p-3 font-mono text-[11px] leading-relaxed text-[#c4b5fd]">
                    {ev.snippet}
                  </pre>
                ) : null}
              </div>
            ))}
            {finding.notes.length ? (
              <div className="rounded-lg border border-[#3d3d48] bg-[#1a1a22] p-4">
                <div className="flex gap-2">
                  <ShieldAlert className="mt-0.5 size-4 shrink-0 text-[#f5a623]" />
                  <div className="min-w-0">
                    <p className="text-[13px] font-medium text-white">
                      Posture notes
                    </p>
                    <ul className="mt-2 list-disc space-y-1.5 pl-4 text-[13px] text-[#c4c1d2]">
                      {finding.notes.map((n) => (
                        <li key={n}>{n}</li>
                      ))}
                    </ul>
                  </div>
                </div>
              </div>
            ) : null}
          </TabsContent>

          <TabsContent value="ir" className="mt-4 space-y-3">
            {report.functions.length ? (
              <div className="flex flex-wrap gap-1.5">
                {report.functions.map((fn) => (
                  <Button
                    key={fn.name}
                    type="button"
                    size="xs"
                    variant={activeFn?.name === fn.name ? "default" : "tactile"}
                    onClick={() => onSelectFn(fn.name)}
                    className="font-mono"
                  >
                    @{fn.name}
                  </Button>
                ))}
              </div>
            ) : null}
            {activeFn ? (
              <div className="overflow-hidden rounded-lg border border-[#3d3d48] bg-[#12121a]">
                <ScrollArea className="h-80">
                  <pre className="p-4 font-mono text-[11px] leading-relaxed text-[#c4b5fd]">
                    {activeFn.ir}
                  </pre>
                </ScrollArea>
              </div>
            ) : (
              <p className="text-[13px] text-[#a09aab]">No function selected.</p>
            )}
          </TabsContent>

          <TabsContent value="mix" className="mt-4">
            {activeFn ? (
              <OpcodeBars fn={activeFn} />
            ) : (
              <p className="text-[13px] text-[#a09aab]">No function selected.</p>
            )}
          </TabsContent>
        </Tabs>
      </div>
    </SetupCard>
  );
}

function InventoryView({
  inventory,
  section,
  assetId,
  businessUnit,
  orgSite,
  onAssetId,
  onBusinessUnit,
  onOrgSite,
  onGoAnalyze,
}: {
  inventory: EnterpriseInventory | null;
  section: string;
  assetId: string;
  businessUnit: string;
  orgSite: string;
  onAssetId: (v: string) => void;
  onBusinessUnit: (v: string) => void;
  onOrgSite: (v: string) => void;
  onGoAnalyze: () => void;
}) {
  if (!inventory) {
    return (
      <WorkbenchPanel>
        <h2 className="text-[18px] font-semibold text-white">No inventory yet</h2>
        <p className="mt-2 max-w-lg text-[13px] text-[#c4c1d2]">
          Run an analysis on an artifact first. ECDAT builds a cryptographic
          inventory with asset metadata, primitive rows, and exportable JSON/HTML
          reports for enterprise posture review.
        </p>
        <Button className="mt-4" onClick={onGoAnalyze}>
          <Upload />
          Analyze an artifact
        </Button>
      </WorkbenchPanel>
    );
  }

  const showMetadata = section !== "export";
  const showExport = section !== "metadata";

  return (
    <div className="grid gap-6 lg:grid-cols-[minmax(0,1fr)_minmax(0,1.4fr)]">
      {showMetadata ? (
        <SetupCard className="p-5">
          <h2 className="text-[15px] font-semibold text-white">Asset metadata</h2>
          <div className="mt-4 space-y-3">
            <label className="block space-y-1">
              <span className="text-[11px] font-medium text-[#8b8794] uppercase">
                Asset ID
              </span>
              <Input
                className="font-mono"
                value={assetId}
                onChange={(e) => onAssetId(e.target.value)}
              />
            </label>
            <label className="block space-y-1">
              <span className="text-[11px] font-medium text-[#8b8794] uppercase">
                Business unit
              </span>
              <Input
                value={businessUnit}
                onChange={(e) => onBusinessUnit(e.target.value)}
              />
            </label>
            <label className="block space-y-1">
              <span className="text-[11px] font-medium text-[#8b8794] uppercase">
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
      ) : null}

      {showExport ? (
        <SetupCard className="overflow-hidden">
          <div className="border-b border-[#34343f] px-4 py-3">
            <h2 className="text-[15px] font-semibold text-white">
              Cryptographic inventory
            </h2>
            <p className="text-[12px] text-[#a09aab]">
              {inventory.primitiveCount} primitives · {inventory.weakCount} weak
            </p>
          </div>
          <ScrollArea className="h-[420px]">
            <table className="w-full text-left text-[12px] text-[#e8e6ef]">
              <thead className="sticky top-0 bg-[#1a1a22] text-[11px] text-[#8b8794] uppercase">
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
                    className="border-t border-[#34343f] hover:bg-[#1a1a22]/60"
                  >
                    <td className="px-4 py-2.5 font-mono">{row.id}</td>
                    <td className="px-4 py-2.5">{row.primitive}</td>
                    <td className="px-4 py-2.5">
                      <SeverityBadge severity={row.severity} />
                    </td>
                    <td className="px-4 py-2.5 font-mono">
                      {(row.confidence * 100).toFixed(0)}%
                    </td>
                    <td className="max-w-[200px] truncate px-4 py-2.5 font-mono text-[#a09aab]">
                      {row.locations.slice(0, 2).join(" · ")}
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </ScrollArea>
        </SetupCard>
      ) : null}
    </div>
  );
}

function ChannelCard({
  title,
  detail,
  count,
}: {
  title: string;
  detail: string;
  count: number | null;
}) {
  return (
    <div className="rounded-lg border border-[#34343f] bg-[#24242c] p-4">
      <p className="text-[13px] font-medium text-white">{title}</p>
      <p className="mt-1 text-[12px] text-[#a09aab]">{detail}</p>
      {count != null ? (
        <p className="mt-2 font-mono text-[11px] text-[#8b8794]">
          {count} findings
        </p>
      ) : null}
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
    <div className="bg-[#24242c] px-3 py-2.5">
      <p className="text-[10px] font-medium tracking-wide text-[#8b8794] uppercase">
        {label}
      </p>
      <p
        className={cn(
          "mt-0.5 font-mono text-lg",
          warn ? "text-[#f5a623]" : "text-white",
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
      <p className="text-[13px] text-[#a09aab]">No counted opcodes.</p>
    );
  }
  return (
    <ul className="space-y-2">
      {entries.map(([op, n]) => (
        <li
          key={op}
          className="grid grid-cols-[4.5rem_1fr_2rem] items-center gap-2"
        >
          <span className="font-mono text-[11px] text-[#c4c1d2]">{op}</span>
          <div className="h-1.5 overflow-hidden rounded-full bg-[#34343f]">
            <div
              className="h-full bg-[#6c5fc7]"
              style={{ width: `${(n / max) * 100}%` }}
            />
          </div>
          <span className="font-mono text-[11px] text-[#8b8794]">
            {n}
          </span>
        </li>
      ))}
      <li className="pt-1 text-[11px] text-[#8b8794]">
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
