import { NextResponse } from "next/server";
import { analyzeArtifact } from "@/lib/pipeline";

export const runtime = "nodejs";

const MAX_BYTES = 8_000_000;

export async function POST(req: Request) {
  try {
    const contentType = req.headers.get("content-type") ?? "";
    let filename = "pasted.ll";
    let buf: Uint8Array | null = null;

    if (contentType.includes("multipart/form-data")) {
      const form = await req.formData();
      const file = form.get("file");
      if (file instanceof File) {
        filename = file.name || filename;
        if (file.size > MAX_BYTES) {
          return NextResponse.json(
            { error: "File is larger than 8 MB." },
            { status: 413 },
          );
        }
        buf = new Uint8Array(await file.arrayBuffer());
      }
      const pasted = form.get("ir");
      if (!buf && typeof pasted === "string") {
        buf = new TextEncoder().encode(pasted);
      }
    } else {
      const body = (await req.json()) as { ir?: string; filename?: string; base64?: string };
      filename = body.filename ?? filename;
      if (body.base64) buf = Uint8Array.from(Buffer.from(body.base64, "base64"));
      else buf = new TextEncoder().encode(body.ir ?? "");
    }

    if (!buf || buf.length === 0) {
      return NextResponse.json(
        { error: "No file provided. Upload a compiled binary (ELF, PE, Mach-O, .o/.so/.exe, firmware dump), or paste LLVM IR only for lab use." },
        { status: 400 },
      );
    }

    const report = analyzeArtifact(buf, filename);
    if (
      report.findings.length === 0 &&
      report.functionCount === 0 &&
      !report.ingest.channels.binary &&
      report.ingest.kind === "unknown-binary"
    ) {
      return NextResponse.json(
        {
          error:
            "Unrecognized file. Product input is a compiled image: ELF, PE, Mach-O, object/shared library, or raw firmware dump (max 8 MB). LLVM IR (.ll) is optional lab input. Source code is not accepted — compile it, then upload the binary.",
        },
        { status: 415 },
      );
    }

    return NextResponse.json(report);
  } catch (err) {
    const message = err instanceof Error ? err.message : "Analysis failed";
    return NextResponse.json({ error: message }, { status: 500 });
  }
}
