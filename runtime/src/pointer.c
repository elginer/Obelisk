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

