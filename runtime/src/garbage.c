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

#include "garbage.h"
#include "memory.h"
#include "object.h"
#include "pointer.h"
#include "string.h"

#ifdef REPORT_GARBAGE_COLLECTION
   #include <stdio.h>
#endif

/* A copying collector */

/* Collect garbage. */
void collect_garbage(stack_pointer top, stack_pointer bottom, memory_manager mem)
{
   /* A chunk */
   chunk * chnk;

   /* The size of the new heap */
   size_t heap_size;

   /* A memory area, used for swapping from inactive to active */
   memory_area temp_zone;

   /* Report garbage collection */
   #ifdef REPORT_GARBAGE_COLLECTION
      fprintf(stderr, "Garbage is being collected.  Current heap size: %u\n", mem->size);
   #endif

   temp_zone = mem->current;
   mem->current = mem->inactive;
   mem->inactive = temp_zone;

   /* Copy the stack into the new heap.
      Set the next memory location to be at the end of the stack. */
   mem->next = copy_stack(top, bottom, mem->current);

}
