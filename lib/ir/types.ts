export type PrimitiveId =
  | "AES"
  | "SHA-256"
  | "SHA-1"
  | "MD5"
  | "ChaCha20"
  | "RSA-modexp"
  | "CRC32"
  | "DES";

export type Severity = "ok" | "weak" | "info";

export type Evidence = {
  kind: "constant-table" | "opcode-mix" | "cfg" | "global-ref" | "name" | "ml-graph" | "raw-bytes";
  summary: string;
  line?: number;
  snippet?: string;
  offset?: number;
};

export type FunctionRecord = {
  name: string;
  startLine: number;
  endLine: number;
  ir: string;
  blocks: number;
  edges: number;
  opcodes: Record<string, number>;
  globalsUsed: string[];
  bitwiseDensity: number;
  instructionCount: number;
};

export type GlobalConstant = {
  name: string;
  line: number;
  bytes: number[];
  words32: number[];
  rawSnippet: string;
};

export type FindingSource = "signature" | "ml" | "binary";

export type Finding = {
  id: string;
  primitive: PrimitiveId;
  confidence: number;
  severity: Severity;
  title: string;
  rationale: string;
  functions: string[];
  evidence: Evidence[];
  notes: string[];
  source: FindingSource;
};

export type IngestKind =
  | "llvm-ir"
  | "bitcode"
  | "elf"
  | "pe"
  | "macho"
  | "unknown-binary"
  | "pasted-ir";

export type MlFunctionPred = {
  name: string;
  label: string;
  confidence: number;
  scores: Record<string, number>;
};

export type AnalysisReport = {
  filename: string;
  scannedAt: string;
  targetTriple: string | null;
  functionCount: number;
  functions: FunctionRecord[];
  findings: Finding[];
  weakCount: number;
  summary: string;
  ingest: {
    kind: IngestKind;
    bytes: number;
    channels: { signatures: boolean; ml: boolean; binary: boolean };
  };
  ml: {
    version: string;
    trainAccuracy: number;
    holdoutAccuracy: number;
    trainedOn: number;
    predictions: MlFunctionPred[];
  } | null;
};
