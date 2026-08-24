import { classify, rationaleFor, severityFor, titleFor } from "./ir/classify";
import { detectKind } from "./binary/detect";
import { scanBinaryConstants } from "./binary/scan";
import { extractFunctions, extractGlobals, extractTargetTriple, looksLikeLlvmIr } from "./ir/parse";
import { functionFeatures } from "./ml/features";
import { predictLogReg, type LogRegModel } from "./ml/logreg";
import { buildEnterpriseInventory } from "./report";
import modelJson from "./ml/model.json";
import type {
  AnalysisReport,
  Finding,
  FunctionRecord,
  IngestKind,
  MlFunctionPred,
  PrimitiveId,
} from "./ir/types";

const MODEL = modelJson as LogRegModel;
const CRYPTO_LABELS = new Set<PrimitiveId>([
  "AES",
  "AES-GCM",
  "SHA-256",
  "SHA-1",
  "MD5",
  "HMAC-SHA256",
  "ChaCha20",
  "Curve25519",
  "RSA-modexp",
  "CRC32",
  "DES",
]);

function truncateFns(functions: FunctionRecord[]): FunctionRecord[] {
  return functions.map((fn) => ({
    ...fn,
    ir: fn.ir.length > 12000 ? `${fn.ir.slice(0, 12000)}\n; … truncated …\n` : fn.ir,
  }));
}

function fuse(findings: Finding[]): Finding[] {
  const by = new Map<PrimitiveId, Finding>();
  for (const f of findings) {
    const hit = by.get(f.primitive);
    if (!hit) {
      by.set(f.primitive, { ...f, evidence: [...f.evidence], functions: [...f.functions], notes: [...f.notes] });
      continue;
    }
    hit.confidence = Math.min(0.99, Math.max(hit.confidence, f.confidence) + 0.03);
    hit.evidence.push(...f.evidence);
    hit.functions = [...new Set([...hit.functions, ...f.functions])];
    hit.notes = [...new Set([...hit.notes, ...f.notes])];
    if (hit.source !== f.source) {
      hit.notes.push(`Corroborated by ${hit.source} and ${f.source} channels.`);
    }
  }
  const out = [...by.values()].sort((a, b) => b.confidence - a.confidence);
  out.forEach((f, i) => {
    f.id = `F${String(i + 1).padStart(2, "0")}`;
  });
  return out;
}

function mlFindings(functions: FunctionRecord[]): {
  findings: Finding[];
  predictions: MlFunctionPred[];
} {
  const predictions: MlFunctionPred[] = [];
  const grouped = new Map<PrimitiveId, Finding>();
  for (const fn of functions) {
    if (fn.instructionCount < 6) continue;
    const pred = predictLogReg(functionFeatures(fn), MODEL);
    predictions.push({
      name: fn.name,
      label: pred.label,
      confidence: pred.confidence,
      scores: pred.scores,
    });
    if (pred.label === "BENIGN" || pred.confidence < 0.42) continue;
    if (!CRYPTO_LABELS.has(pred.label as PrimitiveId)) continue;
    const primitive = pred.label as PrimitiveId;
    const ev = {
      kind: "ml-graph" as const,
      summary: `@${fn.name}: softmax ${pred.label} ${(pred.confidence * 100).toFixed(0)}% from CFG/opcode features (trained on clean + mutated IR).`,
      line: fn.startLine,
    };
    const existing = grouped.get(primitive);
    if (existing) {
      existing.functions.push(fn.name);
      existing.evidence.push(ev);
      existing.confidence = Math.min(0.99, Math.max(existing.confidence, pred.confidence));
      continue;
    }
    grouped.set(primitive, {
      id: "tmp",
      primitive,
      confidence: pred.confidence,
      severity: severityFor(primitive),
      title: titleFor(primitive),
      rationale:
        "Graph/opcode classifier (softmax logistic regression on LLVM CFG stats), independent of symbol names.",
      functions: [fn.name],
      evidence: [ev],
      notes: [rationaleFor(primitive)],
      source: "ml",
    });
  }
  return { findings: [...grouped.values()], predictions };
}

export function analyzeArtifact(buf: Uint8Array, filename: string): AnalysisReport {
  const kind: IngestKind = detectKind(buf, filename);
  const text = new TextDecoder("utf-8", { fatal: false }).decode(buf);
  const isIr = kind === "llvm-ir" || kind === "pasted-ir" || looksLikeLlvmIr(text);

  let functions: FunctionRecord[] = [];
  const findings: Finding[] = [];
  let predictions: MlFunctionPred[] = [];
  let triple: string | null = null;
  const channels = { signatures: false, ml: false, binary: false };

  if (isIr) {
    functions = extractFunctions(text);
    const globals = extractGlobals(text);
    triple = extractTargetTriple(text);
    findings.push(...classify(globals, functions));
    channels.signatures = true;
    const ml = mlFindings(functions);
    const sigPrims = new Set(findings.map((f) => f.primitive));
    const mlKept = ml.findings.filter((f) => {
      if (sigPrims.has(f.primitive)) return true;
      if (sigPrims.size === 0) return f.confidence >= 0.5;
      return f.confidence >= 0.88;
    });
    findings.push(...mlKept);
    predictions = ml.predictions;
    channels.ml = true;
  }

  if (kind === "elf" || kind === "pe" || kind === "macho" || kind === "bitcode" || kind === "unknown-binary" || !isIr) {
    const bin = scanBinaryConstants(buf);
    if (bin.length) {
      findings.push(...bin);
      channels.binary = true;
    } else if (!isIr) {
      channels.binary = true;
    }
  }

  const fused = fuse(findings);
  const weakCount = fused.filter((f) => f.severity === "weak").length;
  const names = fused.map((f) => f.primitive);
  const scannedAt = new Date().toISOString();
  const summary =
    fused.length === 0
      ? isIr
        ? "No cryptographic primitives matched in IR (signatures + model both quiet)."
        : "No known constant tables in this file image. Lift to LLVM IR for CFG/ML scoring."
      : `Matched ${fused.length} primitive${fused.length === 1 ? "" : "s"} (${names.join(", ")})${
          weakCount ? ` — ${weakCount} flagged weak/deprecated` : ""
        }.`;

  const ml =
    predictions.length || channels.ml
      ? {
          version: MODEL.version,
          trainAccuracy: MODEL.trainAccuracy,
          holdoutAccuracy: MODEL.holdoutAccuracy,
          trainedOn: MODEL.trainedOn,
          predictions,
        }
      : null;

  const truncated = truncateFns(functions);

  return {
    filename,
    scannedAt,
    targetTriple: triple,
    functionCount: functions.length,
    functions: truncated,
    findings: fused,
    weakCount,
    summary,
    ingest: { kind, bytes: buf.length, channels },
    ml,
    inventory: buildEnterpriseInventory({
      filename,
      scannedAt,
      targetTriple: triple,
      findings: fused,
      weakCount,
      summary,
      ingest: { kind, bytes: buf.length, channels },
      mlHoldout: ml?.holdoutAccuracy ?? null,
    }),
  };
}

export function analyzeIr(ir: string, filename: string): AnalysisReport {
  return analyzeArtifact(new TextEncoder().encode(ir), filename);
}
