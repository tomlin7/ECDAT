import type { FunctionRecord, GlobalConstant } from "./types";

const DEFINE_RE = /^define\s+.*?@([\w.$]+)\s*\(/;

export function decodeLlvmCString(raw: string): number[] {
  const bytes: number[] = [];
  for (let i = 0; i < raw.length; i++) {
    if (
      raw[i] === "\\" &&
      i + 2 < raw.length &&
      isHex(raw[i + 1]) &&
      isHex(raw[i + 2])
    ) {
      bytes.push(parseInt(raw.slice(i + 1, i + 3), 16));
      i += 2;
    } else {
      bytes.push(raw.charCodeAt(i) & 0xff);
    }
  }
  return bytes;
}

function isHex(ch: string): boolean {
  return /[0-9a-fA-F]/.test(ch);
}

export function parseI32List(blob: string): number[] {
  const words: number[] = [];
  const re = /i32\s+(-?\d+|0x[0-9a-fA-F]+)/g;
  let m: RegExpExecArray | null;
  while ((m = re.exec(blob))) {
    const token = m[1];
    const n = token.startsWith("0x") || token.startsWith("0X")
      ? parseInt(token, 16)
      : parseInt(token, 10);
    if (!Number.isNaN(n)) words.push(n >>> 0);
  }
  return words;
}

export function extractTargetTriple(ir: string): string | null {
  const m = ir.match(/target\s+triple\s*=\s*"([^"]+)"/);
  return m ? m[1] : null;
}

export function extractGlobals(ir: string): GlobalConstant[] {
  const lines = ir.split(/\r?\n/);
  const globals: GlobalConstant[] = [];
  const header =
    /@([\w.$]+)\s*=\s*(?:(?:internal|private|dso_local|dllimport|external|weak|common)\s+)*(?:unnamed_addr\s+)?(?:local_unnamed_addr\s+)?constant\s+/;

  for (let i = 0; i < lines.length; i++) {
    const line = lines[i];
    const hm = line.match(header);
    if (!hm) continue;

    let blob = line;
    let j = i;
    while (!blob.includes("[") && j + 1 < lines.length && j - i < 3) {
      j += 1;
      blob += lines[j];
    }
    // Multi-line array constants
    while (
      blob.includes("[") &&
      (blob.split("[").length > blob.split("]").length ||
        (blob.includes('c"') && (blob.match(/c"/g)?.length ?? 0) >
          (blob.match(/"/g)?.length ?? 0) / 2)) &&
      j + 1 < lines.length &&
      j - i < 40
    ) {
      j += 1;
      blob += lines[j];
    }

    const name = hm[1];
    const bytes: number[] = [];
    const cMatch = blob.match(/c"((?:\\.|[^"\\])*)"/);
    if (cMatch) bytes.push(...decodeLlvmCString(cMatch[1]));

    const words32 = parseI32List(blob);
    globals.push({
      name,
      line: i + 1,
      bytes,
      words32,
      rawSnippet: blob.slice(0, 280),
    });
  }
  return globals;
}

export const OPCODE_KEYS = [
  "xor",
  "and",
  "or",
  "shl",
  "lshr",
  "ashr",
  "mul",
  "urem",
  "srem",
  "add",
  "sub",
  "icmp",
  "br",
  "call",
  "load",
  "store",
  "getelementptr",
  "zext",
  "trunc",
  "select",
] as const;

export function extractFunctions(ir: string): FunctionRecord[] {
  const lines = ir.split(/\r?\n/);
  const fns: FunctionRecord[] = [];
  let i = 0;
  while (i < lines.length) {
    const m = lines[i].match(DEFINE_RE);
    if (!m) {
      i += 1;
      continue;
    }
    const name = m[1];
    const start = i;
    let depth = 0;
    let started = false;
    let j = i;
    for (; j < lines.length; j++) {
      const l = lines[j];
      if (l.includes("{")) {
        depth += (l.match(/{/g) || []).length;
        started = true;
      }
      if (l.includes("}")) depth -= (l.match(/}/g) || []).length;
      if (started && depth <= 0) break;
    }
    const bodyLines = lines.slice(start, j + 1);
    const body = bodyLines.join("\n");
    const opcodes: Record<string, number> = {};
    for (const key of OPCODE_KEYS) opcodes[key] = 0;

    let blocks = 0;
    const globalsUsed = new Set<string>();
    for (const l of bodyLines) {
      if (/^\S+:/.test(l.trim()) || /; preds =/.test(l)) blocks += 1;
      for (const gm of l.matchAll(/@([\w.$]+)/g)) {
        if (gm[1] !== name) globalsUsed.add(gm[1]);
      }
    }

    // Recount opcodes more reliably from the whole body
    for (const key of OPCODE_KEYS) {
      const re = new RegExp(`(?:^|[\\s=])${key}\\s`, "gm");
      opcodes[key] = (body.match(re) || []).length;
    }

    const bitwise =
      opcodes.xor + opcodes.and + opcodes.or + opcodes.shl + opcodes.lshr + opcodes.ashr;
    const instructionCount = Math.max(
      1,
      (body.match(/^\s+%/gm) || []).length + opcodes.br,
    );

    fns.push({
      name,
      startLine: start + 1,
      endLine: j + 1,
      ir: body,
      blocks: Math.max(blocks, 1),
      edges: opcodes.br,
      opcodes,
      globalsUsed: [...globalsUsed],
      bitwiseDensity: bitwise / instructionCount,
      instructionCount,
    });
    i = j + 1;
  }
  return fns;
}

export function looksLikeLlvmIr(text: string): boolean {
  const head = text.slice(0, 4000);
  return (
    head.includes("target triple") ||
    head.includes("; ModuleID") ||
    head.includes("source_filename") ||
    /\bdefine\s+/.test(head) ||
    head.includes("target datalayout")
  );
}

export function looksLikeBitcode(buf: Uint8Array): boolean {
  return buf.length >= 4 && buf[0] === 0x42 && buf[1] === 0x43;
}
