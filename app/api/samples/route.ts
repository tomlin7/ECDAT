import { NextResponse } from "next/server";
import { SAMPLE_CATALOG } from "@/lib/samples/catalog";

export const runtime = "nodejs";

export function GET() {
  return NextResponse.json({ samples: SAMPLE_CATALOG });
}
