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

#include <error.h>
#include <string.h> 

/* The size in memory the a chunk would occupy */
size_t chunk_size(size_t size)
{
   return sizeof(chunk) + size;
}

/* The size in memory the a chunk does occupy */
size_t chsize(chunk * chnk)
{
   return sizeof(achunk) + chnk->size;
}

/* Return a pointer to the ith position of a memory zone */
word * zone_pointer(chunk_addr zone, size_t i)
{
   return ((word *) zone + sizeof(achunk) + i);
}

/* Get a pointer to the ith position of the chunk */
word * obpointer(size_t i, chunk_addr zone)
{
   /* Check if we're in bounds */
   if (i >= zone->size)
   {
      error(0, 0, "Tried to read at %u on chunk of size %u\n", i, zone->size);
      FATAL_ERROR("Read on chunk out of range.");
   }

   return zone_pointer(zone, i);
}

/* Copy n bytes from obj to the ith position of the chunk */
void obwrite(word * zone, word * obj, size_t n)
{
   memcpy((void *) zone, (void *) obj, n);
}
