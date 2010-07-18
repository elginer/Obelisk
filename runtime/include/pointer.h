/* Prevent multiple inclusion */
#ifndef POINTER
#define POINTER

/* Safely manipulate pointers. */

/* Safely resize a pointer on C's heap.  Trigger fatal error on failure. */
void * resize_pointer(size_t size, void * old);

/* Safely create a new pointer on C's heap.  Trigger fatal error on failure */
void * new_pointer(size_t size);

#endif
