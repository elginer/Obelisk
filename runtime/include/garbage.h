/* Prevent multiple inclusion */
#ifndef GARBAGE
#define GARBAGE

#include "memory.h"
#include "object.h"

/* Copying garbage collector. */

/* Collect garbage. */
void collect(struct memory * m);

struct location_finder
{
   /* The start address of the space
      for the objects which are to act as keys. */
   struct chunk * from_start;

   /* The start address of the space 
      for the objects which are to act as values. */
   struct chunk * to_start;
};

/* Return a new location finder of the given size */
struct location_finder * new_location_finder(struct chunk * from, struct chunk * to);

#endif
