#ifndef LINGO_STR_H
#define LINGO_STR_H

#include "lingo.h"

/* lingo_str_const - immutable string
 * Almost always used as a pointer.
 * Data chunk containing:
 * raw data length in bytes (len)
 * the raw data (bytes)
 */
typedef struct lingo_str_const {
  lingo_usize len;
  lingo_u8 bytes_start[];
} lingo_str_const;

/* lingo_str_buf - mutable string buffer
 * Contains a string buffer's length,
 * capacity (len + unused space),
 * and a pointer to the raw data.
 */
typedef struct lingo_str_buf {
  lingo_usize len, cap;
  lingo_u8 *bytes;
} lingo_str_buf;

#endif
