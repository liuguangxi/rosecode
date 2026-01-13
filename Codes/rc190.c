/*
OEIS:A075831
*/


#include <stdio.h>
#include <stdint.h>
#include <string.h>

#ifdef _OPENMP
#include <omp.h>
#endif

// ZIP local header (30 bytes) + filename (1 byte) + encrypted payload (24 bytes)
static const uint8_t BLOB[] = {
  0x50,0x4b,0x03,0x04,0x0a,0x00,0x01,0x00,0x00,0x00,0xae,0x60,0x6b,0x45,0x68,0x81,
  0x7f,0x1e,0x18,0x00,0x00,0x00,0x0c,0x00,0x00,0x00,0x01,0x00,0x00,0x00,0x01,
  0x3e,0x24,0x52,0xbf,0xa8,0x02,0x52,0xf9,0x7a,0x98,0x64,0x65,0xda,0xe2,0x4e,0x27,
  0xa7,0xf4,0x22,0x2c,0x77,0x6b,0x7b,0xfd
};

/* PKZIP "traditional" (ZipCrypto) */

static uint32_t CRC_TAB[256];

static void init_crc_tab(void) {
  const uint32_t poly = 0xEDB88320u;
  for (uint32_t i = 0; i < 256; i++) {
    uint32_t c = i;
    for (int k = 0; k < 8; k++)
      c = (c & 1u) ? (poly ^ (c >> 1)) : (c >> 1);
    CRC_TAB[i] = c;
  }
}

static inline uint32_t crc32_u8(uint32_t crc, uint8_t b) {
  return CRC_TAB[(crc ^ b) & 0xffu] ^ (crc >> 8);
}

typedef struct { uint32_t k0, k1, k2; } zipkeys_t;

static inline void keys_init(zipkeys_t *k) {
  k->k0 = 0x12345678u;
  k->k1 = 0x23456789u;
  k->k2 = 0x34567890u;
}

static inline void keys_update(zipkeys_t *k, uint8_t plain) {
  k->k0 = crc32_u8(k->k0, plain);
  k->k1 = (k->k1 + (k->k0 & 0xffu)) & 0xffffffffu;
  k->k1 = (k->k1 * 134775813u + 1u) & 0xffffffffu;
  k->k2 = crc32_u8(k->k2, (uint8_t)(k->k1 >> 24));
}

static inline uint8_t decrypt_byte(const zipkeys_t *k) {
  uint32_t t = (k->k2 | 2u) & 0xffffffffu;
  return (uint8_t)(((t * (t ^ 1u)) >> 8) & 0xffu);
}

static inline void init_from_password(zipkeys_t *k, const char *pw) {
  keys_init(k);
  for (const unsigned char *p = (const unsigned char *)pw; *p; ++p)
    keys_update(k, *p);
}

static inline void decrypt_inplace(zipkeys_t *k, const uint8_t *in, uint8_t *out, size_t n) {
  for (size_t i = 0; i < n; i++) {
    uint8_t p = in[i] ^ decrypt_byte(k);
    keys_update(k, p);
    out[i] = p;
  }
}

/* Brute force per the hints:
   tokens = [sinan(case-var), ddd, c1, c2, c3, c4]
   where c1..c4 are 4 distinct chars from set {'(', ')', ':', ';', '_', '.', ','}
   tokens concatenated in any order => 6! permutations
*/

int main(void) {
  init_crc_tab();

  // CRC32 is at offset 14 in the local header (little endian)
  uint32_t crc =
      (uint32_t)BLOB[14] |
      ((uint32_t)BLOB[15] << 8) |
      ((uint32_t)BLOB[16] << 16) |
      ((uint32_t)BLOB[17] << 24);

  const uint8_t *enc = BLOB + 31;       // 30-byte header + 1-byte filename
  const uint8_t *enc_hdr = enc;         // 12-byte encryption header
  const uint8_t *enc_data = enc + 12;   // 12-byte stored file data (encrypted)

  const uint8_t check = (uint8_t)(crc >> 24); // expected 12th decrypted header byte

  // Precompute 6! permutations (Heap's algorithm)
  int perms[720][6];
  int perm_count = 0;
  int a[6] = {0,1,2,3,4,5};
  int c[6] = {0,0,0,0,0,0};
  memcpy(perms[perm_count++], a, sizeof(a));
  int i = 0;
  while (i < 6) {
    if (c[i] < i) {
      if (i % 2 == 0) { int tmp = a[0]; a[0] = a[i]; a[i] = tmp; }
      else { int tmp = a[c[i]]; a[c[i]] = a[i]; a[i] = tmp; }
      memcpy(perms[perm_count++], a, sizeof(a));
      c[i]++;
      i = 0;
    } else {
      c[i] = 0;
      i++;
    }
  }

  // Case variants for "sinan" (2^5 = 32)
  char sinans[32][6];
  for (int m = 0; m < 32; m++) {
    const char base[6] = "sinan";
    for (int j = 0; j < 5; j++) {
      char ch = base[j];
      if (m & (1 << j)) ch = (char)(ch - 'a' + 'A');
      sinans[m][j] = ch;
    }
    sinans[m][5] = '\0';
  }

  // Numbers 000-999
  char nums[1000][4];
  for (int n = 0; n < 1000; n++)
    snprintf(nums[n], sizeof(nums[n]), "%03d", n);

  const char punct_set[7] = {'(', ')', ':', ';', '_', '.', ','};

  volatile int found = 0;
  char found_pw[32] = {0};
  uint8_t found_pt[12] = {0};

  // 35 combinations of 4 distinct punctuation chars from 7 (7 choose 4)
  // Parallelize over (sinan_variant, number, comb) space: 32 * 1000 * 35 tasks.
  #pragma omp parallel for schedule(dynamic,1)
  for (int task = 0; task < 32 * 1000 * 35; task++) {
    if (found) continue;

    int t = task;
    int sv = t % 32; t /= 32;
    int num = t % 1000; t /= 1000;
    int comb = t; // 0..34

    // Map comb index -> (i1<i2<i3<i4)
    int idx = 0;
    char p4[4] = {0,0,0,0};
    for (int i1 = 0; i1 < 7; i1++) {
      for (int i2 = i1 + 1; i2 < 7; i2++) {
        for (int i3 = i2 + 1; i3 < 7; i3++) {
          for (int i4 = i3 + 1; i4 < 7; i4++) {
            if (idx == comb) {
              p4[0] = punct_set[i1];
              p4[1] = punct_set[i2];
              p4[2] = punct_set[i3];
              p4[3] = punct_set[i4];
              goto got_comb;
            }
            idx++;
          }
        }
      }
    }
  got_comb:;

    const char *tok0 = sinans[sv];
    const char *tok1 = nums[num];
    char tok2[2] = {p4[0], 0};
    char tok3[2] = {p4[1], 0};
    char tok4[2] = {p4[2], 0};
    char tok5[2] = {p4[3], 0};
    const char *toks[6] = {tok0, tok1, tok2, tok3, tok4, tok5};

    char pw[32];
    uint8_t dh[12];
    uint8_t pt[12];

    for (int pi = 0; pi < 720 && !found; pi++) {
      // Build password according to permutation
      char *w = pw;
      for (int k = 0; k < 6; k++) {
        const char *s = toks[perms[pi][k]];
        while (*s) *w++ = *s++;
      }
      *w = '\0';

      zipkeys_t keys;
      init_from_password(&keys, pw);

      // Decrypt 12-byte encryption header and check last byte
      decrypt_inplace(&keys, enc_hdr, dh, 12);
      if (dh[11] != check) continue;

      // Decrypt stored file data (12 bytes) and verify CRC32
      decrypt_inplace(&keys, enc_data, pt, 12);

      uint32_t ccrc = 0xffffffffu;
      for (int k = 0; k < 12; k++) ccrc = crc32_u8(ccrc, pt[k]);
      ccrc ^= 0xffffffffu;
      if (ccrc != crc) continue;

      #pragma omp critical
      {
        if (!found) {
          found = 1;
          strncpy(found_pw, pw, sizeof(found_pw) - 1);
          memcpy(found_pt, pt, 12);
        }
      }
      break;
    }
  }

  // Print decrypted data (answer format)
  if (!found) return 1;
  for (int i = 0; i < 12; i++) putchar(found_pt[i]);
  putchar('\n');

  return 0;
}
