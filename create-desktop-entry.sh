#!/bin/bash

filename="example.desktop"
name="Example"
execution_path=""
terminal_enabled=false
icon_path=""
categories="Application;"
install_to_dash=false

function usage {
	echo "usage: ./create-desktop-entry.sh
-f --file 					filename
-n --name					name
-x --execution-path			path to execute
-t --terminal				should it be run from terminal
-i --icon					path to the icon file
-c --categories				categories of an application
-d --dash					install to dash
-h --help

Example usage: 
./create-desktop-entry.sh -f file -n FileName -x ~/exec.sh -i ~/MyIcon.png -c "Application;" -t -d
"
}

function create_file {
	cd ~/Desktop
	touch "$filename"
	chmod +x "$filename"
	
	cat > $filename <<EOF
[Desktop Entry]
Version=1.0
Name=$name
Exec=$execution_path
Terminal=$terminal_enabled
Icon=$icon_path
Type=Application
Categories=$categories
EOF

	if [ install_to_dash ]; then
		to_dash
	fi
}

function to_dash {
	cd ~/Desktop
	desktop-file-install $filename
}


while [ "$1" != "" ]; do
	case $1 in
		-f | --file ) 			shift
								filename="$1"".desktop"
								;;
		-n | --name )			shift
								name=$1
								;;
		-x | --execution-path )	shift
								execution_path=$1
								;;
		-t | --terminal )		
								terminal_enabled=true
								;;
		-i | --icon )			shift
								icon_path=$1
								;;
		-c | --categories )		shift
								categories=$1
								;;
		-d | --dash )			
								install_to_dash=true
								;;
		-h | --help )			usage
								exit
								;;
		* )						usage
								exit 1
	esac
	shift
done

create_file
