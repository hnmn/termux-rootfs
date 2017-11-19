#!/data/data/com.termux/files/usr/bin/bash
##
##  Service file for MariaDB
##
##  Run 'service mariadb start' to start this service
##

## show service info for mariadb when running 'service list'
if [ "${1}" == "--info" ]; then
    echo "MySQL database server"
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

    local MYSQLD_ARGS="--basedir=/data/data/com.termux/files/usr             \
    --datadir=/data/data/com.termux/files/usr/var/lib/mysql                  \
    --plugin-dir=/data/data/com.termux/files/usr/lib/mysql/plugin            \
    --log-error=/data/data/com.termux/files/usr/var/lib/mysql/localhost.err  \
    --pid-file=localhost.pid"

    CURRENT_PID=$(pgrep -u "${TERMUX_UID}" -f 'mysqld --basedir.+')

    if [ ! -z "${CURRENT_PID}" ]; then
        echo "== MariaDB is already running."
        exit 1
    else
        echo -n "== Starting MariaDB... "

        start-stop-daemon -S -b -x "${PREFIX}/bin/mysqld" -- ${MYSQLD_ARGS} > /dev/null 2>&1

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

    CURRENT_PID=$(pgrep -u "${TERMUX_UID}" -f 'mysqld --basedir.+')

    if [ ! -z "${CURRENT_PID}" ]; then
        echo -n "== Stopping MariaDB... "
        sync

        if killall -w -u $(id -un "${TERMUX_UID}") mysqld > /dev/null 2>&1; then
            echo "OK"
            exit 0
        else
            echo "FAIL"
            exit 1
        fi
    else
        echo "== MariaDB is not running."
        exit 1
    fi
}

service_status()
{
    local CURRENT_PID

    CURRENT_PID=$(pgrep -u "${TERMUX_UID}" -f 'mysqld --basedir.+')

    if [ ! -z "${CURRENT_PID}" ]; then
        echo "== MariaDB is running, pid ${CURRENT_PID}."
    else
        echo "== MariaDB is not running."
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
