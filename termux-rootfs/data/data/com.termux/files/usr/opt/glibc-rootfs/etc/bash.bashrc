[[ $- != *i* ]] && return

#############################################################################
##
##  Bash environment
##
#############################################################################

export HISTFILE="${HOME}/.bash_history"
export HISTSIZE=512
export HISTFILESIZE=4096
export HISTCONTROL="ignoreboth"

# set terminal title
case "${TERM}" in
    xterm*|rxvt*)
        TERM_TITLE="\[\e]0;Termux (glibc) [\w]\a\]"
        ;;
    *)
        ;;
esac

PS1="${TERM_TITLE}\[\e[1;34m\][\[\e[m\]\[\e[1;31m\]chroot\[\e[m\]\
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

#############################################################################
##
##  Aliases for colorful output
##
#############################################################################

if [ -r "${HOME}/.dircolors" ]; then
    eval $(dircolors -b "${HOME}/.dircolors")
else
    eval $(dircolors -b "/etc/dircolors.conf")
fi

alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias ls='ls --color=auto'
alias l='ls --color=auto'
alias la='ls -a --color=auto'
alias ll='ls -l --color=auto'
alias lo='ls -la --color=auto'

#############################################################################
##
##  Aliases for safety
##
#############################################################################

alias cp='cp -i'
alias ln='ln -i'
alias mv='mv -i'
alias rm='rm -i'
