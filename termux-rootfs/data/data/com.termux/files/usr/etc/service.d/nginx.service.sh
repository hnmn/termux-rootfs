#!/data/data/com.termux/files/usr/bin/bash
##
##  Service file for nginx
##
##  Run 'service nginx start' to start this service
##

## show service info for nginx when running 'service list'
if [ "${1}" == "--info" ]; then
    echo "web server"
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

    CURRENT_PID=$(pgrep -u "${TERMUX_UID}" -f '^nginx')

    if [ ! -z "${CURRENT_PID}" ]; then
        echo "== Nginx is already running."
        exit 1
    else
        echo -n "== Checking Nginx configuration... "
        if nginx -t > /dev/null 2>&1; then
            echo "OK"
        else
            echo "FAIL"
            exit 1
        fi

        echo -n "== Starting Nginx... "
        if nginx > /dev/null 2>&1; then
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

    CURRENT_PID=$(pgrep -u "${TERMUX_UID}" -f '^nginx')

    if [ ! -z "${CURRENT_PID}" ]; then
        echo -n "== Stopping Nginx... "
        sync
        if nginx -s quit > /dev/null 2>&1; then
            echo "OK"
            exit 0
        else
            echo "FAIL"
            exit 1
        fi
    else
        echo "== Nginx is not running."
        exit 1
    fi
}

service_status()
{
    local CURRENT_PID

    CURRENT_PID=$(pgrep -u "${TERMUX_UID}" -f '^nginx: master')

    if [ ! -z "${CURRENT_PID}" ]; then
        echo "== Nginx is running, pid ${CURRENT_PID}."
    else
        echo "== Nginx is not running."
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
