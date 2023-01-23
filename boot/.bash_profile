# .bash_profile

set -o vi

if [[ $PWD =~ mnt ]]; then
    cd ~
fi

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs
HISTCONTROL=ignoredups:erasedups
shopt -s histappend
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# VPN proxy
WSL_VPNKIT=$(wsl.exe -l --running | tr -d '\0' | grep -c wsl-vpnkit)
if (( WSL_VPNKIT == 0 ))
then
	wsl.exe -d wsl-vpnkit service wsl-vpnkit start
fi

# https://github.com/containers/buildah/issues/3726
eval $(echo export $(findmnt -Po PROPAGATION /))
if [[ ${PROPAGATION} == private ]]; then
    wsl.exe -u root -e mount --make-rshared /
fi

# podman
export XDG_RUNTIME_DIR=/tmp/$USER-runtime
if [[ ! -d "$XDG_RUNTIME_DIR" ]]
then
	mkdir -m 0700 "$XDG_RUNTIME_DIR"
fi

