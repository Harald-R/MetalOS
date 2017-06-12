#include "mem.h"

// Copies the character 'val' to the first 'len' characters
// of the string pointed to by the argument 'str'
void memset(void *dest, unsigned char val, unsigned int len)
{
    unsigned char *temp = (unsigned char *)dest;
    for ( ; len != 0; len--) *temp++ = val;
}
