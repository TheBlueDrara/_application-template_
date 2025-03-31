#!/usr/bin/env bash 
###################################### Start Safe Header ######################################################
#Developed by Alex Umansky aka TheBlueDrara
#Porpuse: to check if neccery tools are installed, and if not install them
#Date: 21.03.2025
set -o nounset
set -o exiterr
set -o pipefail
###################################### End Safe header #######################################################
source tool_list.txt
source /etc/os-release

if [[ $ID_LIKE == "*debian*" ]]; then
	echo "Running on Debian-family distro. Executing main code..."
else
	echo "This script is designed to run only on Debian-family distory only!"
	exit 1
fi

function main(){
	for index in ${TOOLS[@]}; do
		check_and_install "$index"
	done
}

function check_and_install(){
	package=$1
	if ! dpkg -l | grep -q "^ii $package "; then
		sudo apt-get install "$package" -y
		return 1
	else
		return 0
	fi
}

main
