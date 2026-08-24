#include <stdint.h>

/* Schoolbook 64-bit modular exponentiation — RSA-shaped arithmetic. */
uint64_t rsa_modexp(uint64_t base, uint64_t exp, uint64_t mod) {
  uint64_t result = 1;
  base %= mod;
  while (exp > 0) {
    if (exp & 1ull)
      result = (result * base) % mod;
    exp >>= 1;
    base = (base * base) % mod;
  }
  return result;
}
