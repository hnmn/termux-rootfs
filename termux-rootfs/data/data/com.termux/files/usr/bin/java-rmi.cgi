#!/data/data/com.termux/files/usr/bin/bash
##
##  This is a wrapper for Java 8 JDK tool 'java-rmi.cgi'
##

unset LD_PRELOAD
unset LD_LIBRARY_PATH

[ -z "${HOME}" ] && export HOME=/data/data/com.termux/files/home

export BASE_DIR="/data/data/com.termux/files/usr"
export JAVA_HOME="${BASE_DIR}/opt/java-8-jdk"
export JAVA_TOOL_OPTIONS="-Duser.home=${HOME}"

exec "${JAVA_HOME}/bin/java-rmi.cgi" "${@}" 2> >(sed '/Picked up JAVA_TOOL_OPTIONS:/d')