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
		apt-get install $package_name
	else
		echo "package $package_name already installed"
	fi
}

# check if there is python module installed
# it returns 0 if module is not installed
function has_python_module {
	module="$1"
	python <<END
import sys
try:
    print "checking if python module $module is installed"
    import $module
except ImportError:
    sys.exit(1)
print "$module is installed"
END
	return $?
}
