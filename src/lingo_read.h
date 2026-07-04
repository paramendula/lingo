#ifndef LINGO_READ_H_
#define LINGO_READ_H_

#include "lingo.h"
#include "lingo_mem.h"
#include "lingo_str.h"

/* lingo_read - lingo reader state & options
 *
 */
typedef struct lingo_read {
  lingo_vt_allocator *mem;
} lingo_read;

typedef enum lingo_read_out_type {
  LingoReadStringConst = 0,
  LingoReadStringTemp,
  LingoReadStringBuf,
  LingoReadError,
} lingo_read_out_type;

typedef struct lingo_read_out {
  lingo_read_out_type t;
  union {
    int err_code;
    const char *data;
  };
} lingo_read_out;

int lingo_read_init(lingo_read *p);
int lingo_read_deinit(lingo_read *p);

/* Empty the string queue,
 * clean all the counters, essentialy
 * reseting 'p' to the state it were in
 * after calling lingo_read_init with 'p'.
 */
int lingo_read_reset(lingo_read *p);

int lingo_read_append_const(lingo_read *p, lingo_str_const *sc);
int lingo_read_append_buf(lingo_read *p, lingo_str_buf *sb);

/* It's up to this function's caller to ensure that
 * cs_len is valid and the c-string 'cs' is valid until
 * either lingo_read_deinit or lingo_read_reset are called,
 * or any lingo_read_* function aren't called with 'p'.
 */
int lingo_read_append_cstr(lingo_read *p, const char *cs, lingo_usize cs_len);

int lingo_read_next(lingo_read *p, lingo_read_out *out);

/* TODO: lingo_read precise control
 * seek, tell, peek and so on
 */

#endif
