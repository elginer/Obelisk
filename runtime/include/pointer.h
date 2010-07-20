/* Prevent multiple inclusion */
#ifndef POINTER
#define POINTER

/* Safely manipulate pointers. */

#include "oberror.h"

/* Safely resize a pointer on C's heap.  Trigger fatal error on failure. */
#define resize_pointer(SIZE, PTR)\
\
   /* Try to reSIZE the pointer */ \
   PTR = realloc(PTR, SIZE);  \
\
   if (PTR == NULL) \
   { \
      FATAL_ERROR("Ran out of memory!"); \
   }

/* Safely create a new pointer on C's heap.  Trigger fatal error on failure */
#define new_pointer(SIZE, PTR)\
\
   /* Our new pointer */ \
\
   /* Try to create a new pointer */ \
   PTR = malloc(SIZE); \
\
   /* If the pointer is NULL, raise an error and abort execution! */ \
   if (PTR == NULL) \
   { \
      FATAL_ERROR("Ran out of memory!"); \
   }

#endif
