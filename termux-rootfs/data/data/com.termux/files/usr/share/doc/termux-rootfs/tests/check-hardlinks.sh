#!/data/data/com.termux/files/usr/bin/bash
##
##  Test working with hardlinks
##

CUR_DIR="${PWD}"
TMPDIR="/data/data/com.termux/files/usr/tmp"
WORK_DIR=$(mktemp -d "${TMPDIR}/XXXXXXXXXX")

test_exit()
{
    cd "${CUR_DIR}"
    rm -rf "${WORK_DIR}"
}
trap test_exit SIGHUP SIGINT SIGQUIT SIGTERM EXIT

(
    cd "${WORK_DIR}" && {
        echo -n "[*] Creating test file... "
        if touch "testfile.txt" > /dev/null 2>&1; then
            echo "OK"
        else
            echo "FAIL"
            exit 1
        fi

        echo -n "[*] Checking if can create hardlinks... "
        if ! ln "testfile.txt" "testfile_hlink.txt" >/dev/null 2>&1; then
            echo "FAIL"
            echo "[!] TEST FAILED."
            exit 1
        fi
        if [ -f "testfile_hlink.txt" ]; then
            echo "OK"
        else
            echo "FAIL"
            echo "[!] TEST FAILED."
            exit 1
        fi
        if [[ $(ls -l "testfile_hlink.txt" | awk '{ print $2 }') -ne 2 ]]; then
            echo "FAIL"
            echo "[!] TEST FAILED."
            exit 1
        fi

        echo -n "[*] Checking if hardlinks are usable... "
        if ! echo "data" > "testfile_hlink.txt" 2>/dev/null; then
            echo "FAIL"
            echo "[!] TEST FAILED."
            exit 1
        fi
        if [[ $(cat "testfile.txt") = $(cat "testfile_hlink.txt") ]]; then
            echo "OK"
            echo "[*] TEST PASSED."
        else
            echo "FAIL"
            echo "[!] TEST FAILED."
        fi
        exit 0
    } || {
        echo "[!] Failed to cd into '${WORK_DIR}'."
        exit 1
    }
)
