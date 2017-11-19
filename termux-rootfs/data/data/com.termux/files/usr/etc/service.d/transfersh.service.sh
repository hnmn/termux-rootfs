#!/data/data/com.termux/files/usr/bin/bash
##
##  Service file for Transfer.sh file server
##
##  Note: Termux RootFS uses a modified version of Transfer.sh.
##
##  Home page: https://transfer.sh/
##  Sources for original: https://github.com/dutchcoders/transfer.sh
##  Sources for modded version: see $PREFIX/share/doc/termux-rootfs/sources.tar.xz
##
##  Run 'service transfersh start' to start this service
##

## show service info for transfersh when running 'service list'
if [ "${1}" == "--info" ]; then
    echo "transfer.sh file server"
    exit 0
fi

# load config file
if [ ! -f "${PREFIX}/etc/conf.d/transfersh.conf" ]; then
    echo "== WARNING: '${PREFIX}/etc/conf.d/transfersh.conf' does not exist."
else
    source "${PREFIX}/etc/conf.d/transfersh.conf"
fi

# set default config values
[ -z "${BASEDIR}" ] && BASEDIR="${PREFIX}/var/lib/transfer.sh"
[ -z "${LOG_FILE}" ] && LOG_FILE="${PREFIX}/var/log/transfersh.log"
[ -z "${PORT}" ] && PORT="7080"
[ -z "${ENABLE_TLS}" ] && ENABLE_TLS=false
[ -z "${TLS_PORT}" ] && TLS_PORT="7443"
[ -z "${ALLOW_ONLY_HTTPS}" ] && ALLOW_ONLY_HTTPS=true

# do checks
if [ ! -e "${BASEDIR}" ]; then
    echo "== Error: directory '${BASEDIR}' is not exist."
    exit 1
fi

if ! grep -q -P '^\d{1,5}$' <(echo "${PORT}"); then
    echo "== Error: invalid value set for 'PORT'."
    exit 1
else
    if [ ${PORT} -gt 65535 ]; then
        echo "== Error: invalid value set for 'PORT'."
        exit 1
    fi
fi

if ! grep -q -P '^(true|false)$' <(echo "${ENABLE_TLS}"); then
    echo "== Error: invalid value set for 'ENABLE_TLS'."
    exit 1
fi

if ${ENABLE_TLS}; then
    if ! grep -q -P '^(true|false)$' <(echo "${ALLOW_ONLY_HTTPS}"); then
        echo "== Error: invalid value set for 'ALLOW_ONLY_HTTPS'."
        exit 1
    fi

    if ! grep -q -P '^\d{1,5}$' <(echo "${TLS_PORT}"); then
        echo "== Error: invalid value set for 'TLS_PORT'."
        exit 1
    else
        if [ ${TLS_PORT} -gt 65535 ]; then
            echo "== Error: invalid value set for 'TLS_PORT'."
            exit 1
        fi
    fi

    if [ ! -z "${TLS_CERT}" ]; then
        if [ ! -f "${TLS_CERT}" ]; then
            echo "== Error: TLS certificate '${TLS_CERT}' is not found."
            exit 1
        fi
    else
        echo "== Error: TLS enabled but certificate is not specified."
        exit 1
    fi

    if [ ! -z "${TLS_KEY}" ]; then
        if [ ! -f "${TLS_KEY}" ]; then
            echo "== Error: TLS private key '${TLS_KEY}' is not found."
            exit 1
        fi
    else
        echo "== Error: TLS enabled but private key is not specified."
        exit 1
    fi
fi

###############################################################################
##
##  Service functions
##
###############################################################################

update_current_pid()
{
    CURRENT_PID=$(pgrep -u "${TERMUX_UID}" -f '^transfer.sh .+')
}

start_service()
{
    update_current_pid

    if [ ! -z "${CURRENT_PID}" ]; then
        echo "== Transfer.sh server is already running."
        exit 1
    else
        echo -n "== Starting Transfer.sh server... "

        if ${ENABLE_TLS}; then
            if ${ALLOW_ONLY_HTTPS}; then
                transfer.sh --tls-listener :"${TLS_PORT}"  \
                            --basedir "${BASEDIR}"         \
                            --tls-cert-file "${TLS_CERT}"  \
                            --tls-private-key "${TLS_KEY}" >> "${LOG_FILE}" 2>&1 &
            else
                transfer.sh --listener :"${PORT}"          \
                            --tls-listener :"${TLS_PORT}"  \
                            --basedir "${BASEDIR}"         \
                            --tls-cert-file "${TLS_CERT}"  \
                            --tls-private-key "${TLS_KEY}" >> "${LOG_FILE}" 2>&1 &
            fi
        else
            transfer.sh --listener :"${PORT}"  \
                        --basedir "${BASEDIR}" >> "${LOG_FILE}" 2>&1 &
        fi

        ## TODO: is this can be improved ?
        usleep 500000
        update_current_pid

        if [ ! -z "${CURRENT_PID}" ]; then
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
    update_current_pid

    if [ ! -z "${CURRENT_PID}" ]; then
        echo -n "== Stopping Transfer.sh server... "
        sync

        if kill -TERM "${CURRENT_PID}" > /dev/null 2>&1; then
            echo "OK"
            exit 0
        else
            echo "FAIL"
            exit 1
        fi
    else
        echo "== Transfer.sh server is not running."
        exit 1
    fi
}

service_status()
{
    update_current_pid

    if [ ! -z "${CURRENT_PID}" ]; then
        echo "== Transfer.sh server is running, pid ${CURRENT_PID}."
    else
        echo "== Transfer.sh server is not running."
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
