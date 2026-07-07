#ifndef LINGO_LIST_H_
#define LINGO_LIST_H_

#include "lingo.h"

typedef struct lingo_list_node {
    struct lingo_list_node *next;
} lingo_list_node;

typedef struct lingo_list {
    lingo_usize len;
    lingo_list_node *first, *last;
} lingo_list;

#endif
