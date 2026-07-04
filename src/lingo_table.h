#ifndef LINGO_TABLE_H_
#define LINGO_TABLE_H_

#include "lingo.h"

typedef struct lingo_table_bucket {
  struct lingo_table_bucket *prev, *next;
  lingo_usize hash;
  struct lingo_table_bucket *next_coll;
} lingo_table_bucket;

/* lingo_table
 *
 */
typedef struct lingo_table {
  lingo_usize len;
  lingo_table_bucket *first, *last;
  // ^ Doubly linked list
  lingo_usize cap;
  lingo_table_bucket **buckets;
} lingo_table;

#endif
