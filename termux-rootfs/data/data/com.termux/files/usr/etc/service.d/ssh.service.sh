#!/data/data/com.termux/files/usr/bin/bash
##
##  Service file for OpenSSH server
##
##  Run 'service ssh start' to start this service
##

## show service info for ssh when running 'service list'
if [ "${1}" == "--info" ]; then
    echo "OpenSSH server"
    exit 0
fi

###############################################################################
##
##  Service functions
##
###############################################################################

start_service()
{
    local CURRENT_PID

    CURRENT_PID=$(pgrep -u "${TERMUX_UID}" -f '^sshd -E /.+$')

    LOG_FILE="${PREFIX}/var/log/sshd.log"

    if [ ! -z "${CURRENT_PID}" ]; then
        echo "== SSH is already running."
        exit 1
    else
        echo -n "== Checking SSH configuration... "
        if sshd -t > /dev/null 2>&1; then
            echo "OK"
        else
            echo "FAIL"
            exit 1
        fi

        echo -n "== Starting SSH... "
        if sshd -E "${LOG_FILE}" > /dev/null 2>&1; then
            echo "OK"
            exit 0
        else
            echo "FAIL"
            exit 1
        fi
    fi
}

stop_service()
{
    local CURRENT_PID

    CURRENT_PID=$(pgrep -u "${TERMUX_UID}" -f '^sshd -E /.+$')

    if [ ! -z "${CURRENT_PID}" ]; then
        echo -n "== Stopping SSH... "
        if kill "${CURRENT_PID}" > /dev/null 2>&1; then
            echo "OK"
            exit 0
        else
            echo "FAIL"
            exit 1
        fi
    else
        echo "== SSH is not running."
        exit 1
    fi
}

service_status()
{
    local CURRENT_PID

    CURRENT_PID=$(pgrep -u "${TERMUX_UID}" -f '^sshd -E /.+$')

    if [ ! -z "${CURRENT_PID}" ]; then
        echo "== SSH is running, pid ${CURRENT_PID}."
    else
        echo "== SSH is not running."
    fi
}

###############################################################################
##
##  Command line arguments handling
##
###############################################################################

if [ ! -z "${1}" ]; then
    case "${1}" in
        start)
            start_service
            ;;
        stop)
            stop_service
            ;;
        status)
            service_status
            ;;
        *)
            echo "[!] Command '${1}' is not defined."
            exit 1
            ;;
    esac
fi
