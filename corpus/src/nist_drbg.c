/*
 * NIST SP 800-90A Hash_DRBG (SHA-256) — KAT V vector head.
 * Detects deterministic random generator tables in enterprise binaries.
 */
#include <stdint.h>
#include <string.h>

static const char drbg_label[] = "Hash_DRBG";
static const char hmac_drbg_label[] = "HMAC_DRBG";

/* NIST CAVP SHA-256 Hash_DRBG V after instantiate (first 32 bytes) */
static const uint8_t hash_drbg_v0[32] = {
    0x1a, 0x88, 0xc2, 0x47, 0x28, 0x1f, 0x71, 0x77, 0xca, 0x03, 0x26, 0x53,
    0xda, 0x42, 0xbc, 0x94, 0xd9, 0x28, 0x7b, 0x34, 0x3b, 0x45, 0x61, 0x8a,
    0x51, 0x59, 0x4a, 0x8d, 0x9f, 0x0c, 0x62, 0x05};

void drbg_seed(uint8_t out[32]) {
  memcpy(out, hash_drbg_v0, 32);
  (void)drbg_label;
  (void)hmac_drbg_label;
}
