#!/bin/bash

function install_package {
	package_name="$1"
	if [ $(dpkg --get-selections $package_name 2>/dev/null | grep -c "install") -eq "0" ]; then 
		echo "not installed";
	else
		echo "package $package_name installed"
	fi
}
