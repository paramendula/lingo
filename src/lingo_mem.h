#ifndef LINGO_MEM_H_
#define LINGO_MEM_H_

/* lingo.h - memory allocation library
 *
 */

#include "lingo.h"

/* lingo_alloc_type - Types of an allocation
 *
 */
typedef enum lingo_alloc_type {
    // Unknown
    LingoAllocGeneral = 0,
} lingo_alloc_type;

/* lingo_vt_alloc - Virtual table of an allocator.
 *
 * alloc - allocate a memory chunk of size 'bytes',
 *  the contents of the chunk are undefined. An info
 *  about the allocated chunk specialization may be
 *  provided by passing a value from the enum
 *  'lingo_alloc_type' into parameter 't' (type).
 *  This allows an allocator to optimize allocation
 *  depending on the type of data being allocated.
 *  Returns (succes): a valid pointer
 *  Returns (failure): a null (not enough memory).
 *
 * free - free a previous allocated memory chunk
 *  pointed at by 'ptr'.
 *  If 'ptr' is null, do nothing. Otherwise, if
 *  'ptr' wasn't allocated by the current allocator,
 *  or is being freed for more than once, the
 *  behaviour is undefined.
 *  Returns: nothing
 */
typedef struct lingo_vt_allocator {
    void *(*alloc)(void*, usize bytes, lingo_alloc_type t);
    void (*free)(void*, void *ptr);
} lingo_vt_allocator;

#endif
