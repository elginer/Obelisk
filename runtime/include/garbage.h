/* Prevent multiple inclusion */
#ifndef GARBAGE
#define GARBAGE

#include "memory.h"
#include "object.h"

/* Copying garbage collector. */

/* A nicer name for the location finder */
typedef struct location_finder * location_finder;

/* Data structure to store new location of objects in O(1) time. */
struct location_finderS
{
   /* The start address of the space
      for the objects which are to act as keys. */
   struct chunk * from_start;

   /* The start address of the space 
      for the objects which are to act as values. */
   struct chunk * to_start;
};

/* Collect garbage. */
void collect_garbage(memory_manager m);

/* */

/* Return a new location finder of the given size */
location_finder new_location_finder(struct chunk * from, struct chunk * to);

#endif
