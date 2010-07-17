/* Prevent multiple inclusion */
#ifndef EXECUTOR
#define EXECUTOR

/* Function execution */

#include "object.h"

/* When an obelisk function returns a value, keep executing until it's finished with tail-calls. */
chunk_addr execute(return_val * continuation);

/* Perform a tail-call, to be picked up by execute later */
void tail_call(return_val * continuation, function_pointer * fp, va_list args);

#endif
