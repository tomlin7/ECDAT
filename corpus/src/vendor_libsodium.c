/* libsodium-style SHA-512 constants + chacha sigma (vendor slice for holdout). */
#include <stdint.h>
#include <string.h>

static const uint64_t sha512_k[8] = {
    0x428a2f98d728ae22ULL, 0x7137449123ef65cdULL, 0xb5c0fbcfec4d3b2fULL,
    0xe9b5dba58189dbbcULL, 0x3956c25bf348b538ULL, 0x59f111f1b605d019ULL,
    0x923f82a4af194f9bULL, 0xab1c5ed5da6d8118ULL};

const uint32_t vendor_chacha_sigma[4] = {0x61707865, 0x3320646e, 0x79622d32, 0x6b206574};

void vendor_libsodium_mix(uint8_t out[32]) {
  memcpy(out, &sha512_k[0], 8);
  memcpy(out + 8, vendor_chacha_sigma, 16);
}
