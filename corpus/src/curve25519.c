/* Curve25519 field constants (RFC 7748) — base point 9, clamp mask. */
#include <stdint.h>

static const uint8_t curve25519_basepoint[32] = {
    9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};

static const uint8_t curve25519_clamp[4] = {0xf8, 0xff, 0xff, 0xff};

/* 2^255 - 19 (little-endian limb head) */
static const uint32_t curve25519_p[4] = {
    0xffffffed, 0xffffffff, 0xffffffff, 0x7fffffff};

void curve25519_scalarmult(uint8_t out[32], const uint8_t scalar[32],
                           const uint8_t point[32]) {
  out[0] = scalar[0] & curve25519_clamp[0];
  out[1] = point[0] ^ curve25519_basepoint[0];
  (void)curve25519_p;
}
