import { readFileSync } from "node:fs";
import path from "node:path";
import { analyzeArtifact, analyzeIr } from "../lib/pipeline";
import { obfuscateIr } from "../lib/ir/obfuscate";
import { SAMPLE_CATALOG, readSample } from "../lib/samples/catalog";

let failed = 0;

for (const sample of SAMPLE_CATALOG) {
  const loaded = readSample(sample.id);
  if (!loaded) {
    console.error(`MISSING ${sample.id}`);
    failed += 1;
    continue;
  }
  const report = loaded.base64
    ? analyzeArtifact(Buffer.from(loaded.base64, "base64"), loaded.filename)
    : analyzeIr(loaded.ir ?? "", loaded.filename);
  const got = new Set(report.findings.map((f) => f.primitive));
  const missing = sample.expected.filter((p) => !got.has(p));
  const extra = [...got].filter((p) => !sample.expected.includes(p));
  const ok = missing.length === 0;
  console.log(
    `${ok ? "ok" : "FAIL"} ${sample.id.padEnd(16)} expected=[${sample.expected.join(", ")}] got=[${[...got].join(", ")}] kind=${report.ingest.kind} weak=${report.weakCount}`,
  );
  if (missing.length) {
    console.log(`     missing: ${missing.join(", ")}`);
    failed += 1;
  }
  if (extra.length) console.log(`     extra:   ${extra.join(", ")}`);
}

const aesIr = readFileSync(path.join(process.cwd(), "corpus", "ir", "aes.ll"), "utf8");
const obf = analyzeIr(obfuscateIr(aesIr, 99), "aes.obf.ll");
if (!obf.findings.some((f) => f.primitive === "AES")) {
  console.error("FAIL obfuscated AES IR lost the S-box match");
  failed += 1;
} else {
  console.log("ok obfuscated AES still matched");
}

if (failed) {
  console.error(`\n${failed} check(s) failed`);
  process.exit(1);
}
console.log("\nall corpus checks passed");
