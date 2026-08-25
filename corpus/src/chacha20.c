#include <stdint.h>
#include <string.h>

/* "expand 32-byte k" — exported so -O2 objects retain rodata for byte-scan. */
const uint32_t chacha20_sigma[4] = {0x61707865, 0x3320646e, 0x79622d32, 0x6b206574};

static uint32_t rotl(uint32_t x, int n) { return (x << n) | (x >> (32 - n)); }

static void quarter_round(uint32_t *a, uint32_t *b, uint32_t *c, uint32_t *d) {
  *a += *b;
  *d ^= *a;
  *d = rotl(*d, 16);
  *c += *d;
  *b ^= *c;
  *b = rotl(*b, 12);
  *a += *b;
  *d ^= *a;
  *d = rotl(*d, 8);
  *c += *d;
  *b ^= *c;
  *b = rotl(*b, 12);
}

void chacha20_block(uint32_t out[16], const uint32_t key[8], uint32_t counter,
                    const uint32_t nonce[3]) {
  uint32_t x[16];
  memcpy(x, chacha20_sigma, 16);
  for (int i = 0; i < 8; i++)
    x[4 + i] = key[i];
  x[12] = counter;
  x[13] = nonce[0];
  x[14] = nonce[1];
  x[15] = nonce[2];
  uint32_t y[16];
  for (int i = 0; i < 16; i++)
    y[i] = x[i];
  for (int r = 0; r < 10; r++) {
    quarter_round(&x[0], &x[4], &x[8], &x[12]);
    quarter_round(&x[1], &x[5], &x[9], &x[13]);
    quarter_round(&x[2], &x[6], &x[10], &x[14]);
    quarter_round(&x[3], &x[7], &x[11], &x[15]);
    quarter_round(&x[0], &x[5], &x[10], &x[15]);
    quarter_round(&x[1], &x[6], &x[11], &x[12]);
    quarter_round(&x[2], &x[7], &x[8], &x[13]);
    quarter_round(&x[3], &x[4], &x[9], &x[14]);
  }
  for (int i = 0; i < 16; i++)
    out[i] = x[i] + y[i];
}
