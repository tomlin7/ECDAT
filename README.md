# ECDAT — Enterprise Cryptographic Discovery & Analysis Tool

**Product definition:** [PRD.md](./PRD.md) (binding).

SIH 2026 **SIH26164** (NTRO). Static inventory of cryptographic primitives in a **compiled binary or firmware image**. No execution. The operator does not need Clang, GCC, or any other compiler.

## What you give it

| You have | ECDAT accepts it? |
| --- | --- |
| ELF / PE / Mach-O / `.o` / `.so` / `.exe` / raw firmware dump | **Yes — this is the product input** |
| LLVM IR (`.ll`) | Optional lab input only, not the demo |
| `.c` / other source | No. Compile it yourself; then upload the binary |

Max 8 MB. Upload on **Ingest**, or click a **binary** card on Discover / Corpus.

## What you get

A per-file **cryptographic inventory**: primitive, severity (including weak/deprecated), evidence, JSON + HTML export.

This is inventory of *presence of known tables / patterns*, not proof of runtime use.

## Demo (the only pitch path)

```bash
npm install
npm run dev          # http://127.0.0.1:43147
```

1. Open the workbench (Discover).
2. Click a **stripped binary** sample (e.g. **Stripped vendor AES (.so)** or **PE firmware blob**).
3. Read the inventory. Export JSON/HTML.

Do not start the demo by pasting IR or running Clang.

### Lab / corpus (developers, not the pitch)

```bash
npm run corpus      # clang → IR + .o  (needs clang; for labeled samples only)
npm run train
npm run verify
```

## Layout

- `PRD.md` — purpose, audience, input, output
- `lib/binary/` — ELF/PE/Mach-O magic + constant-table scan (**product path**)
- `lib/ir/` — LLVM IR parse + signatures (**lab path**)
- `lib/ml/` — CFG opcode model on IR functions (**lab path**)
- `lib/pipeline.ts` — routes a file to the channels that apply
- `corpus/bin` — demo binaries · `corpus/ir` — lab IR
