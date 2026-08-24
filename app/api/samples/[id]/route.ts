import { NextResponse } from "next/server";
import { readSample, SAMPLE_CATALOG } from "@/lib/samples/catalog";

export const runtime = "nodejs";

export async function GET(
  _req: Request,
  ctx: { params: Promise<{ id: string }> },
) {
  const { id } = await ctx.params;
  const loaded = readSample(id);
  if (!loaded) {
    return NextResponse.json({ error: "Unknown sample" }, { status: 404 });
  }
  const meta = SAMPLE_CATALOG.find((s) => s.id === id);
  return NextResponse.json({ ...loaded, meta });
}
