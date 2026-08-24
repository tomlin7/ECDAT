/*
 * Common TLS 1.2/1.3 cipher suite identifiers (IANA).
 * Typical of OpenSSL/BoringSSL default cipher lists in firmware images.
 */
#include <stdint.h>

static const uint16_t tls_cipher_suites[] = {
    0x1301, /* TLS_AES_128_GCM_SHA256 */
    0x1302, /* TLS_AES_256_GCM_SHA384 */
    0x1303, /* TLS_CHACHA20_POLY1305_SHA256 */
    0xc02f, /* TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 */
    0xc030, /* TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 */
    0xcca8, /* TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256 */
    0x009c, /* TLS_RSA_WITH_AES_128_GCM_SHA256 */
    0x009d, /* TLS_RSA_WITH_AES_256_GCM_SHA384 */
};

static const uint8_t tls_record_version[] = {0x03, 0x03}; /* TLS 1.2 */

const uint16_t *tls_default_ciphers(int *n) {
  *n = (int)(sizeof tls_cipher_suites / sizeof tls_cipher_suites[0]);
  return tls_cipher_suites;
}

const uint8_t *tls_record_proto(void) { return tls_record_version; }
