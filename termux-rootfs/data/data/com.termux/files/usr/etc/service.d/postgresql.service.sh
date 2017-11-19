#!/data/data/com.termux/files/usr/bin/bash
##
##  Service file for PostgreSQL
##
##  Run 'service postgresql start' to start this service
##

## show service info for postgresql when running 'service list'
if [ "${1}" == "--info" ]; then
    echo "PostgreSQL database server"
    exit 0
fi

PGSQL_DIR="${PREFIX}/var/lib/postgresql"
PGSQL_LOG="${PREFIX}/var/log/postgresql.log"
DATABASE_LOCATION="${PGSQL_DIR}/db"

###############################################################################
##
##  Service functions
##
###############################################################################

check_db()
{
    local NEED_TO_CREATE_DB=false

    if [ ! -e "${DATABASE_LOCATION}" ]; then
        echo -n "== Creating directory for database... "
        if mkdir -m 700 "${DATABASE_LOCATION}" > /dev/null 2>&1; then
            echo "OK"
        else
            echo "FAIL"
            exit 1
        fi

        NEED_TO_CREATE_DB=true
    fi

    if [[ -z $(ls -A "${DATABASE_LOCATION}") ]]; then
        NEED_TO_CREATE_DB=true
    fi

    if ${NEED_TO_CREATE_DB}; then
        echo -n "== Initializing database... "
        if initdb "${DATABASE_LOCATION}" > /dev/null 2>&1; then
            echo "OK"
        else
            echo "FAIL"
            exit 1
        fi
    fi
}

start_service()
{
    local CURRENT_PID
    CURRENT_PID=$(pgrep -u "${TERMUX_UID}" -f "^${PREFIX}/bin/postgres")

    ## Check if database installed
    check_db

    if [ ! -z "${CURRENT_PID}" ]; then
        echo "== PostgreSQL is already running."
        exit 1
    else
        echo -n "== Starting PostgreSQL... "
        if pg_ctl -s -D "${DATABASE_LOCATION}" start -w -t 25 -l "${PGSQL_LOG}" > /dev/null 2>&1; then
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

    CURRENT_PID=$(pgrep -u "${TERMUX_UID}" -f "^${PREFIX}/bin/postgres")

    if [ ! -z "${CURRENT_PID}" ]; then
        echo -n "== Stopping PostgreSQL... "
        sync

        if pg_ctl -s -D "${DATABASE_LOCATION}" stop > /dev/null 2>&1; then
            echo "OK"
            exit 0
        else
            echo "FAIL"
            exit 1
        fi
    else
        echo "== PostgreSQL is not running."
        exit 1
    fi
}

service_status()
{
    local CURRENT_PID

    CURRENT_PID=$(pgrep -u "${TERMUX_UID}" -f "^${PREFIX}/bin/postgres")

    if [ ! -z "${CURRENT_PID}" ]; then
        echo "== PostgreSQL is running, pid ${CURRENT_PID}."
    else
        echo "== PostgreSQL is not running."
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
