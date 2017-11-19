###############################################################
##
##  Profile for interactive bash
##
###############################################################

## make sure that shell is non-interactive
[[ $- != *i* ]] && return

export HISTFILE="${HOME}/.bash_history"
export HISTSIZE=512
export HISTFILESIZE=16384
export HISTCONTROL="ignoreboth"

##
## Variable 'SHELL' is already set by 'basic_environment.sh',
## but we need also set it in 'bash.bashrc' so this variable
## will be updated on every new shell created.
##
export SHELL=$(readlink "/proc/$$/exe")

## set X/Termux terminal title
case "${TERM}" in
    xterm*|rxvt*)
        TERM_TITLE="\[\e]0;termux [\w]\a\]"
        ;;
    *)
        ;;
esac

PS1="${TERM_TITLE}\[\e[1;34m\][\[\e[m\]\[\e[1;31m\]termux\[\e[m\]\
\[\e[1;34m\]]\[\e[m\]\[\e[34m\]:\[\e[m\]\[\e[1;32m\]\w\[\e[m\]\
\[\e[1;34m\]:\[\e[m\]\[\e[1;37m\]\\$\[\e[m\] "

PS2='> '
PS3='> '
PS4='+ '

shopt -s checkwinsize
shopt -s cmdhist
shopt -s globstar
shopt -s histappend
shopt -s histverify

###############################################################
##
##  Load plugins
##
###############################################################

## a frontend for libtermux-exec.so
source "${PREFIX}/lib/shell/libtermux-exec.sh"

## default shell aliases for Termux
source "${PREFIX}/lib/shell/termux-aliases.sh"
