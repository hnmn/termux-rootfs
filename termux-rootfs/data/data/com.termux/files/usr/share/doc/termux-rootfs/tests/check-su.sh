#!/data/data/com.termux/files/usr/bin/bash
##
##  Test if Superuser client is working
##

echo -n "[*] Testing superuser access: "

## output may be '0\r' so it needs to be
## converted into '0'
USER_ID=$(sudo id -u | tr -d '\r')

if [ "${USER_ID}" = "0" ]; then
    echo "PASSED"
else
    SU_BINARY="none"

    if [ -e "/su/bin/su" ]; then
        SU_BINARY="/su/bin/su"
    elif [ -e "/system/bin/su" ]; then
        SU_BINARY="/system/bin/su"
    elif [ -e "/system/xbin/su" ]; then
        SU_BINARY="/system/xbin/su"
    fi

    if [ -x "${SU_BINARY}" ]; then
        echo "FAILED"
    else
        echo "FAILED"
        echo "[*] Possible that your device is not rooted."
    fi

    exit 1
fi
