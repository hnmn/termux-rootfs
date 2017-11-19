#!/data/data/com.termux/files/usr/bin/bash
##
##  Check if Java (openjdk-jre, dx, ecj, dalvikvm) is working by compiling and running simple programs
##

TMPDIR="/data/data/com.termux/files/usr/tmp"
CURDIR="${PWD}"
WORK_DIR=$(mktemp -d "${TMPDIR}/XXXXXXXXX")

PROG_CLASS_NAME="JavaTest"
PROG_FILE="${PROG_CLASS_NAME}.java"
PROG_CLASS_FILE="${PROG_CLASS_NAME}.class"

test_exit()
{
    cd "${CUR_DIR}"
    rm -rf "${WORK_DIR}"
}
trap test_exit SIGHUP SIGINT SIGQUIT SIGTERM EXIT

cat <<- EOF > "${WORK_DIR}/${PROG_FILE}"
import java.util.ArrayList;

public class JavaTest {
    public static void main(String[] args) {
        ArrayList<Integer> list = new ArrayList<Integer>();
        int counter = 0;

        for (int i=0; i<1000; i++) {
            list.add(i);
        }

        for (int i=0; i<1000; i++) {
            counter += list.get(i);
        }

        System.out.println("The sum is " + counter);
    }
}
EOF

if [ ! -f "${WORK_DIR}/${PROG_FILE}" ]; then
    echo "[!] Failed to write a test program."
    exit 1
fi

(
    cd "${WORK_DIR}" && {
        if ecj "${PROG_FILE}" > /dev/null 2>&1; then
            echo "[*] Successfully compiled. Running tests..."
        else
            echo "[!] Failed to compile test program."
            exit 1
        fi

        echo -n "[*] Java 8 JRE test: "
        if [[ $(java "${PROG_CLASS_NAME}") = "The sum is 499500" ]]; then
            echo "PASSED"
        else
            echo "FAILED"
        fi

        echo -n "[*] DX test: "
        if dx --dex --output="classes.dex" "${PROG_CLASS_FILE}" > /dev/null 2>&1; then
            if [[ $(file classes.dex | tr '[[:upper:]]' '[[:lower:]]' | awk '{ print $2 }') = "dalvik" ]]; then
                echo "PASSED"
            else
                echo "FAILED"
            fi
        else
            echo "FAILED"
        fi

        echo -n "[*] DalvikVM test: "
        if [[ $(dalvikvm -cp "classes.dex" "${PROG_CLASS_NAME}") = "The sum is 499500" ]]; then
            echo "PASSED"
        else
            echo "FAILED"
        fi
    } || {
        echo "[!] Cannot cd to '${WORK_DIR}'."
        exit 1
    }
)
