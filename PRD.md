# ECDAT — Product Requirements

**Status:** binding. If the UI, README, or demo disagree with this file, this file wins.

**Problem ID:** SIH 2026 SIH26164 (NTRO — Software, Blockchain & Cybersecurity)

---

## 1. Purpose (one sentence)

ECDAT inventories **which cryptographic primitives are present in a compiled binary or firmware image**, using static analysis only (no execution).

That is the whole product. It is not a compiler, not a decompiler, not a source-code linter, and not an LLVM workbench.

---

## 2. Audience

| Role | Uses ECDAT to |
| --- | --- |
| **Primary — NTRO / enterprise crypto-inventory analyst** | Drop a firmware dump, `.so`, `.exe`, or object file and get a primitive list with evidence. They do **not** have a build tree. They do **not** choose the compiler. |
| **Secondary — SIH evaluator** | Run the published demo on labeled binaries and see the same inventory export. |
| **Out of audience** | Compiler engineers, people who only have `.c` / `.java` / `.py` source, people who expect a full reverse-engineering suite. |

---

## 3. Input contract (strict)

### 3.1 Product input (what the operator is expected to provide)

**One file. A compiled image.** Accepted formats:

| Kind | How it is recognized | What analysis runs |
| --- | --- | --- |
| ELF | magic `7f 45 4c 46` | raw-byte constant tables |
| PE / COFF (incl. MZ) | magic `4d 5a` | raw-byte constant tables |
| Mach-O | standard Mach-O magics | raw-byte constant tables |
| Raw firmware / unknown blob | none of the above, not LLVM IR | raw-byte constant tables |
| LLVM bitcode | magic `42 43` (`BC`) | raw-byte constant tables only (not lifted) |

Hard limits:

- Max size: **8 MB**
- No network fetch. The file is uploaded to the analyzer.
- **No compiler is required of the operator.** GCC, Clang, MSVC, ICC, or a vendor toolchain — irrelevant. The input is the **bytes that already exist**.

### 3.2 Not product input

Do **not** tell operators to produce these in order to use ECDAT:

- C / C++ / Rust / Go / Java / Python source
- “Run Clang and emit LLVM IR”
- Debug symbols, PDB, DWARF (nice if present; not required)
- A running process, a VM, or a device under test

If the operator only has source, ECDAT is the wrong tool until that source is compiled by *their* toolchain into a binary. ECDAT does not compile.

### 3.3 Optional lab input (not the enterprise path)

**LLVM IR text** (`.ll`, paste box) is accepted as a **developer/lab** artifact for corpus and model work.

- It is **not** the SIH user story.
- It is **not** a substitute for firmware.
- IR dialect varies by producer (Clang, rustc, flang, etc.). ECDAT does not require Clang; it also does not claim to parse every IR dialect.
- The demo must not start here.

If a file looks like LLVM IR (`target triple`, `; ModuleID`, `define `, …), the IR signature + CFG-model channels run **in addition to** a raw-byte scan of the same bytes.

---

## 4. Output contract (strict)

One analysis of one file produces **one inventory** of cryptographic primitives.

Each row:

| Field | Meaning |
| --- | --- |
| Primitive | One of the supported IDs (AES, SHA-256, SHA-1, MD5, HMAC-SHA256, ChaCha20, Curve25519, RSA-modexp, RSA-key, AES-GCM, TLS-stack, DRBG, CRC32, DES) |
| Severity | `ok` / `weak` (deprecated or non-crypto checksum) / `info` |
| Confidence | 0–1, evidence-based; not a marketing score |
| Evidence | Constant-table match, raw-byte offset, and/or CFG-model score — whatever actually fired |
| Location | File offset and/or IR function name when available |

Exports:

- JSON (`ecdat-inventory-v1`)
- HTML table for non-technical review

Empty result is valid: **“no known primitive tables in this image.”** That is an answer, not a crash.

What the output is **not**:

- A claim that the binary *uses* the primitive at runtime (no execution)
- Key recovery, key-length measurement, or protocol state
- A full CBOM of certificates, live TLS, or filesystem scan

---

## 5. Demo (strict)

The demo is **binary-in, inventory-out**. One path:

1. Open the workbench.
2. Load a **stripped compiled sample** (ELF `.o` / `.so` or PE blob) — not a `.ll` file.
3. Show the inventory: primitive, evidence offset, weak flags.
4. Export JSON or HTML.

Forbidden as the opening demo:

- “Paste LLVM IR”
- “Run `clang -S -emit-llvm`”
- Starting on a `.ll` corpus card

Lab/IR samples may exist in **Corpus** for developers. They are not the pitch.

---

## 6. Non-goals (v1)

- Dynamic / emulated execution
- Lifting arbitrary binaries to LLVM IR (no Ghidra/RetDec pipeline in-product)
- Requiring a specific compiler from the operator
- Source-code secret scanning
- Network / host-wide discovery

---

## 7. The failure this PRD exists to prevent

**Unclear input = unclear product.**

SIH26164 is firmware/binary cryptographic discovery. LLVM IR is a compiler intermediate, not a firmware format, and not something “everyone” can emit. If the UI, README, or demo ask for IR first, the product is describing the lab harness instead of the product.
