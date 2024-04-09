#!/usr/bin/env bash

# -------- check exe --------
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
		&& sudo apt update \
		&& sudo apt install gh -y
fi
check_exe python3


# -------- run --------
echo "Log in gh with 'msi' token..."
gh auth login

echo "Cloning necassary repos..."
gh repo
