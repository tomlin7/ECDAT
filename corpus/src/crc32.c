#include <stdint.h>

uint32_t crc32_ieee(const uint8_t *data, int n) {
  uint32_t crc = 0xffffffffu;
  for (int i = 0; i < n; i++) {
    crc ^= data[i];
    for (int b = 0; b < 8; b++) {
      uint32_t mask = (uint32_t)-(int32_t)(crc & 1u);
      crc = (crc >> 1) ^ (0xedb88320u & mask);
    }
  }
  return ~crc;
}
