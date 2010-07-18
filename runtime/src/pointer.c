/* Safely manipulate pointers */

#include "oberror.h"
#include "pointer.h"

#include <stdlib.h>
#include <stdio.h>

/* Safely resize a pointer on C's heap.  Trigger fatal error on failure. */
void * resize_pointer(size_t size, void * old)
{
   /* Our new pointer */
   void * new;
   
   /* Try to resize the pointer */
   new = realloc(old, size);

   if (new == NULL)
   {
      FATAL_ERROR("Ran out of memory!");
   }

   return new;
}

/* Safely create a new pointer on C's heap.  Trigger fatal error on failure */
void * new_pointer(size_t size)
{
   /* Our new pointer */
   void * ptr;

   /* Try to create a new pointer */
   ptr = malloc(size);

   /* If the pointer is NULL, raise an error and abort execution! */
   if (ptr == NULL)
   {
      FATAL_ERROR("Ran out of memory!");
   }
  
   return ptr;
}

