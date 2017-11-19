#!/data/data/com.termux/files/usr/bin/bash
##
##  Check if FIFO can be created
##

TMPDIR="/data/data/com.termux/files/usr/tmp"
FIFO_PATH="${TMPDIR}/test-fifo"

test_exit()
{
    rm -rf "${FIFO_PATH}"
}
trap test_exit SIGHUP SIGINT SIGQUIT SIGTERM EXIT

echo -n "[*] Creating FIFO: "
if mkfifo "${FIFO_PATH}" > /dev/null 2>&1; then
    if [ -p "${FIFO_PATH}" ]; then
        echo "OK"
    else
        echo "FAIL"
        echo "[!] Test failed."
        exit 1
    fi

    echo -n "[*] Checking if FIFO is usable... "
    echo "hello" > "${FIFO_PATH}" &
    if [[ $(cat "${FIFO_PATH}") = "hello" ]]; then
        echo "OK"
        echo "[*] Test passed."
    else
        echo "FAIL"
        echo "[!] Test failed."
        exit 1
    fi
else
    echo "FAIL"
    echo "[!] Test failed."
    exit 1
fi
