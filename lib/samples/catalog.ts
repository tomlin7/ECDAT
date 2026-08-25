import { readFileSync, readdirSync } from "node:fs";
import path from "node:path";
import type { PrimitiveId } from "../ir/types";

export type SampleMeta = {
  id: string;
  filename: string;
  title: string;
  blurb: string;
  expected: PrimitiveId[];
  format: "ir" | "elf";
};

export const SAMPLE_CATALOG: SampleMeta[] = [
  {
    id: "enterprise_mix",
    filename: "enterprise_mix.ll",
    title: "Enterprise mix (IR)",
    blurb: "Clang module: AES, SHA-256, ChaCha20, MD5, RSA-like modexp, inventory helpers.",
    expected: ["AES", "SHA-256", "ChaCha20", "MD5", "RSA-modexp"],
    format: "ir",
  },
  {
    id: "aes",
    filename: "aes.ll",
    title: "AES IR",
    blurb: "FIPS-197 S-box and MixColumns.",
    expected: ["AES"],
    format: "ir",
  },
  {
    id: "aes_obj",
    filename: "aes.o",
    title: "AES ELF object",
    blurb: "clang -c output — raw S-box in .rodata, no IR parse.",
    expected: ["AES"],
    format: "elf",
  },
  {
    id: "sha256",
    filename: "sha256.ll",
    title: "SHA-256 IR",
    blurb: "FIPS-180 K[] and Ch/Maj/Σ.",
    expected: ["SHA-256"],
    format: "ir",
  },
  {
    id: "sha1",
    filename: "sha1.ll",
    title: "SHA-1 IR (weak)",
    blurb: "SHA-1 K_t constants.",
    expected: ["SHA-1"],
    format: "ir",
  },
  {
    id: "chacha20",
    filename: "chacha20.ll",
    title: "ChaCha20 IR",
    blurb: "Sigma words expand 32-byte k.",
    expected: ["ChaCha20"],
    format: "ir",
  },
  {
    id: "md5",
    filename: "md5.ll",
    title: "MD5 IR (weak)",
    blurb: "RFC 1321 T[] table.",
    expected: ["MD5"],
    format: "ir",
  },
  {
    id: "rsa_modexp",
    filename: "rsa_modexp.ll",
    title: "RSA-shaped modexp IR",
    blurb: "Square-and-multiply, no named constants.",
    expected: ["RSA-modexp"],
    format: "ir",
  },
  {
    id: "crc32",
    filename: "crc32.ll",
    title: "CRC-32 IR",
    blurb: "IEEE polynomial — error-detecting, not a MAC.",
    expected: ["CRC32"],
    format: "ir",
  },
  {
    id: "benign",
    filename: "benign.ll",
    title: "Benign IR",
    blurb: "Inventory helpers — negative control.",
    expected: [],
    format: "ir",
  },
  {
    id: "hmac",
    filename: "hmac.ll",
    title: "HMAC-SHA256 IR",
    blurb: "RFC 2104 ipad/opad + SHA-256 K[] constants.",
    expected: ["HMAC-SHA256", "SHA-256"],
    format: "ir",
  },
  {
    id: "aes_gcm",
    filename: "aes_gcm.ll",
    title: "AES-GCM IR",
    blurb: "GHASH R = 0xe1<<120 reduction constant.",
    expected: ["AES-GCM"],
    format: "ir",
  },
  {
    id: "curve25519",
    filename: "curve25519.ll",
    title: "Curve25519 IR",
    blurb: "RFC 7748 base point 9 + clamp mask.",
    expected: ["Curve25519"],
    format: "ir",
  },
  {
    id: "vendor_openssl_stripped",
    filename: "vendor_openssl_aes_stripped.o",
    title: "Stripped vendor AES (.o)",
    blurb: "OpenSSL Te0 + S-box, strip --strip-all — no symbols.",
    expected: ["AES"],
    format: "elf",
  },
  {
    id: "enterprise_mix_stripped",
    filename: "enterprise_mix_stripped.o",
    title: "Stripped enterprise mix (.o)",
    blurb: "-O2 stripped multi-crypto ELF object from enterprise_mix.c.",
    expected: ["AES", "SHA-256", "ChaCha20", "MD5"],
    format: "elf",
  },
  {
    id: "tls_ciphers",
    filename: "tls_ciphers.ll",
    title: "TLS cipher suites IR",
    blurb: "IANA TLS 1.2/1.3 cipher suite identifier table.",
    expected: ["TLS-stack"],
    format: "ir",
  },
  {
    id: "rsa_pkcs1",
    filename: "rsa_pkcs1.ll",
    title: "RSA PKCS#1 key IR",
    blurb: "rsaEncryption OID + exponent 65537 + modulus placeholder.",
    expected: ["RSA-key"],
    format: "ir",
  },
  {
    id: "nist_drbg",
    filename: "nist_drbg.ll",
    title: "NIST DRBG IR",
    blurb: "Hash_DRBG label + CAVP V vector head.",
    expected: ["DRBG"],
    format: "ir",
  },
  {
    id: "crypto_firmware_pe",
    filename: "crypto_firmware.pe.bin",
    title: "PE firmware blob",
    blurb: "Minimal MZ/PE image with AES S-box + TLS ciphers in rodata.",
    expected: ["AES", "TLS-stack"],
    format: "elf",
  },
  {
    id: "vendor_aes_so",
    filename: "vendor_aes_stripped.so",
    title: "Stripped vendor AES (.so)",
    blurb: "Shared object, strip --strip-all — Linux firmware/vendor slice.",
    expected: ["AES"],
    format: "elf",
  },
];

export function corpusIrDir(): string {
  return path.join(process.cwd(), "corpus", "ir");
}

export function corpusBinDir(): string {
  return path.join(process.cwd(), "corpus", "bin");
}

export function listSampleFiles(): string[] {
  try {
    return readdirSync(corpusIrDir()).filter((f) => f.endsWith(".ll"));
  } catch {
    return [];
  }
}

export function readSample(id: string): {
  filename: string;
  ir?: string;
  base64?: string;
  format: "ir" | "elf";
} | null {
  const meta = SAMPLE_CATALOG.find((s) => s.id === id);
  if (!meta) return null;
  try {
    if (meta.format === "elf") {
      const buf = readFileSync(path.join(corpusBinDir(), meta.filename));
      return { filename: meta.filename, base64: buf.toString("base64"), format: "elf" };
    }
    const ir = readFileSync(path.join(corpusIrDir(), meta.filename), "utf8");
    return { filename: meta.filename, ir, format: "ir" };
  } catch {
    return null;
  }
}

export function readSampleIr(id: string): { filename: string; ir: string } | null {
  const s = readSample(id);
  if (!s?.ir) return null;
  return { filename: s.filename, ir: s.ir };
}
