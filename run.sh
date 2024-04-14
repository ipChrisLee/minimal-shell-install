#!/usr/bin/env bash

set -e

# ------------ configs ------------
export ipleeConfHash="linux-msi-port"
export ipleeExeHash="master"

# ------------ install nessasary packages ------------
if ! (which sudo > /dev/null 2>&1); then
	apt-get update
	apt-get install sudo -y
else
	sudo apt-get update
fi
sudo apt-get install curl git wget python3 build-essential -y

# ------------ check/install exe ------------
function check_exe {
	if (which "$1" > /dev/null 2>&1); then
		echo "Found $1"
		return 0
	else
		echo "Not found $1"
		return 1
	fi
}

if ! (check_exe gh); then
	sudo mkdir -p -m 755 /etc/apt/keyrings && wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
		&& sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
		&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
		&& sudo apt-get update \
		&& sudo apt-get install gh -y
fi

if ! (check_exe zsh); then
	sudo apt-get install zsh -y
fi

if [ ! -d "${HOME}/.oh-my-zsh" ]; then
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended
fi

# ------------ run ------------
echo "Log in gh with 'msi' token..."
gh auth login --with-token

echo "Cloning necassary repos..."
cd ${HOME}; gh repo clone .iplee-conf; gh repo clone .iplee-exe

# ---- .iplee-conf
cd ${HOME}/.iplee-conf
git checkout "${ipleeConfHash}"
self-conf/configure-omz.sh
self-conf/configure-hconf.sh
# self-conf/configure-ssh-include-conf.sh
self-conf/install-nvim.sh
self-conf/configure-nvim.sh

# ---- .iplee-exe
cd ${HOME}/.iplee-exe
git checkout "${ipleeExeHash}"
rm key/oog-proxy.sh
self-install/install-oog-key-interactive.sh
