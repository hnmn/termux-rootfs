GENCCODE_ASSEMBLY_TYPE=-a gcc
SO=so
SOBJ=so
A=a
LIBPREFIX=lib
LIB_EXT_ORDER=.60.1
COMPILE=aarch64-linux-android-clang -I/data/data/com.termux/files/usr/include -D_REENTRANT  -DU_HAVE_ELF_H=1 -DU_HAVE_ATOMIC=1 -DU_HAVE_STRTOD_L=0  -DU_ATTRIBUTE_DEPRECATED= -Oz -std=c99 -Wall -pedantic -Wshadow -Wpointer-arith -Wmissing-prototypes -Wwrite-strings   -c
LIBFLAGS=-I/data/data/com.termux/files/usr/include -DPIC -fPIC
GENLIB=aarch64-linux-android-clang -Oz -std=c99 -Wall -pedantic -Wshadow -Wpointer-arith -Wmissing-prototypes -Wwrite-strings   -L/data/data/com.termux/files/usr/lib  -shared -Wl,-Bsymbolic
LDICUDTFLAGS=-nodefaultlibs -nostdlib
LD_SONAME=-Wl,-soname -Wl,
RPATH_FLAGS=
BIR_LDFLAGS=-Wl,-Bsymbolic
AR=aarch64-linux-android-ar
ARFLAGS=r
RANLIB=aarch64-linux-android-ranlib
INSTALL_CMD=/usr/bin/install -c
