import {
  AES_SBOX_HEAD,
  AES_SBOX_TAIL,
  CHACHA_SIGMA,
  CRC32_POLY,
  DES_IP_HEAD,
  MD5_T_HEAD,
  SHA1_K,
  SHA256_K_HEAD,
  bytesContain,
  wordsContain,
} from "./signatures";
import type {
  Evidence,
  Finding,
  FunctionRecord,
  GlobalConstant,
  PrimitiveId,
  Severity,
} from "./types";

type Hit = {
  primitive: PrimitiveId;
  score: number;
  evidence: Evidence[];
  functions: Set<string>;
  notes: string[];
};

function hit(primitive: PrimitiveId): Hit {
  return {
    primitive,
    score: 0,
    evidence: [],
    functions: new Set(),
    notes: [],
  };
}

function functionsUsing(
  fns: FunctionRecord[],
  globalName: string,
): FunctionRecord[] {
  return fns.filter(
    (f) =>
      f.globalsUsed.includes(globalName) ||
      f.ir.includes(`@${globalName}`),
  );
}

function nameHint(fn: FunctionRecord, needle: RegExp): boolean {
  return needle.test(fn.name);
}

export function classify(
  globals: GlobalConstant[],
  functions: FunctionRecord[],
): Finding[] {
  const hits = new Map<PrimitiveId, Hit>();
  const take = (p: PrimitiveId) => {
    let h = hits.get(p);
    if (!h) {
      h = hit(p);
      hits.set(p, h);
    }
    return h;
  };

  for (const g of globals) {
    if (
      bytesContain(g.bytes, AES_SBOX_HEAD) ||
      (g.bytes.length >= 256 &&
        bytesContain(g.bytes, AES_SBOX_HEAD.slice(0, 8)) &&
        bytesContain(g.bytes, AES_SBOX_TAIL))
    ) {
      const h = take("AES");
      h.score += 0.55;
      h.evidence.push({
        kind: "constant-table",
        summary: `AES S-box (256-byte FIPS-197 substitution table) in @${g.name}`,
        line: g.line,
        snippet: g.rawSnippet.slice(0, 160),
      });
      for (const f of functionsUsing(functions, g.name)) {
        h.functions.add(f.name);
        h.score += 0.08;
      }
      h.notes.push(
        "Table-driven SubBytes is not constant-time; cache timing can leak key bytes.",
      );
    }

    if (wordsContain(g.words32, SHA256_K_HEAD)) {
      const h = take("SHA-256");
      h.score += 0.6;
      h.evidence.push({
        kind: "constant-table",
        summary: `SHA-256 round constants K[0..3] in @${g.name}`,
        line: g.line,
        snippet: g.rawSnippet.slice(0, 160),
      });
      for (const f of functionsUsing(functions, g.name)) h.functions.add(f.name);
    }

    if (wordsContain(g.words32, SHA1_K)) {
      const h = take("SHA-1");
      h.score += 0.7;
      h.evidence.push({
        kind: "constant-table",
        summary: `SHA-1 round constants in @${g.name}`,
        line: g.line,
        snippet: g.rawSnippet.slice(0, 160),
      });
      h.notes.push("SHA-1 is broken for collision resistance (CA/B, NIST).");
      for (const f of functionsUsing(functions, g.name)) h.functions.add(f.name);
    }

    if (wordsContain(g.words32, MD5_T_HEAD)) {
      const h = take("MD5");
      h.score += 0.7;
      h.evidence.push({
        kind: "constant-table",
        summary: `MD5 sine table T[0..3] in @${g.name}`,
        line: g.line,
        snippet: g.rawSnippet.slice(0, 160),
      });
      h.notes.push("MD5 is cryptographically broken; do not use for integrity or passwords.");
      for (const f of functionsUsing(functions, g.name)) h.functions.add(f.name);
    }

    if (wordsContain(g.words32, CHACHA_SIGMA)) {
      const h = take("ChaCha20");
      h.score += 0.65;
      h.evidence.push({
        kind: "constant-table",
        summary: `ChaCha20 sigma words ("expand 32-byte k") in @${g.name}`,
        line: g.line,
        snippet: g.rawSnippet.slice(0, 160),
      });
      for (const f of functionsUsing(functions, g.name)) h.functions.add(f.name);
    }

    if (wordsContain(g.words32, CRC32_POLY) || g.words32.includes(0xedb88320)) {
      const h = take("CRC32");
      h.score += 0.55;
      h.evidence.push({
        kind: "constant-table",
        summary: `CRC-32 polynomial 0xEDB88320 in @${g.name}`,
        line: g.line,
      });
      h.notes.push("CRC is an error-detecting code, not a cryptographic MAC.");
    }

    if (g.bytes.length >= 8 && bytesContain(g.bytes, DES_IP_HEAD)) {
      const h = take("DES");
      h.score += 0.45;
      h.evidence.push({
        kind: "constant-table",
        summary: `DES IP permutation prefix in @${g.name}`,
        line: g.line,
      });
      h.notes.push("DES (56-bit) is obsolete.");
    }
  }

  for (const f of functions) {
    const { opcodes } = f;
    if (/3988292384|0xedb88320/i.test(f.ir) || nameHint(f, /crc32/i)) {
      const h = take("CRC32");
      h.functions.add(f.name);
      h.score += nameHint(f, /crc32/i) ? 0.4 : 0.3;
      h.evidence.push({
        kind: "opcode-mix",
        summary: `${f.name}: IEEE CRC-32 polynomial immediate`,
        line: f.startLine,
      });
      h.notes.push("CRC is an error-detecting code, not a cryptographic MAC.");
    }
    const xorHeavy = opcodes.xor >= 6;
    const rotate =
      (opcodes.shl >= 3 && opcodes.lshr >= 3) ||
      (opcodes.shl >= 3 && opcodes.ashr >= 3);
    const mixColumnsShape =
      opcodes.xor >= 8 && opcodes.shl >= 2 && f.blocks >= 3;

    if (
      (nameHint(f, /aes|rijndael|subbytes|mixcolumn/i) || mixColumnsShape) &&
      xorHeavy
    ) {
      const h = take("AES");
      h.functions.add(f.name);
      h.score += nameHint(f, /aes|rijndael/i) ? 0.25 : 0.1;
      h.evidence.push({
        kind: "opcode-mix",
        summary: `${f.name}: XOR-heavy GF(2^8)-style mix (${opcodes.xor} xor, ${opcodes.shl} shl) across ${f.blocks} blocks`,
        line: f.startLine,
      });
    }

    if (
      rotate &&
      opcodes.and >= 4 &&
      opcodes.xor >= 4 &&
      (nameHint(f, /sha256|sha2/i) || f.instructionCount > 80)
    ) {
      if (nameHint(f, /sha256|sha2/i) || hits.has("SHA-256")) {
        const h = take("SHA-256");
        h.functions.add(f.name);
        h.score += 0.12;
        h.evidence.push({
          kind: "opcode-mix",
          summary: `${f.name}: Ch/Maj-like bitwise mix with rotates`,
          line: f.startLine,
        });
      }
    }

    if (nameHint(f, /chacha|salsa|quarter_round/i) || (rotate && opcodes.add >= 8 && opcodes.xor >= 6)) {
      if (nameHint(f, /chacha|salsa/i) || hits.has("ChaCha20")) {
        const h = take("ChaCha20");
        h.functions.add(f.name);
        h.score += nameHint(f, /chacha|salsa/i) ? 0.2 : 0.08;
        h.evidence.push({
          kind: "cfg",
          summary: `${f.name}: ARX quarter-round shape (add/rotate/xor)`,
          line: f.startLine,
        });
      }
    }

    if (nameHint(f, /md5/i)) {
      const h = take("MD5");
      h.functions.add(f.name);
      h.score += 0.15;
      h.evidence.push({
        kind: "name",
        summary: `Function name ${f.name} matches MD5`,
        line: f.startLine,
      });
    }

    const wideRem = /(?:urem|srem)\s+i(?:64|128)/.test(f.ir);
    const modexp =
      wideRem &&
      opcodes.mul >= 2 &&
      (opcodes.lshr >= 1 || opcodes.and >= 1) &&
      f.blocks >= 3 &&
      !nameHint(f, /md5|sha|aes|chacha|crc/i);
    if (modexp || nameHint(f, /modexp|mod_pow|rsa|powm/i)) {
      const h = take("RSA-modexp");
      h.functions.add(f.name);
      h.score += nameHint(f, /rsa|modexp/i) ? 0.45 : 0.28;
      h.evidence.push({
        kind: "opcode-mix",
        summary: `${f.name}: square-and-multiply shape (${opcodes.mul} mul, ${opcodes.urem + opcodes.srem} rem, ${f.blocks} blocks)`,
        line: f.startLine,
      });
      h.notes.push(
        "Secret-dependent exponent bits in a branchy modexp leak via timing; use Montgomery ladder / const-time pow.",
      );
    }
  }

  const findings: Finding[] = [];
  let n = 0;
  for (const h of hits.values()) {
    const confidence = Math.min(0.99, Math.round(h.score * 100) / 100);
    if (confidence < 0.28) continue;
    n += 1;
    findings.push({
      id: `F${String(n).padStart(2, "0")}`,
      primitive: h.primitive,
      confidence,
      severity: severityFor(h.primitive),
      title: titleFor(h.primitive),
      rationale: rationaleFor(h.primitive),
      functions: [...h.functions],
      evidence: h.evidence,
      notes: [...new Set(h.notes)],
      source: "signature",
    });
  }

  findings.sort((a, b) => b.confidence - a.confidence);
  return findings;
}

export function severityFor(p: PrimitiveId): Severity {
  if (p === "MD5" || p === "SHA-1" || p === "DES" || p === "CRC32") return "weak";
  if (p === "RSA-modexp") return "info";
  return "ok";
}

export function titleFor(p: PrimitiveId): string {
  switch (p) {
    case "AES":
      return "AES (Rijndael) substitution / mix-columns";
    case "SHA-256":
      return "SHA-256 compression function";
    case "SHA-1":
      return "SHA-1 compression function";
    case "MD5":
      return "MD5 compression function";
    case "ChaCha20":
      return "ChaCha20 / Salsa20 stream cipher";
    case "RSA-modexp":
      return "Integer modular exponentiation (RSA-like)";
    case "CRC32":
      return "CRC-32 checksum";
    case "DES":
      return "DES permutation tables";
  }
}

export function rationaleFor(p: PrimitiveId): string {
  switch (p) {
    case "AES":
      return "FIPS-197 S-box bytes and/or GF(2^8) xtime/mix-columns dataflow in LLVM IR.";
    case "SHA-256":
      return "FIPS-180 K[] round constants plus Ch/Maj/Σ rotate structure.";
    case "SHA-1":
      return "Classic SHA-1 round constants K_t present in the module.";
    case "MD5":
      return "RFC 1321 T[] sine table matched in a global constant.";
    case "ChaCha20":
      return "ASCII sigma constants decode to \"expand 32-byte k\" with ARX rounds.";
    case "RSA-modexp":
      return "Square-and-multiply loop with multiply + remainder; typical of RSA/DH exp.";
    case "CRC32":
      return "Reflected IEEE CRC-32 polynomial appears as an immediate or table.";
    case "DES":
      return "DES initial permutation nibble sequence in a constant array.";
  }
}
