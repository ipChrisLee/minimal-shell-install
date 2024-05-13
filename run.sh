#!/usr/bin/env bash

set -e

# ------------ configs ------------
if [ -f "msi-config.sh" ]; then
	source "msi-config.sh"
fi
config_not_found_prompt() {
	echo "MSI [INFO]: config \$$1 not found in msi-config.sh, using default configs, see run.sh for details."
}
if [ -z "$nvimTreesitterLangs" ]; then
	config_not_found_prompt nvimTreesitterLangs
	export nvimTreesitterLangs="bash,diff,lua,markdown,python,yaml"
fi
if [ -z "$noHostPrompt" ]; then
	config_not_found_prompt noHostPrompt 
	export noHostPrompt="y"
fi
export ipleeConfHash="linux-msi-port"
export ipleeExeHash="master"

# ------------ install nessasary packages ------------
if ! (which sudo > /dev/null 2>&1); then
	apt-get update
	apt-get install sudo -y
else
	sudo apt-get update
fi
sudo apt-get install curl git wget sed -y

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

# ------------ gh clone and setup ------------
echo "Log in gh with 'msi' token..."
gh auth login --with-token

gitconfigStr="\
[credential \"https://github.com\"]
	helper = !/usr/bin/env gh auth git-credential
[credential \"https://gist.github.com\"]
	helper = !/usr/bin/env gh auth git-credential
"

echo "$gitconfigStr" > ${HOME}/.gitconfig

echo "Cloning necassary repos..."
cd ${HOME}; gh repo clone .iplee-conf; gh repo clone .iplee-exe

# ---- .iplee-conf
cd ${HOME}/.iplee-conf
git fetch origin
git checkout "${ipleeConfHash}"
self-conf/configure-omz.sh
. self-conf/configure-hconf.sh
# self-conf/configure-ssh-include-conf.sh
self-conf/install-nvim-from-archive.sh
. self-conf/configure-nvim.sh # . is for using env vars in this script.

# ---- .iplee-exe
cd ${HOME}/.iplee-exe
git fetch origin
git checkout "${ipleeExeHash}"
self-install/install-oog-key-interactive.sh
