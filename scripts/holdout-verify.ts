import { readFileSync, readdirSync } from "node:fs";
import path from "node:path";
import { analyzeArtifact, analyzeIr } from "../lib/pipeline";
import type { PrimitiveId } from "../lib/ir/types";

/** Vendor IR holdout — excluded from train-model.ts (corpus/ir/holdout/). */
const IR_HOLDOUT: { file: string; expected: PrimitiveId[] }[] = [
  { file: "vendor_libsodium.ll", expected: ["ChaCha20"] },
];

/** Vendor binary holdout — not in SAMPLE_CATALOG (corpus/bin/holdout/). */
const BIN_HOLDOUT: { file: string; expected: PrimitiveId[] }[] = [
  { file: "vendor_aes_holdout.o", expected: ["AES"] },
];

const holdoutIrDir = path.join(process.cwd(), "corpus", "ir", "holdout");
const holdoutBinDir = path.join(process.cwd(), "corpus", "bin", "holdout");
let failed = 0;

for (const spec of IR_HOLDOUT) {
  const p = path.join(holdoutIrDir, spec.file);
  let ir: string;
  try {
    ir = readFileSync(p, "utf8");
  } catch {
    console.error(`MISSING holdout ${spec.file}`);
    failed += 1;
    continue;
  }
  const report = analyzeIr(ir, spec.file);
  const got = new Set(report.findings.map((f) => f.primitive));
  const missing = spec.expected.filter((x) => !got.has(x));
  const ok = missing.length === 0;
  console.log(
    `${ok ? "ok" : "FAIL"} holdout-ir ${spec.file.padEnd(22)} expected=[${spec.expected.join(", ")}] got=[${[...got].join(", ")}]`,
  );
  if (missing.length) {
    console.log(`     missing: ${missing.join(", ")}`);
    failed += 1;
  }
}

for (const spec of BIN_HOLDOUT) {
  const p = path.join(holdoutBinDir, spec.file);
  let buf: Buffer;
  try {
    buf = readFileSync(p);
  } catch {
    console.error(`MISSING holdout bin ${spec.file}`);
    failed += 1;
    continue;
  }
  const report = analyzeArtifact(new Uint8Array(buf), spec.file);
  const got = new Set(report.findings.map((f) => f.primitive));
  const missing = spec.expected.filter((x) => !got.has(x));
  const ok = missing.length === 0;
  console.log(
    `${ok ? "ok" : "FAIL"} holdout-bin ${spec.file.padEnd(22)} expected=[${spec.expected.join(", ")}] got=[${[...got].join(", ")}] kind=${report.ingest.kind}`,
  );
  if (missing.length) {
    console.log(`     missing: ${missing.join(", ")}`);
    failed += 1;
  }
}

const trained = readdirSync(path.join(process.cwd(), "corpus", "ir"))
  .filter((f) => f.endsWith(".ll"))
  .some((f) => f.includes("vendor_libsodium"));
if (trained) {
  console.error("FAIL vendor_libsodium.ll must not be in corpus/ir root (holdout leak)");
  failed += 1;
} else {
  console.log("ok holdout not in training corpus root");
}

if (failed) {
  console.error(`\n${failed} holdout check(s) failed`);
  process.exit(1);
}
console.log("\nall holdout checks passed");
