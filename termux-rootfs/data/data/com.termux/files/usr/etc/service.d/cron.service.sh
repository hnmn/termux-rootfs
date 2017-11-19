#!/data/data/com.termux/files/usr/bin/bash
##
##  Service file for crond
##
##  Run 'service cron start' to start this service
##

## show service info for crond when running 'service list'
if [ "${1}" == "--info" ]; then
    echo "periodic task executor"
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

    CURRENT_PID=$(pgrep -u "${TERMUX_UID}" -f '^crond$')

    if [ ! -z "${CURRENT_PID}" ]; then
        echo "== Cron is already running."
        exit 1
    else
        echo -n "== Starting Cron... "
        if crond > /dev/null 2>&1; then
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

    CURRENT_PID=$(pgrep -u "${TERMUX_UID}" -f '^crond$')

    if [ ! -z "${CURRENT_PID}" ]; then
        echo -n "== Stopping Cron... "
        sync
        if kill "${CURRENT_PID}" > /dev/null 2>&1; then
            echo "OK"
            exit 0
        else
            echo "FAIL"
            exit 1
        fi
    else
        echo "== Cron is not running."
        exit 1
    fi
}

service_status()
{
    local CURRENT_PID

    CURRENT_PID=$(pgrep -u "${TERMUX_UID}" -f '^crond$')

    if [ ! -z "${CURRENT_PID}" ]; then
        echo "== Cron is running, pid ${CURRENT_PID}."
    else
        echo "== Cron is not running."
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
