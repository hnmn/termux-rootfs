#ifndef R2_CONFIGURE_H
#define R2_CONFIGURE_H

#include "r_version.h"

#define DEBUGGER 1

#if __WINDOWS__ || __CYGWIN__ || MINGW32
#define R2_PREFIX "."
#define R2_LIBDIR "./lib"
#define R2_INCDIR "./include/libr"
#define R2_DATDIR "./share"
#else
#define R2_PREFIX "/data/data/com.termux/files/usr"
#define R2_LIBDIR "/data/data/com.termux/files/usr/lib"
#define R2_INCDIR "/data/data/com.termux/files/usr/include/libr"
#define R2_DATDIR "/data/data/com.termux/files/usr/share"
#endif

#define HAVE_LIB_MAGIC 0
#define USE_LIB_MAGIC 0
#ifndef HAVE_LIB_SSL
#define HAVE_LIB_SSL 0
#endif

#define HAVE_FORK 1

#define WITH_GPL 1

#define R2_WWWROOT R2_DATDIR "/radare2/" R2_VERSION "/www"

#if __APPLE__ && __POWERPC__
#define HAVE_JEMALLOC 0
#else
#define HAVE_JEMALLOC 1
#endif

#endif
