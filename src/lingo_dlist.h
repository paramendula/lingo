#ifndef LINGO_DLIST_H_
#define LINGO_DLIST_H_

#include "lingo.h"

typedef struct lingo_dlist_node {
  struct lingo_dlist_node *prev, *next;
} lingo_dlist_node;

typedef struct lingo_dlist {
  lingo_usize len;
  lingo_dlist_node *first, *last;
} lingo_dlist;

int lingo_dlist_append(lingo_dlist *dl, lingo_dlist_node *n);
int lingo_dlist_prepend(lingo_dlist *dl, lingo_dlist_node *n);
int lingo_dlist_remove(lingo_dlist *dl, lingo_dlist_node *n);

#endif
