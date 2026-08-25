import { mkdirSync, writeFileSync } from "node:fs";
import path from "node:path";
import { AES_SBOX, TLS_CIPHER_HEAD_LE } from "../lib/ir/signatures";

/** Minimal MZ/PE shell with crypto constants embedded — firmware/Windows blob demo. */
const outDir = path.join(process.cwd(), "corpus", "bin");
mkdirSync(outDir, { recursive: true });

const buf = Buffer.alloc(8192, 0);
buf[0] = 0x4d;
buf[1] = 0x5a; /* MZ */
buf.write("PE\0\0", 0x100);
buf.set(Buffer.from(AES_SBOX), 0x400);
buf.set(Buffer.from(TLS_CIPHER_HEAD_LE), 0x700);

const out = path.join(outDir, "crypto_firmware.pe.bin");
writeFileSync(out, buf);
console.log(`wrote ${out} (${buf.length} bytes, kind=pe)`);
