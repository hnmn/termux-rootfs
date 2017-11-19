#!/data/data/com.termux/files/usr/bin/bash
##
##  Check if unix socket can be created
##

TMPDIR="/data/data/com.termux/files/usr/tmp"
SOCKET_PATH="${TMPDIR}/unix-socket"

test_exit()
{
    rm -rf "${SOCKET_PATH}"
}
trap test_exit SIGHUP SIGINT SIGQUIT SIGTERM EXIT

echo -n "[*] Creating Unix socket: "

( echo "hello" | socat - UNIX-LISTEN:"${SOCKET_PATH}" ) &
while [ ! -e "${SOCKET_PATH}" ]; do
    true
done

if [ -S "${SOCKET_PATH}" ]; then
    echo "OK"

    echo -n "[*] Checking if socket is usable... "
    if [[ $(socat UNIX-CONNECT:"${SOCKET_PATH}" -) = "hello" ]]; then
        echo "OK"
        echo "[*] Test passed."
        exit 0
    else
        echo "FAIL"
        echo "[*] Test failed."
        exit 1
    fi
else
    echo "FAIL"
    echo "[!] Test failed."
    exit 1
fi
