###############################################################
##
##  Local bash profile
##
###############################################################

## load bashrc if shell is interactive
if [[ "$-" = *"i"* ]]; then
    if [ -r "${HOME}/.bashrc" ]; then
        . "${HOME}/.bashrc"
    fi
fi
