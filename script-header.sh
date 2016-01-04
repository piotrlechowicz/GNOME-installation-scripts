#!/bin/bash

# check if it is run as sudo
if [[ $(id -u) -ne 0 ]]; then
    echo "Please run as root"
    exit 1
fi

# function to install packages if not installed
function install_package {
	package_name="$1"
	if [ $(dpkg --get-selections $package_name 2>/dev/null | grep -c "install") -eq "0" ]; then 
		echo "not installed";
	else
		echo "package $package_name installed"
	fi
}
