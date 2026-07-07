#ifndef LINGO_READ_H_
#define LINGO_READ_H_

#include "lingo.h"
#include "lingo_mem.h"
#include "lingo_str.h"

// Allocate string buffers and const strings using alloc VT
#define LINGO_READ_ALLOC_STR ((lingo_u32)1)
// Allocate symbols using alloc VT
#define LINGO_READ_ALLOC_SYM ((lingo_u32)2)

/* lingo_read - lingo reader state & options
 *
 */
typedef struct lingo_read {
  // Options
  lingo_vt_allocator *mem;
  lingo_u32 flags;
  // Read-only
} lingo_read;

typedef enum lingo_read_out_type {
  LingoReadStringConst = 0,
  LingoReadStringBuf,
  // string read into a temporary buffer
  // (must be manually copied or ignored)
  LingoReadStringTemp,
  LingoReadSymbol,
  // symbol read into a temporary buffer
  // (must be manually copied or ignored)
  LingoReadSymbolTemp,
  LingoReadError,
} lingo_read_out_type;

typedef struct lingo_read_out {
  lingo_read_out_type t;
  union {
    // use lingo_read_error_cstr to get an error message
    int err_code;
    // for reads into a temporary buffer
    struct {
      const u8 *data;
      lingo_usize data_len;
    };
  };
} lingo_read_out;

int lingo_read_init(lingo_read *r);
int lingo_read_deinit(lingo_read *r);

/* Empty the string queue,
 * clean all the counters, essentialy
 * reseting 'r' to the state it were in
 * after calling lingo_read_init with 'r'.
 */
int lingo_read_reset(lingo_read *r);

int lingo_read_append_const(lingo_read *r, lingo_str_const *sc);
int lingo_read_append_buf(lingo_read *r, lingo_str_buf *sb);

/* It's up to this function's caller to ensure that
 * cs_len is valid and the c-string 'cs' is valid until
 * either lingo_read_deinit or lingo_read_reset are called,
 * or any lingo_read_* function aren't called with 'r'.
 */
int lingo_read_append_cstr(lingo_read *r, const char *cs, lingo_usize cs_len);

/* Returns 0 if succes, the result is written to *out.
 * -1 if a fatal error occured.
 * 1 if data ended mid-read, meaning append more data or
 *   incomplete/wrong data.
 *
 */
int lingo_read_next(lingo_read *r, lingo_read_out *out);

const char *lingo_read_error_cstr(int err_code);

/* TODO: lingo_read precise control
 * seek, tell, peek and so on
 * append stream
 */

#endif
