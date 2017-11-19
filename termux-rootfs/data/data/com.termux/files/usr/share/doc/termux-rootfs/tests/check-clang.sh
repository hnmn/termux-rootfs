#!/data/data/com.termux/files/usr/bin/bash
##
##  Check if Clang (clang/clang++) is working by compiling and running simple programs
##

TMPDIR="/data/data/com.termux/files/usr/tmp"

test_clang()
{
    local PROG_PATH
    local PROG_PATH_BIN
    local IS_FAILED=false

    PROG_PATH=$(mktemp --suffix=".c" "${TMPDIR}/testprog-XXXXXXXX")
    PROG_PATH_BIN="${PROG_PATH}.bin"

    cat <<- EOF > "${PROG_PATH}"
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

static void test01() {
    const char *str = "This is a test!";
    printf("Hello World! %s\n", str);
}

static void test02() {
    double num = 144;
    double sqr = sqrt(num);

    printf("%.02f\n", sqr);
}

static void test03() {
    const int bufsize = 4;
    char *ptr = NULL;

    ptr = malloc((bufsize + 1) * sizeof(char));

    if (ptr) {
        memset(ptr, 0x61, bufsize);
        printf("%s\n", ptr);
        free(ptr);
    } else {
        puts("failure");
    }
}

int main(int argc, char **argv) {
    if (argc > 1) {
        if (strcmp(argv[1], "-1") == 0) {
            test01();
            return 0;
        } else if (strcmp(argv[1], "-2") == 0) {
            test02();
            return 0;
        } else if (strcmp(argv[1], "-3") == 0) {
            test03();
            return 0;
        } else {
            puts("invalid arg");
            return 0;
        }
    } else {
        puts("no args");
        return 0;
    }
}
EOF

    if [ -f "${PROG_PATH}" ]; then
        if clang -O3 "${PROG_PATH}" -o "${PROG_PATH_BIN}" -lm >/dev/null 2>&1; then
            echo "[*] Successfully compiled. Running tests..."

            echo -n "[*] Test 1: "
            if [[ $("${PROG_PATH_BIN}" -1) = "Hello World! This is a test!" ]]; then
                echo "OK"
            else
                echo "FAIL"
                IS_FAILED=true
            fi

            echo -n "[*] Test 2: "
            if [[ $("${PROG_PATH_BIN}" -2) = "12.00" ]]; then
                echo "OK"
            else
                echo "FAIL"
                IS_FAILED=true
            fi

            echo -n "[*] Test 3: "
            if [[ $("${PROG_PATH_BIN}" -3) = "aaaa" ]]; then
                echo "OK"
            else
                echo "FAIL"
                IS_FAILED=true
            fi
        else
            echo "[!] Failed to compile program."
            IS_FAILED=true
        fi
    else
        echo "[!] Failed to write test program."
        IS_FAILED=true
    fi

    rm -f "${PROG_PATH_BIN}" "${PROG_PATH}"

    if ${IS_FAILED}; then
        return 1
    else
        return 0
    fi
}

test_clangpp()
{
    local PROG_PATH
    local PROG_PATH_BIN
    local IS_FAILED=false

    PROG_PATH=$(mktemp --suffix=".cpp" "${TMPDIR}/testprog-XXXXXXXX")
    PROG_PATH_BIN="${PROG_PATH}.bin"

    cat <<- EOF > "${PROG_PATH}"
#include <iostream>
#include <iomanip>
#include <cmath>

using namespace std;

class Triangle {
    private:
        int a, b, c;
        double sp(void) {
            return (a + b + c) / 2;
        }

    public:
        Triangle(int, int, int);
        double area(void) {
            double sp = (a+b+c) / 2.0f;
            return sqrt(sp * (sp-a)*(sp-b)*(sp-c));
        }
};

Triangle::Triangle(int a, int b, int c) {
    this->a = a;
    this->b = b;
    this->c = c;
}

int main(void) {
    Triangle t (3, 9, 8);
    cout << setprecision(5) << t.area() << endl;
}
EOF

    if [ -f "${PROG_PATH}" ]; then
        if clang++ -O3 "${PROG_PATH}" -o "${PROG_PATH_BIN}" >/dev/null 2>&1; then
            echo "[*] Successfully compiled. Running tests..."

            echo -n "[*] Test 1: "
            if [[ $("${PROG_PATH_BIN}") = "11.832" ]]; then
                echo "OK"
            else
                echo "FAIL"
                IS_FAILED=true
            fi
        else
            echo "[!] Failed to compile program."
            IS_FAILED=true
        fi
    else
        echo "[!] Failed to write test program."
        IS_FAILED=true
    fi

    rm -f "${PROG_PATH_BIN}" "${PROG_PATH}"

    if ${IS_FAILED}; then
        return 1
    else
        return 0
    fi
}

CLANG_VER=$(clang --version | grep ^clang | awk '{ print $3 }')
echo "[*] Testing Clang (${CLANG_VER})..."
if test_clang; then
    echo "[*] Clang test: PASSED"
else
    echo "[!] Clang test: FAILED"
    exit 1
fi

echo
echo "[*] Testing Clang++ (${CLANG_VER})..."
if test_clangpp; then
    echo "[*] Clang++ test: PASSED"
    exit 0
else
    echo "[!] Clang++ test: FAILED"
    exit 1
fi
