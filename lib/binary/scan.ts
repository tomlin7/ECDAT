import type { Finding, PrimitiveId } from "../ir/types";
import { rationaleFor, severityFor, titleFor } from "../ir/classify";
import {
  AES_SBOX,
  CHACHA_SIGMA,
  CRC32_POLY,
  indexOfBytes,
  MD5_T,
  SHA1_K,
  SHA256_K,
  wordsToBytesBE,
  wordsToBytesLE,
} from "../ir/signatures";

type Pattern = {
  primitive: PrimitiveId;
  label: string;
  bytes: number[];
};

function patterns(): Pattern[] {
  return [
    { primitive: "AES", label: "AES S-box (FIPS-197, 256 bytes)", bytes: AES_SBOX },
    {
      primitive: "SHA-256",
      label: "SHA-256 K[] (little-endian)",
      bytes: wordsToBytesLE(SHA256_K.slice(0, 8)),
    },
    {
      primitive: "SHA-256",
      label: "SHA-256 K[] (big-endian)",
      bytes: wordsToBytesBE(SHA256_K.slice(0, 8)),
    },
    {
      primitive: "SHA-1",
      label: "SHA-1 K_t (little-endian)",
      bytes: wordsToBytesLE(SHA1_K),
    },
    {
      primitive: "SHA-1",
      label: "SHA-1 K_t (big-endian)",
      bytes: wordsToBytesBE(SHA1_K),
    },
    {
      primitive: "MD5",
      label: "MD5 T[] (little-endian)",
      bytes: wordsToBytesLE(MD5_T.slice(0, 8)),
    },
    {
      primitive: "ChaCha20",
      label: 'ChaCha20 sigma "expand 32-byte k"',
      bytes: wordsToBytesLE(CHACHA_SIGMA),
    },
    {
      primitive: "ChaCha20",
      label: "ChaCha20 sigma ASCII",
      bytes: [...new TextEncoder().encode("expand 32-byte k")],
    },
    {
      primitive: "CRC32",
      label: "CRC-32 polynomial 0xEDB88320",
      bytes: wordsToBytesLE(CRC32_POLY),
    },
  ];
}

export function scanBinaryConstants(buf: Uint8Array): Finding[] {
  const grouped = new Map<PrimitiveId, Finding>();
  let n = 0;
  for (const p of patterns()) {
    const off = indexOfBytes(buf, p.bytes);
    if (off < 0) continue;
    const existing = grouped.get(p.primitive);
    const ev = {
      kind: "raw-bytes" as const,
      summary: `${p.label} at file offset 0x${off.toString(16)}`,
      offset: off,
      snippet: hexPreview(buf, off, Math.min(24, p.bytes.length)),
    };
    if (existing) {
      existing.evidence.push(ev);
      existing.confidence = Math.min(0.99, existing.confidence + 0.05);
      continue;
    }
    n += 1;
    grouped.set(p.primitive, {
      id: `B${String(n).padStart(2, "0")}`,
      primitive: p.primitive,
      confidence: 0.9,
      severity: severityFor(p.primitive),
      title: titleFor(p.primitive),
      rationale: `Raw ${p.primitive} constant table in the file image (no execution).`,
      functions: [],
      evidence: [ev],
      notes: [rationaleFor(p.primitive)],
      source: "binary",
    });
  }
  return [...grouped.values()].sort((a, b) => b.confidence - a.confidence);
}

function hexPreview(buf: Uint8Array, off: number, n: number): string {
  return [...buf.slice(off, off + n)]
    .map((b) => b.toString(16).padStart(2, "0"))
    .join(" ");
}
