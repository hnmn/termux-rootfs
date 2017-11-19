#!/data/data/com.termux/files/usr/bin/bash
##
##  Service file for FTP server
##
##  Run 'service ftp start' to start this service
##

## show service info for ftp when running 'service list'
if [ "${1}" == "--info" ]; then
    echo "anonymous FTP server (insecure !)"
    exit 0
fi

# load config file
if [ ! -f "${PREFIX}/etc/conf.d/ftp.conf" ]; then
    echo "== WARNING: '${PREFIX}/etc/conf.d/ftp.conf' does not exist."
else
    source "${PREFIX}/etc/conf.d/ftp.conf"
fi

# set default config values
[ -z "${FTP_HOME}" ] && FTP_HOME="/data/data/com.termux/files/home"

###############################################################################
##
##  Service functions
##
###############################################################################

start_service()
{
    local CURRENT_PID

    CURRENT_PID=$(pgrep -u "${TERMUX_UID}" -f "^${PREFIX}/bin/tcpsvd .+ ftpd .+$")

    TCPSVD_ARGS="-vE 0.0.0.0 8021 ftpd"

    if [ ! -z "${CURRENT_PID}" ]; then
        echo "== FTP server is already running."
        exit 1
    else
        echo -n "== Starting FTP server... "

        start-stop-daemon -S -b -x "${PREFIX}/bin/tcpsvd" -- ${TCPSVD_ARGS} "${FTP_HOME}" > /dev/null 2>&1

        if [ "$?" == "0" ]; then
            echo "OK"
            echo "== Warning: FTP protocol is not secure. Also,"
            echo "   this server provides only anonymous login."
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

    CURRENT_PID=$(pgrep -u "${TERMUX_UID}" -f "^${PREFIX}/bin/tcpsvd .+ ftpd .+$")

    if [ ! -z "${CURRENT_PID}" ]; then
        echo -n "== Stopping FTP server... "
        sync

        if kill -TERM "${CURRENT_PID}" > /dev/null 2>&1; then
            echo "OK"
            exit 0
        else
            echo "FAIL"
            exit 1
        fi
    else
        echo "== FTP server is not running."
        exit 1
    fi
}

service_status()
{
    local CURRENT_PID

    CURRENT_PID=$(pgrep -u "${TERMUX_UID}" -f "^${PREFIX}/bin/tcpsvd .+ ftpd .+$")

    if [ ! -z "${CURRENT_PID}" ]; then
        echo "== FTP server is running, pid ${CURRENT_PID}."
    else
        echo "== FTP server is not running."
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
