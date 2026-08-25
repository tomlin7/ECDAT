import { rationaleFor, titleFor } from "./ir/classify";
import type {
  EnterpriseInventory,
  Finding,
  FindingSource,
  IngestKind,
  InventoryRow,
  PrimitiveId,
} from "./ir/types";

export type InventoryInput = {
  filename: string;
  scannedAt: string;
  targetTriple: string | null;
  findings: Finding[];
  weakCount: number;
  summary: string;
  ingest: { kind: IngestKind; bytes: number; channels: { signatures: boolean; ml: boolean; binary: boolean } };
  mlHoldout: number | null;
};

const RECOMMENDATIONS: Partial<Record<PrimitiveId, string>> = {
  AES: "Inventory key schedule usage; prefer AES-GCM or ChaCha20-Poly1305 for AEAD.",
  "AES-GCM": "Verify unique nonces per key; rotate keys on nonce reuse risk.",
  "SHA-256": "Acceptable for integrity; pair with HMAC or AEAD for authentication.",
  "SHA-1": "Replace with SHA-256 or SHA-3; SHA-1 is collision-broken.",
  MD5: "Remove immediately; use SHA-256+ or BLAKE2.",
  "HMAC-SHA256": "Verify key length ≥256 bits and secure key storage.",
  ChaCha20: "Modern stream cipher; ensure Poly1305 for authentication.",
  Curve25519: "Prefer for ECDH; verify constant-time scalar multiply.",
  "RSA-modexp": "Audit key length (≥2048 bits); use OAEP/PSS padding.",
  "RSA-key": "Inventory modulus size; disable PKCS#1 v1.5 padding where possible.",
  "TLS-stack": "Review cipher suite order; disable TLS 1.0/1.1 and weak ciphers.",
  DRBG: "Verify entropy source and reseed interval for NIST SP 800-90A compliance.",
  CRC32: "Not a MAC — do not use for integrity against adversaries.",
  DES: "Remove; use AES-256.",
};

function channelLabel(source: FindingSource): string {
  if (source === "binary") return "raw-bytes";
  if (source === "ml") return "cfg-model";
  return "ir-signatures";
}

function locationsFor(f: Finding): string[] {
  const locs: string[] = [];
  for (const fn of f.functions) locs.push(`function:@${fn}`);
  for (const ev of f.evidence) {
    if (ev.offset != null) locs.push(`offset:0x${ev.offset.toString(16)}`);
    if (ev.line != null) locs.push(`ir:line:${ev.line}`);
  }
  if (!locs.length) locs.push("module-global");
  return locs;
}

export function buildEnterpriseInventory(
  report: InventoryInput,
  assetId?: string,
): EnterpriseInventory {
  const rows: InventoryRow[] = report.findings.map((f) => ({
    id: f.id,
    primitive: f.primitive,
    title: f.title || titleFor(f.primitive),
    severity: f.severity,
    confidence: f.confidence,
    source: f.source,
    channels: [channelLabel(f.source)],
    locations: locationsFor(f),
    recommendation:
      RECOMMENDATIONS[f.primitive] ??
      rationaleFor(f.primitive).slice(0, 120),
    evidenceCount: f.evidence.length,
    notes: f.notes,
  }));

  const weak = rows.filter((r) => r.severity === "weak");
  const ok = rows.filter((r) => r.severity === "ok");
  const review = rows.filter((r) => r.severity === "info");

  return {
    schema: "ecdat-inventory-v1",
    assetId: assetId ?? report.filename,
    businessUnit: "unspecified",
    scannedAt: report.scannedAt,
    filename: report.filename,
    ingestKind: report.ingest.kind,
    byteSize: report.ingest.bytes,
    targetTriple: report.targetTriple,
    channelsUsed: report.ingest.channels,
    primitiveCount: rows.length,
    weakCount: report.weakCount,
    counts: { weak: weak.length, ok: ok.length, review: review.length },
    rows,
    summary: report.summary,
    mlHoldout: report.mlHoldout,
  };
}

export function inventoryToJson(inv: EnterpriseInventory): string {
  return JSON.stringify(inv, null, 2);
}

export function inventoryToHtml(inv: EnterpriseInventory): string {
  const rows = inv.rows
    .map(
      (r) => `<tr>
        <td>${r.id}</td>
        <td>${r.primitive}</td>
        <td>${r.severity}</td>
        <td>${(r.confidence * 100).toFixed(0)}%</td>
        <td>${r.channels.join(", ")}</td>
        <td>${r.locations.join("; ")}</td>
        <td>${r.recommendation}</td>
      </tr>`,
    )
    .join("\n");

  return `<!DOCTYPE html>
<html lang="en"><head><meta charset="utf-8"/>
<title>ECDAT Inventory — ${inv.filename}</title>
<style>
  body{font-family:system-ui,sans-serif;margin:2rem;color:#111}
  h1{font-size:1.25rem} table{border-collapse:collapse;width:100%;font-size:0.85rem}
  th,td{border:1px solid #ccc;padding:0.4rem 0.6rem;text-align:left;vertical-align:top}
  th{background:#f4f4f4}.weak{color:#b45309}.meta{color:#555;font-size:0.9rem}
</style></head><body>
<h1>ECDAT Cryptographic Inventory</h1>
<p class="meta">Asset <strong>${inv.assetId}</strong> · ${inv.filename} · ${inv.scannedAt}<br/>
${inv.byteSize} bytes · ${inv.primitiveCount} primitives · ${inv.weakCount} weak/deprecated</p>
<p>${inv.summary}</p>
<table>
  <thead><tr><th>ID</th><th>Primitive</th><th>Severity</th><th>Conf</th><th>Channel</th><th>Location</th><th>Recommendation</th></tr></thead>
  <tbody>${rows}</tbody>
</table>
<p class="meta">Static analysis only — SIH26164 ECDAT · no execution</p>
</body></html>`;
}
