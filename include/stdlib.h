#include_next <stdlib.h>

#ifndef CWM_COMPAT_STDLIB_H
#define CWM_COMPAT_STDLIB_H

#if defined(__linux__)
long long	strtonum(const char *, long long, long long, const char **);
#endif

#endif
