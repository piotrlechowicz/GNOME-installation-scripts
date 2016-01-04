#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd $DIR
cd ../
source script-header.sh
cd $DIR

set -o errexit

install_package "python-pip"
install_package "python-dev"
install_package "qt-sdk"
install_package "qt5-default"

# install pyqt ------
# install sip
if [ -z $(which sip) ]; then
	cd /tmp/
	mkdir -p sip
	cd sip
	wget http://netix.dl.sourceforge.net/project/pyqt/sip/sip-4.17/sip-4.17.tar.gz
	tar -zxvf sip-4.17.tar.gz
	cd sip-4.17
	python configure.py
	make
	make install
fi

# install pyqt5
has_python_module "PyQt5"
if [ ! "$?" -eq 0 ]; then 
	cd /tmp/
	mkdir -p pyqt5
	cd pyqt5
	wget http://netcologne.dl.sourceforge.net/project/pyqt/PyQt5/PyQt-5.5.1/PyQt-gpl-5.5.1.tar.gz
	tar -zxvf PyQt-gpl-5.5.1.tar.gz
	cd PyQt-gpl-5.5.1/
	python ./configure.py
	make
	make install
fi

