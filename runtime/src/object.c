/*

Copyright 2010 John Morrice

This source file is part of The Obelisk Programming Language and is distributed under the terms of the GNU General Public License

This file is part of The Obelisk Programming Language.

    The Obelisk Programming Language is free software: you can 
    redistribute it and/or modify it under the terms of the GNU 
    General Public License as published by the Free Software Foundation, 
    either version 3 of the License, or any later version.

    The Obelisk Programming Language is distributed in the hope that it 
    will be useful, but WITHOUT ANY WARRANTY; without even the implied 
    warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  
    See the GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with The Obelisk Programming Language.  
    If not, see <http://www.gnu.org/licenses/>

*/

#include "object.h"
#include "oberror.h"

#include <string.h> 

/* Macro for bounds checking if debugging is enabled.
   Zone is of type 'chunk *', I is of type size_t. */
#ifdef DEBUG
   
   #define BOUNDS_CHECK(ZONE, I) \
      /* Check if chunk is out of bounds */ \
      if (I >= *(ZONE).size) \
      { \
         FATAL_ERROR("Read on chunk out of range."); \
      }

#else
   
   #define BOUNDS_CHECK(ZONE, I)

#endif



/* The size in memory the a chunk would occupy */
size_t chunk_size(size_t size)
{
   return sizeof(achunk) + size;
}

/* Return a pointer to the ith position of a memory zone */
word * zone_pointer(chunk * zone, size_t i)
{
   return (word *) ((size_t) zone + sizeof(achunk) + i);
}

/* Get a pointer to the ith position of the chunk */
word * obpointer(size_t i, chunk_addr zonepp)
{
   /* The chunk we're referencing */
   chunk * zone;

   /* Read the chunk address */
   zone = *zonepp;

   /* Check if we're in bounds */
   BOUNDS_CHECK(zone, i)

   return zone_pointer(zone, i);
}

/* Copy n bytes from obj to the ith position of the chunk */
void obwrite(word * zone, word * obj, size_t n)
{
   memcpy((void *) zone, (void *) obj, n);
}
