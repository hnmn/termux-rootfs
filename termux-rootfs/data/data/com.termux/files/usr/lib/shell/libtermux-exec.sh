##
##  A shell frontend for 'libtermux-exec'
##
##  Should be sourced into your shell if you want to
##  use it.
##

termux-exec()
{
    if [ -z "${1}" ]; then
        echo
        echo " Usage: termux-exec [enable|disable]"
        echo
        echo " A execve() wrapper to fix problem with shebangs."
        echo
    elif [ "${1}" = "enable" ]; then
        if ! grep -qP "${PREFIX}/lib/libtermux-exec.so" <<< "${LD_PRELOAD}"; then
            if [ ! -z "${LD_PRELOAD}" ]; then
                export LD_PRELOAD="${PREFIX}/lib/libtermux-exec.so:${LD_PRELOAD}"
            else
                export LD_PRELOAD="${PREFIX}/lib/libtermux-exec.so"
            fi

            echo "[*] termux-exec enabled."

            exec "${SHELL}"
        else
            echo "[!] termux-exec is already enabled."
            return 1
        fi
    elif [ "${1}" = "disable" ]; then
        if grep -qP "${PREFIX}/lib/libtermux-exec.so" <<< "${LD_PRELOAD}"; then
            LD_PRELOAD=$(echo :${LD_PRELOAD}: | sed -e "s,:${PREFIX}/lib/libtermux-exec.so:,:,g" -e 's/^://' -e 's/:$//')
            [ -z "${LD_PRELOAD}" ] && unset LD_PRELOAD

            echo "[*] termux-exec disabled."

            exec "${SHELL}"
        else
            echo "[!] termux-exec is not enabled."
            return 1
        fi
    else
        echo
        echo " Usage: termux-exec [enable|disable]"
        echo
        echo " A execve() wrapper to fix problem with shebangs."
        echo
    fi
}
