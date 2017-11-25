#!/data/data/com.termux/files/usr/bin/bash
##
##  Service file for Minecraft server
##
##  Run 'service minecraft start' to start this service
##

## show service info for minecraft when running 'service list'
if [ "${1}" == "--info" ]; then
    echo "Minecraft server (v1.11.2)"
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
    local EULA_PROCESSED

    CURRENT_PID=$(pgrep -u "${TERMUX_UID}" -f "^${PREFIX}/lib/jvm/openjdk-9/bin/java .+ ${PREFIX}/var/lib/minecraft")

    ## Prepare server directory
    export HOME="${PREFIX}/var/lib/minecraft"
    if [[ ! -e $(realpath "${HOME}/minecraft_server.jar") ]]; then
        echo -n "== Creating link to the server's jar file... "
        if ln -sf "${PREFIX}/share/java/exe/minecraft_server_v1.11.2.jar" "${HOME}/minecraft_server.jar" > /dev/null 2>&1; then
            echo "OK"
        else
            echo "FAIL"
            exit 1
        fi
    fi

    if [ ! -z "${CURRENT_PID}" ]; then
        echo "== Minecraft server is already running."
        exit 1
    else
        echo -n "== Starting Minecraft (v1.11.2) server... "

        ## Execute this in subshell
        ( cd "${HOME}" && start-stop-daemon -S -b -x "${PREFIX}/bin/java" -- -jar "${HOME}/minecraft_server.jar" > /dev/null 2>&1 )

        if [ "$?" == "0" ]; then
            echo "OK"
            while true; do
                if [ -e "${HOME}/eula.txt" ]; then
                    break
                fi
            done
            if grep -q -P '^eula=false$' "${HOME}/eula.txt" > /dev/null 2>&1; then
                echo "== You need to check '\${PREFIX}/var/lib/minecraft/eula.txt'."
                echo "   Change line 'eula=false' to 'eula=true', then start server"
                echo "   again."
            fi
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

    CURRENT_PID=$(pgrep -u "${TERMUX_UID}" -f "^${PREFIX}/lib/jvm/openjdk-9/bin/java .+ ${PREFIX}/var/lib/minecraft")

    if [ ! -z "${CURRENT_PID}" ]; then
        echo -n "== Stopping Minecraft server... "
        sync

        ## Java 9 currently can be stopped only by signal 'KILL'
        if kill -KILL "${CURRENT_PID}" > /dev/null 2>&1; then
            while true; do
                CURRENT_PID=$(pgrep -u "${TERMUX_UID}" -f "^${PREFIX}/lib/jvm/openjdk-9/bin/java .+ ${PREFIX}/var/lib/minecraft")
                if [ -z "${CURRENT_PID}" ]; then
                    break
                fi
            done
            echo "OK"
            exit 0
        else
            echo "FAIL"
            exit 1
        fi
    else
        echo "== Minecraft server is not running."
        exit 1
    fi
}

service_status()
{
    local CURRENT_PID

    CURRENT_PID=$(pgrep -u "${TERMUX_UID}" -f "^${PREFIX}/lib/jvm/openjdk-9/bin/java .+ ${PREFIX}/var/lib/minecraft")

    if [ ! -z "${CURRENT_PID}" ]; then
        echo "== Minecraft server is running, pid ${CURRENT_PID}."
    else
        echo "== Minecraft server is not running."
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
