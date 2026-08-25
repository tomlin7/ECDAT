import type { Finding, PrimitiveId } from "../ir/types";
import { rationaleFor, severityFor, titleFor } from "../ir/classify";
import {
  AES_SBOX,
  CHACHA_SIGMA,
  CRC32_POLY,
  CURVE25519_BASE,
  CURVE25519_CLAMP,
  DRBG_HASH_LABEL,
  DRBG_HMAC_LABEL,
  GHASH_R_BE,
  GHASH_R_LE,
  HASH_DRBG_V0_HEAD,
  HMAC_IPAD_HEAD,
  HMAC_OPAD_HEAD,
  MD5_T,
  OPENSSL_TE0_HEAD,
  RSA_PKCS1_OID,
  RSA_PUBEXP_65537,
  SHA1_K,
  SHA256_K,
  TLS_CIPHER_HEAD,
  TLS_CIPHER_HEAD_LE,
  TLS_RECORD_12,
  indexOfBytes,
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
    {
      primitive: "AES",
      label: "OpenSSL Te0 AES T-table head",
      bytes: OPENSSL_TE0_HEAD,
    },
    {
      primitive: "HMAC-SHA256",
      label: "HMAC ipad 0x36 (16 bytes)",
      bytes: HMAC_IPAD_HEAD,
    },
    {
      primitive: "HMAC-SHA256",
      label: "HMAC opad 0x5c (16 bytes)",
      bytes: HMAC_OPAD_HEAD,
    },
    {
      primitive: "AES-GCM",
      label: "GHASH R = 0xe1<<120 (BE)",
      bytes: GHASH_R_BE,
    },
    {
      primitive: "AES-GCM",
      label: "GHASH R = 0xe1<<120 (LE)",
      bytes: GHASH_R_LE,
    },
    {
      primitive: "Curve25519",
      label: "Curve25519 base point 9",
      bytes: CURVE25519_BASE,
    },
    {
      primitive: "Curve25519",
      label: "Curve25519 clamp 0xf8",
      bytes: CURVE25519_CLAMP,
    },
    {
      primitive: "RSA-key",
      label: "PKCS#1 rsaEncryption OID",
      bytes: RSA_PKCS1_OID,
    },
    {
      primitive: "RSA-key",
      label: "RSA public exponent 65537 (DER)",
      bytes: RSA_PUBEXP_65537,
    },
    {
      primitive: "TLS-stack",
      label: "TLS cipher suites (BE uint16)",
      bytes: TLS_CIPHER_HEAD,
    },
    {
      primitive: "TLS-stack",
      label: "TLS cipher suites (LE uint16)",
      bytes: TLS_CIPHER_HEAD_LE,
    },
    {
      primitive: "TLS-stack",
      label: "TLS 1.2 record version 0x0303",
      bytes: TLS_RECORD_12,
    },
    {
      primitive: "DRBG",
      label: "Hash_DRBG label",
      bytes: DRBG_HASH_LABEL,
    },
    {
      primitive: "DRBG",
      label: "HMAC_DRBG label",
      bytes: DRBG_HMAC_LABEL,
    },
    {
      primitive: "DRBG",
      label: "Hash_DRBG KAT V head",
      bytes: HASH_DRBG_V0_HEAD,
    },
  ];
}

export function scanBinaryConstants(buf: Uint8Array): Finding[] {
  const grouped = new Map<PrimitiveId, Finding>();
  let n = 0;
  const hmacHits = { ipad: false, opad: false };
  for (const p of patterns()) {
    const off = indexOfBytes(buf, p.bytes);
    if (off < 0) continue;
    if (p.primitive === "HMAC-SHA256") {
      if (p.label.includes("ipad")) hmacHits.ipad = true;
      if (p.label.includes("opad")) hmacHits.opad = true;
    }
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
  if (hmacHits.ipad && hmacHits.opad) {
    const h = grouped.get("HMAC-SHA256");
    if (h) {
      h.confidence = Math.min(0.99, h.confidence + 0.06);
      h.notes.push("Both HMAC ipad and opad blocks present — strong HMAC-SHA256 indicator.");
    }
  }
  const curveBase = grouped.get("Curve25519");
  const hasClamp =
    indexOfBytes(buf, CURVE25519_CLAMP) >= 0 ||
    patterns().some(
      (p) => p.primitive === "Curve25519" && p.label.includes("clamp") && indexOfBytes(buf, p.bytes) >= 0,
    );
  if (curveBase && !hasClamp) grouped.delete("Curve25519");
  return [...grouped.values()].sort((a, b) => b.confidence - a.confidence);
}

function hexPreview(buf: Uint8Array, off: number, n: number): string {
  return [...buf.slice(off, off + n)]
    .map((b) => b.toString(16).padStart(2, "0"))
    .join(" ");
}
