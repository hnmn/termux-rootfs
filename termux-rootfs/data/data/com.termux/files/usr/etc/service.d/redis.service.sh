#!/data/data/com.termux/files/usr/bin/bash
##
##  Service file for Redis
##
##  Run 'service redis start' to start this service
##

## show service info for redis when running 'service list'
if [ "${1}" == "--info" ]; then
    echo "advanced key-value store"
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
    local REDIS_CONFIG

    REDIS_CONFIG="${PREFIX}/etc/redis.conf"
    CURRENT_PID=$(pgrep -u "${TERMUX_UID}" -f '^redis-server .+')

    if ! grep -q -P '^\s*daemonize\s+yes\s*$' "${PREFIX}"/etc/redis.conf; then
        echo "== ERROR: Redis does not configured to run as daemon."
        exit 1
    fi

    if [ ! -z "${CURRENT_PID}" ]; then
        echo "== Redis is already running."
        exit 1
    else
        echo -n "== Starting Redis... "

        redis-server "${REDIS_CONFIG}" > /dev/null 2>&1

        if [ "$?" == "0" ]; then
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

    CURRENT_PID=$(pgrep -u "${TERMUX_UID}" -f '^redis-server .+')

    if [ ! -z "${CURRENT_PID}" ]; then
        echo -n "== Stopping Redis... "
        sync

        if redis-cli shutdown > /dev/null 2>&1; then
            echo "OK"
            exit 0
        else
            echo "FAIL"
            exit 1
        fi
    else
        echo "== Redis is not running."
        exit 1
    fi
}

service_status()
{
    local CURRENT_PID

    CURRENT_PID=$(pgrep -u "${TERMUX_UID}" -f '^redis-server .+')

    if [ ! -z "${CURRENT_PID}" ]; then
        echo "== Redis is running, pid ${CURRENT_PID}."
    else
        echo "== Redis is not running."
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
