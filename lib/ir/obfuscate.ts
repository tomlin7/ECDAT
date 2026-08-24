import { extractFunctions } from "./parse";

function rng(seed: number): () => number {
  let s = seed >>> 0 || 1;
  return () => {
    s = (Math.imul(s, 1664525) + 1013904223) >>> 0;
    return s / 0x100000000;
  };
}

/** Structural IR mutations that keep constant tables intact (IP-protection style, not AV evasion). */
export function obfuscateIr(ir: string, seed: number): string {
  const rand = rng(seed);
  let out = ir;

  out = out.replace(/(entry:)/g, (_m, label: string) => {
    const id = Math.floor(rand() * 1e6);
    return `${label}\n  %obf.${id} = xor i32 0, 0\n  %obf.and.${id} = and i32 %obf.${id}, -1`;
  });

  const fns = extractFunctions(out);
  const map = new Map<string, string>();
  fns.forEach((fn, i) => {
    if (fn.name.startsWith("llvm.")) return;
    map.set(fn.name, `fn_${seed}_${i}`);
  });
  for (const [from, to] of map) {
    out = out.replace(new RegExp(`@${escapeReg(from)}\\b`, "g"), `@${to}`);
  }

  out = `; ECDAT training mutation seed=${seed}\n` + out;
  return out;
}

function escapeReg(s: string): string {
  return s.replace(/[.*+?^${}()|[\]\\]/g, "\\$&");
}
