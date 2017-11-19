#!/data/data/com.termux/files/usr/bin/bash
##
##  Test working with symlinks
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

        echo -n "[*] Checking if can create symlinks... "
        if ! ln -s "testfile.txt" "testfile_slink.txt"; then
            echo "FAIL"
            exit 1
        fi
        if [ -L "testfile_slink.txt" ]; then
            echo "OK"
        else
            echo "FAIL"
            exit 1
        fi

        echo -n "[*] Checking if symlinks are usable... "
        if ! echo "data" > "testfile_slink.txt" 2>/dev/null; then
            echo "FAIL"
            exit 1
        fi
        if [[ $(cat "testfile.txt") = $(cat "testfile_slink.txt") ]]; then
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
