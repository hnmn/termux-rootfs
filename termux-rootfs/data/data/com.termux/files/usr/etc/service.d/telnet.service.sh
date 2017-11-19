#!/data/data/com.termux/files/usr/bin/bash
##
##  Service file for Telnet server
##
##  Run 'service telnet start' to start this service
##

## show service info for telnet when running 'service list'
if [ "${1}" == "--info" ]; then
    echo "telnet server (insecure !)"
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
    CURRENT_PID=$(pgrep -u "${TERMUX_UID}" -f '^telnetd')

    if [ ! -z "${CURRENT_PID}" ]; then
        echo "== Telnet server is already running."
        exit 1
    else
        echo -n "== Starting Telnet server... "
        if telnetd -l "${PREFIX}/bin/login" > /dev/null 2>&1; then
            echo "OK"
            echo "== Warning: Telnet protocol is not secure."
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

    CURRENT_PID=$(pgrep -u "${TERMUX_UID}" -f '^telnetd')

    if [ ! -z "${CURRENT_PID}" ]; then
        echo -n "== Stopping Telnet server... "

        if kill -TERM "${CURRENT_PID}" > /dev/null 2>&1; then
            echo "OK"
            exit 0
        else
            echo "FAIL"
            exit 1
        fi
    else
        echo "== Telnet server is not running."
        exit 1
    fi
}

service_status()
{
    local CURRENT_PID

    CURRENT_PID=$(pgrep -u "${TERMUX_UID}" -f '^telnetd')

    if [ ! -z "${CURRENT_PID}" ]; then
        echo "== Telnet server is running, pid ${CURRENT_PID}."
    else
        echo "== Telnet server is not running."
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
