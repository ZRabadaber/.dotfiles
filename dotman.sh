#!/usr/bin/env bash

init_check() {
	# Check wether its a first time use or not
	if [[ -z ${DOT_REPO} && -z ${DOT_DEST} ]]; then
	    # show first time setup menu
		initial_setup
	else
		pull_repo
	    # manage
	fi
}

initial_setup() {
	echo -e "\nFirst time use, Set Up dotman"
	echo -e "...................................."
	DOT_DEST=$(pwd)
	DOT_REPO=`git remote get-url origin`
  echo -e "DOT_REPO=${DOT_REPO}"
  echo -e "DOT_DEST=${DOT_DEST}"
	#add_env "$DOT_REPO" "$DOT_DEST"
	setup "$DOT_DEST"
	echo -e "\ndotman successfully configured"
}

pull_repo() {
	echo -e "\nPull repo"
	echo -e "...................................."
	git -C ${DOT_DEST} pull ${DOT_REPO}
}

add_env() {
	# export environment variables
	echo -e "\nExporting env variables DOT_DEST & DOT_REPO ..."

	current_shell=$(basename "$SHELL")
	if [[ $current_shell == "zsh" ]]; then
		echo "export DOT_REPO=$1" >> "$HOME"/.zshrc
		echo "export DOT_DEST=$2" >> "$HOME"/.zshrc
	elif [[ $current_shell == "bash" ]]; then
		# assume we have a fallback to bash
		echo "export DOT_REPO=$1" >> "$HOME"/.bashrc
		echo "export DOT_DEST=$2" >> "$HOME"/.bashrc
	else
		echo "Couldn't export DOT_REPO and DOT_DEST."
		echo "Consider exporting them manually".
		exit 1
	fi
	echo -e "Configuration for SHELL: $current_shell has been updated."
}

setup() {
	echo -e "\nSetup ..."
  echo -e "DOT_DEST=$1"

	sudo apt install -y `cat $1/software/pkgs`

	for it in $(cat $1/software/snap)
	do
		snap install $it
	done

	sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
  
	ln -s -T $1/zshrc $HOME/.zshrc
	 
	ln -s -T $1/fonts $HOME/.fonts
	fc-cache -f -v

	for item in $1/config/*
	do
		ln -s -T $item $HOME/.config/$(basename $item)
	done
	
	for file in $1/rules.d/*
	do
		sudo ln -s -T $file /etc/udev/rules.d/$(basename $file)
	done
	sudo udevadm control --reload
	sudo udevadm trigger
}

init_check

