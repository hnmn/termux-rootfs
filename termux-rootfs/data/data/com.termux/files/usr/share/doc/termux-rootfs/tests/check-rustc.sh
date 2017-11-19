#!/data/data/com.termux/files/usr/bin/bash
##
##  Check if RustC is working by compiling and running simple program
##

TMPDIR="/data/data/com.termux/files/usr/tmp"
PROG_PATH=$(mktemp --suffix=".rs" "${TMPDIR}/testprog-XXXXXXXX")
PROG_PATH_BIN="${PROG_PATH}.bin"
IS_FAIL=false

test_exit()
{
    rm -f "${PROG_PATH}" "${PROG_PATH_BIN}"
}
trap test_exit SIGHUP SIGINT SIGQUIT SIGTERM EXIT

cat <<- EOF > "${PROG_PATH}"
fn main() {
    println!("Hello World!");
}
EOF

if [ ! -f "${PROG_PATH}" ]; then
    echo "[!] Failed to write a test program."
    exit 1
fi

RUST_VER=$(rustc --version | awk '{ print $2 }')
echo "[*] Testing Rust Compiler (${RUST_VER})..."
if rustc "${PROG_PATH}" -o "${PROG_PATH_BIN}" >/dev/null 2>&1; then
    echo "[*] Successfully compiled. Running tests..."

    echo -n "[*] Test 1: "
    if [[ $("${PROG_PATH_BIN}") = "Hello World!" ]]; then
        echo "OK"
    else
        echo "FAIL"
        IS_FAIL=true
    fi

    if ! ${IS_FAIL}; then
        echo "[*] Rust Compiler test: PASSED"
        exit 0
    else
        echo "[!] Rust Compiler test: FAILED"
        exit 1
    fi
else
    echo "[!] Failed to compile a test program."
    exit 1
fi
