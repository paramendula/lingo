#ifndef LINGO_H_
#define LINGO_H_

#include <stdint.h>

typedef uint8_t u8;
typedef uint16_t u16;
typedef uint32_t u32;
typedef uint64_t u64;
typedef uintmax_t usize;

typedef int8_t i8;
typedef int16_t i16;
typedef int32_t i32;
typedef int64_t i64;
typedef intmax_t isize;

typedef uintmax_t cell;

typedef float f32;
typedef double f64;

typedef u8 lbool;

#define LINGO_TRUE ((lbool)0xFF)
#define LINGO_FALSE ((lbool)0)
#define LINGO_NULL 0

typedef struct lingo {
  int pass;
} lingo;

#endif
