#include_next <string.h>

#ifndef CWM_COMPAT_STRING_H
#define CWM_COMPAT_STRING_H

#if defined(__linux__)
size_t	strlcat(char *, const char *, size_t);
size_t	strlcpy(char *, const char *, size_t);
#endif

#endif
