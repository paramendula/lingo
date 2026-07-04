#ifndef LINGO_H_
#define LINGO_H_

#include <stdint.h>

typedef uint8_t lingo_u8;
typedef uint16_t lingo_u16;
typedef uint32_t lingo_u32;
typedef uint64_t lingo_u64;
typedef uintmax_t lingo_usize;

typedef int8_t lingo_i8;
typedef int16_t lingo_i16;
typedef int32_t lingo_i32;
typedef int64_t lingo_i64;
typedef intmax_t lingo_isize;

typedef uintmax_t lingo_cell;

typedef float lingo_f32;
typedef double lingo_f64;

typedef lingo_u8 lingo_bool;

#define LINGO_TRUE ((lingo_bool)0xFF)
#define LINGO_FALSE ((lingo_bool)0)
#define LINGO_NULL 0

typedef struct lingo {
  int pass;
} lingo;

#endif
