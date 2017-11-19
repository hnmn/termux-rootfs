#!/data/data/com.termux/files/usr/bin/bash
##
##  Service file for polipo
##
##  Run 'service polipo start' to start this service
##

# show service info for polipo when running 'service list'
if [ "${1}" == "--info" ]; then
    echo "caching web proxy"
    exit 0
fi

# load config file
if [ ! -f "${PREFIX}/etc/conf.d/polipo.conf" ]; then
    echo "== WARNING: '${PREFIX}/etc/conf.d/polipo.conf' does not exist."
else
    source "${PREFIX}/etc/conf.d/polipo.conf"
fi

# set default config values
[ -z "${TOR_PARENT_PROXY}" ] && TOR_PARENT_PROXY=false

# do checks
if ! grep -q -P '^(true|false)$' <(echo "${TOR_PARENT_PROXY}"); then
    echo "== Error: invalid value set for 'TOR_PARENT_PROXY'."
    exit 1
fi

###############################################################################
##
##  Service functions
##
###############################################################################

start_service()
{
    local CURRENT_PID
    local POLIPO_CONFIG

    CURRENT_PID=$(pgrep -u "${TERMUX_UID}" '^polipo$')

    if ${TOR_PARENT_PROXY}; then
        POLIPO_CONFIG="${PREFIX}/etc/polipo/config-tor"
    else
        POLIPO_CONFIG="${PREFIX}/etc/polipo/config"
    fi

    if ! grep -q -P '^\s*daemonise\s*=\s*true$' "${POLIPO_CONFIG}"; then
        echo "== ERROR: polipo is not configured to run as daemon."
        exit 1
    fi

    if ${TOR_PARENT_PROXY}; then
        if [ -z "$(pgrep -u ${TERMUX_UID} -f '^tor$')" ]; then
            if ! service tor start; then
                echo "== TOR is not started, cannot continue."
                exit 1
            fi
        fi
    fi

    if [ ! -z "${CURRENT_PID}" ]; then
        echo "== Polipo is already running."
        exit 1
    else
        echo -n "== Starting polipo server... "
        if polipo -c "${POLIPO_CONFIG}" > /dev/null 2>&1; then
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

    CURRENT_PID=$(pgrep -u "${TERMUX_UID}" '^polipo$')

    if ${TOR_PARENT_PROXY}; then
        if [ ! -z "$(pgrep -u ${TERMUX_UID} -f '^tor$')" ]; then
            echo "== Note: TOR will continue run. If you don't need it, you"
            echo "   can stop it manually."
        fi
    fi

    if [ ! -z "${CURRENT_PID}" ]; then
        echo -n "== Stopping Polipo... "
        if kill "${CURRENT_PID}" > /dev/null 2>&1; then
            echo "OK"
            exit 0
        else
            echo "FAIL"
            exit 1
        fi
    else
        echo "== Polipo is not running."
        exit 1
    fi
}

service_status()
{
    local CURRENT_PID

    CURRENT_PID=$(pgrep -u "${TERMUX_UID}" '^polipo$')

    if [ ! -z "${CURRENT_PID}" ]; then
        echo "== Polipo is running, pid ${CURRENT_PID}."
    else
        echo "== Polipo is not running."
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
