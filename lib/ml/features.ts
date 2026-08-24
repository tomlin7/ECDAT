import { OPCODE_KEYS } from "../ir/parse";
import type { FunctionRecord } from "../ir/types";

export const FEATURE_NAMES = [
  ...OPCODE_KEYS.map((k) => `op_${k}`),
  "bitwiseDensity",
  "logInst",
  "logBlocks",
  "edgeRatio",
  "wideRem",
  "arx",
  "gf2",
  "i8Load",
  "i32Load",
  "table256i8",
  "table64i32",
] as const;

export type FeatureName = (typeof FEATURE_NAMES)[number];

export function functionFeatures(fn: FunctionRecord): number[] {
  const op = fn.opcodes;
  const inst = Math.max(1, fn.instructionCount);
  const vec: number[] = [];
  for (const k of OPCODE_KEYS) {
    vec.push((op[k] ?? 0) / inst);
  }
  const xor = op.xor ?? 0;
  const shl = op.shl ?? 0;
  const lshr = op.lshr ?? 0;
  const add = op.add ?? 0;
  const wideRem = /(?:urem|srem)\s+i(?:64|128)/.test(fn.ir) ? 1 : 0;
  vec.push(
    fn.bitwiseDensity,
    Math.log2(inst),
    Math.log2(Math.max(1, fn.blocks)),
    fn.edges / Math.max(1, fn.blocks),
    wideRem,
    add >= 4 && xor >= 4 && (shl >= 2 || lshr >= 2) ? 1 : 0,
    xor >= 6 && shl >= 2 ? 1 : 0,
    (fn.ir.match(/load i8/g) || []).length / inst,
    (fn.ir.match(/load i32/g) || []).length / inst,
    /256 x i8/.test(fn.ir) ? 1 : 0,
    /64 x i32/.test(fn.ir) ? 1 : 0,
  );
  return vec;
}
