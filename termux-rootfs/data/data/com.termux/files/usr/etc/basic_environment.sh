###############################################################
##
##  Basic environment for Termux
##
##  Should be sourced by any shell's profile.
##
###############################################################

##
## Set the strict file mode creation mask so
## only user with Termux UID can access them.
##
umask 077

##
## Choose home directory
##
## If shell is running under proot as regular user, then
## PROOTED_SHELL will be set so we will not change the
## home directory if root user is emulated (for example with
## fakeroot).
##
if [ "$(id -u)" = "0" ] && [ -z "${PROOTED_SHELL}" ]; then
    export HOME="/data/data/com.termux/files/root"
else
    export HOME="/data/data/com.termux/files/home"
fi

##
## Private prefixed environment
##
## You can compile and install your own software using this
## prefix so it will not mess up your termux-rootfs.
##
export HOME_PREFIX="${HOME}/.local"

##
## Basic environment variables
##
## Do not touch if you are not know what you are
## doing.
##
export EDITOR="${PREFIX}/bin/nano"
export GOPATH="${HOME}/.go"
export LD_LIBRARY_PATH="${PREFIX}/lib"
export MAIL="${PREFIX}/var/mail/${USER}"
export PATH="${HOME}/.bin:${HOME_PREFIX}/bin:${HOME_PREFIX}/sbin:${PREFIX}/bin"
export TERMINFO="${PREFIX}/share/terminfo"
export TERMUX_APPDIR="/data/data/com.termux"
export TERMUX_UID=$(stat -c '%u' "${TERMUX_APPDIR}")
export USER=$(id -nu)

##
## Set path to directory where temporary files will be stored
##
## In Linux distributions this is usually '/tmp', but on Android
## we should use cache directory, so it can be cleaned by pressing
## 'Clean cache' in Application Manager under Android settings.
##
export TMPDIR="${TERMUX_APPDIR}/cache"

# check cache directory and create it if not exist
if [ ! -e "${TMPDIR}" ]; then
    mkdir -m 700 "${TMPDIR}" > /dev/null 2>&1
else
    if [ ! -d "${TMPDIR}" ]; then
        rm -rf "${TMPDIR}" > /dev/null 2>&1
        mkdir -m 700 "${TMPDIR}" > /dev/null 2>&1
    fi
fi

# double check if it exist, if not, then create tmp directory
# in $PREFIX, otherwise make a symlink from cache dir to $PREFIX/tmp
if [ -e "${TMPDIR}" ]; then
    if [ -d "${PREFIX}/tmp" ]; then
        rm -rf "${PREFIX}/tmp" > /dev/null 2>&1
    fi

    if [ ! -e "${PREFIX}/tmp" ]; then
        ln -sr "${TMPDIR}" "${PREFIX}/tmp" > /dev/null 2>&1
    fi
else
    if [ -L "${PREFIX}/tmp" ]; then
        rm -f "${PREFIX}/tmp" > /dev/null 2>&1
        mkdir -m 700 "${PREFIX}/tmp" > /dev/null 2>&1
    fi
    export TMPDIR="${PREFIX}/tmp"
fi

# set temporary directory for proot to TMPDIR to avoid
# errors like 'trying to remove a directory outside of ...'
export PROOT_TMP_DIR="${TMPDIR}"

##
## This variable points to the executable of your
## current shell.
##
## Variable 'SHELL' should be set in profile and
## in *rc file (bash.bashrc or etc).
##
export SHELL=$(readlink "/proc/$$/exe")

##
## Setup private bin directory for user, so it
## can store custom software.
##
if [ ! -e "${HOME}/.local/bin" ]; then
    mkdir -p "${HOME}/.local/bin" > /dev/null 2>&1
fi

##
## Android-related variables
##
## Do not touch if you are not know what you are
## doing.
##
export ANDROID_DATA="${PREFIX}/var/lib/android"
export ANDROID_ROOT="/system"

# BOOTCLASSPATH is not same on different devices,
# so it should be generated
BOOTCLASSPATH=$(find /system/framework -type f -iname \*.jar 2>/dev/null | sort)
if [ ! -z "${BOOTCLASSPATH}" ]; then
    BOOTCLASSPATH=$(echo "${BOOTCLASSPATH}" | tr '\n' ':')
    BOOTCLASSPATH=${BOOTCLASSPATH:0:-1}
else
    unset BOOTCLASSPATH
fi
[ ! -z "${BOOTCLASSPATH}" ] && export BOOTCLASSPATH

##
## If shell is running under termux-chroot then the
## external storage will be /mnt/emulated/0
##
if [ -e "/.termux-chroot" ]; then
    export EXTERNAL_STORAGE="/mnt/storage/emulated/0"
fi

##
## This is needed for LVM programs to prevent warnings
## about leaked descriptors.
##
LVM_SUPPRESS_FD_WARNINGS="true"
