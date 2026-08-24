import { mkdirSync, readFileSync, readdirSync, writeFileSync } from "node:fs";
import path from "node:path";
import { extractFunctions } from "../lib/ir/parse";
import { obfuscateIr } from "../lib/ir/obfuscate";
import { FEATURE_NAMES, functionFeatures } from "../lib/ml/features";
import { trainLogReg } from "../lib/ml/logreg";

const LABELS = ["BENIGN", "AES", "AES-GCM", "SHA-256", "SHA-1", "MD5", "HMAC-SHA256", "ChaCha20", "Curve25519", "RSA-modexp"] as const;

function labelFunction(file: string, name: string): (typeof LABELS)[number] | null {
  const f = file.toLowerCase();
  const n = name.toLowerCase();
  if (n.startsWith("llvm.")) return null;
  if (/hmac/.test(n)) return "HMAC-SHA256";
  if (/gcm|ghash/.test(n)) return "AES-GCM";
  if (/curve25519|x25519/.test(n)) return "Curve25519";
  if (/aes|sbox|mix_column|sub_bytes|xtime|add_round/.test(n)) return "AES";
  if (/sha256/.test(n)) return "SHA-256";
  if (/sha1/.test(n)) return "SHA-1";
  if (/md5/.test(n)) return "MD5";
  if (/chacha|quarter/.test(n)) return "ChaCha20";
  if (/modexp|rsa/.test(n)) return "RSA-modexp";
  if (/inventory|copy_record|find_parcel/.test(n)) return "BENIGN";
  if (f.includes("enterprise") || /mix\.ll/.test(f)) return null;
  if (f.includes("benign") || f.includes("crc")) return "BENIGN";
  if (f.includes("hmac")) return "HMAC-SHA256";
  if (f.includes("aes_gcm") || f.includes("gcm")) return "AES-GCM";
  if (f.includes("curve25519")) return "Curve25519";
  if (f.includes("vendor_openssl")) return "AES";
  if (f.includes("aes")) return "AES";
  if (f.includes("sha256")) return "SHA-256";
  if (f.includes("sha1")) return "SHA-1";
  if (f.includes("md5")) return "MD5";
  if (f.includes("chacha")) return "ChaCha20";
  if (f.includes("rsa")) return "RSA-modexp";
  return null;
}

function collectFromIr(ir: string, filename: string, xs: number[][], ys: number[]) {
  for (const fn of extractFunctions(ir)) {
    if (fn.instructionCount < 6) continue;
    const lab = labelFunction(filename, fn.name);
    if (!lab) continue;
    const yi = LABELS.indexOf(lab);
    if (yi < 0) continue;
    xs.push(functionFeatures(fn));
    ys.push(yi);
  }
}

const irDir = path.join(process.cwd(), "corpus", "ir");
const xs: number[][] = [];
const ys: number[] = [];

for (const file of readdirSync(irDir).filter((f) => f.endsWith(".ll"))) {
  const ir = readFileSync(path.join(irDir, file), "utf8");
  collectFromIr(ir, file, xs, ys);
  for (const seed of [1, 2, 3, 7, 11]) {
    collectFromIr(obfuscateIr(ir, seed), `obf_${seed}_${file}`, xs, ys);
  }
}

const model = trainLogReg(xs, ys, [...LABELS], [...FEATURE_NAMES]);
const out = path.join(process.cwd(), "lib", "ml", "model.json");
mkdirSync(path.dirname(out), { recursive: true });
writeFileSync(out, JSON.stringify(model, null, 2));
console.log(
  `wrote ${out} n=${model.trainedOn} train=${model.trainAccuracy} holdout=${model.holdoutAccuracy} labels=${model.labels.join(",")}`,
);
