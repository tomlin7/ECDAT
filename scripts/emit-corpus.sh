#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SRC="$ROOT/corpus/src"
OUT="$ROOT/corpus/ir"
BIN="$ROOT/corpus/bin"
mkdir -p "$OUT" "$BIN"
FLAGS=(-S -emit-llvm -fno-discard-value-names)
compile_ll () {
  local name="$1"
  clang "${FLAGS[@]}" -O0 -o "$OUT/${name}.ll" "$SRC/${name}.c"
  clang "${FLAGS[@]}" -O1 -o "$OUT/${name}.O1.ll" "$SRC/${name}.c"
  clang "${FLAGS[@]}" -O2 -o "$OUT/${name}.O2.ll" "$SRC/${name}.c"
  clang -c -O0 -fno-discard-value-names -o "$BIN/${name}.o" "$SRC/${name}.c"
}
for name in aes sha256 sha1 chacha20 md5 rsa_modexp crc32 benign; do
  compile_ll "$name"
done
clang "${FLAGS[@]}" -O0 -I "$SRC" -o "$OUT/enterprise_mix.ll" "$SRC/enterprise_mix.c"
clang -c -O0 -I "$SRC" -o "$BIN/enterprise_mix.o" "$SRC/enterprise_mix.c"
echo "wrote $OUT and $BIN"
