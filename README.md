# ECDAT — Enterprise Cryptographic Discovery & Analysis Tool

SIH 2026 **SIH26164** (NTRO, Software, Blockchain & Cybersecurity).

Three static channels, no execution:

1. **LLVM IR signatures** — FIPS/RFC constant tables and CFG opcode mix in `.ll`
2. **CFG model** — softmax logistic regression on per-function opcode/graph features, trained on clean Clang IR, `-O1`/`-O2`, and structurally mutated IR (junk arithmetic + stripped names)
3. **Raw binary scan** — AES S-box, SHA-1/256 K[], ChaCha sigma, MD5 T[], CRC-32 poly in ELF/PE file images

Weak/deprecated primitives (MD5, SHA-1, DES, CRC-32) are flagged. This is inventory, not evasion.

## Run

```bash
npm install
npm run corpus      # clang → IR + .o  (needs clang)
npm run train       # writes lib/ml/model.json
npm run verify
npm run dev         # http://127.0.0.1:43147
```

Click **Enterprise mix (IR)** then **AES ELF object**.

### Your own code

```bash
clang -S -emit-llvm -O0 -fno-discard-value-names -o module.ll your.c
clang -c -O0 -o module.o your.c
```

Drop either file on the ingest panel.

## Layout

- `lib/ir/` — parse, signatures, IR obfuscation used only as a **training augmenter**
- `lib/ml/` — features, trainer, `model.json`
- `lib/binary/` — ELF/PE/Mach-O magic + constant-table scan
- `lib/pipeline.ts` — fuses the three channels
- `corpus/src` C · `corpus/ir` LLVM · `corpus/bin` objects

## Stack

Next.js · TypeScript · Tailwind · shadcn/ui · Clang LLVM IR
