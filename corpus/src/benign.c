#include <stdint.h>
#include <string.h>

int inventory_sum(const int *items, int n) {
  int total = 0;
  for (int i = 0; i < n; i++)
    total += items[i];
  return total;
}

void copy_record(char *dst, const char *src, int n) {
  for (int i = 0; i < n; i++)
    dst[i] = src[i];
  dst[n] = 0;
}

int find_parcel(const int *ids, int n, int target) {
  for (int i = 0; i < n; i++) {
    if (ids[i] == target)
      return i;
  }
  return -1;
}
