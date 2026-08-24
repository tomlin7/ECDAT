#include <stdint.h>
#include <string.h>

static const uint32_t K[4] = {0x5a827999, 0x6ed9eba1, 0x8f1bbcdc, 0xca62c1d6};

static uint32_t rotl(uint32_t x, int n) { return (x << n) | (x >> (32 - n)); }

void sha1_compress(uint32_t state[5], const uint8_t block[64]) {
  uint32_t w[80];
  for (int i = 0; i < 16; i++) {
    w[i] = ((uint32_t)block[i * 4] << 24) | ((uint32_t)block[i * 4 + 1] << 16) |
           ((uint32_t)block[i * 4 + 2] << 8) | (uint32_t)block[i * 4 + 3];
  }
  for (int i = 16; i < 80; i++)
    w[i] = rotl(w[i - 3] ^ w[i - 8] ^ w[i - 14] ^ w[i - 16], 1);
  uint32_t a = state[0], b = state[1], c = state[2], d = state[3], e = state[4];
  for (int i = 0; i < 80; i++) {
    uint32_t f, k;
    if (i < 20) {
      f = (b & c) | ((~b) & d);
      k = K[0];
    } else if (i < 40) {
      f = b ^ c ^ d;
      k = K[1];
    } else if (i < 60) {
      f = (b & c) | (b & d) | (c & d);
      k = K[2];
    } else {
      f = b ^ c ^ d;
      k = K[3];
    }
    uint32_t temp = rotl(a, 5) + f + e + k + w[i];
    e = d;
    d = c;
    c = rotl(b, 30);
    b = a;
    a = temp;
  }
  state[0] += a;
  state[1] += b;
  state[2] += c;
  state[3] += d;
  state[4] += e;
}
