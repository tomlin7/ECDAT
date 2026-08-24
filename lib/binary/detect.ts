import type { IngestKind } from "../ir/types";
import { looksLikeBitcode, looksLikeLlvmIr } from "../ir/parse";

export function detectKind(buf: Uint8Array, filename: string, textHint?: string): IngestKind {
  const name = filename.toLowerCase();
  if (looksLikeBitcode(buf)) return "bitcode";
  if (buf.length >= 4 && buf[0] === 0x7f && buf[1] === 0x45 && buf[2] === 0x4c && buf[3] === 0x46)
    return "elf";
  if (buf.length >= 2 && buf[0] === 0x4d && buf[1] === 0x5a) return "pe";
  if (
    buf.length >= 4 &&
    ((buf[0] === 0xcf && buf[1] === 0xfa && buf[2] === 0xed && buf[3] === 0xfe) ||
      (buf[0] === 0xfe && buf[1] === 0xed && buf[2] === 0xfa && buf[3] === 0xce) ||
      (buf[0] === 0xca && buf[1] === 0xfe && buf[2] === 0xba && buf[3] === 0xbe))
  )
    return "macho";

  const text =
    textHint ?? new TextDecoder("utf-8", { fatal: false }).decode(buf.slice(0, 8000));
  if (looksLikeLlvmIr(text) || name.endsWith(".ll") || name.endsWith(".ir")) {
    return filename === "pasted.ll" ? "pasted-ir" : "llvm-ir";
  }
  return "unknown-binary";
}
