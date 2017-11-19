##
##  Default shell aliases for Termux
##

# setup colorful output
if [ -r "${HOME}/.dircolors" ]; then
    eval $(dircolors -b "${HOME}/.dircolors")
else
    eval $(dircolors -b "${PREFIX}/etc/dircolors.conf")
fi

alias dir='dir --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias ls='ls --color=auto'
alias l='ls --color=auto'
alias la='ls -a --color=auto'
alias ll='ls -l --color=auto'
alias lo='ls -la --color=auto'
alias vdir='vdir --color=auto'

# for safety
alias cp='cp -i'
alias ln='ln -i'
alias mv='mv -i'
alias rm='rm -i'

# tor related aliases
alias tor-curl='torsocks curl'
alias tor-lynx='torsocks lynx'
alias tor-wget='torsocks wget'
alias torbrowser='torsocks lynx'

# misc useful aliases
if [ "$(id -u)" = "0" ]; then
    alias aird='airodump-ng'
    alias airp='aireplay-ng'
    alias mdk='mdk3'
    alias termux-own="chown ${TERMUX_UID}:${TERMUX_UID}"
else
    alias aird='sudo airodump-ng'
    alias airp='sudo aireplay-ng'
    alias mdk='sudo mdk'
    alias termux-own="sudo chown ${TERMUX_UID}:${TERMUX_UID}"
fi
