#!/bin/bash

# Automated approach to uninstall the redcan service
#	1. Stop the redcan service
#	2. Disable the redcan service
#	3. Remove service file and binary
#	4. Reload daemon and reset all units with failed status

echo "Starting Redcan uninstallation..."

# Get user input y/n
echo "Do you wish to proceed? y/n"
read confirmation

# Check Redcan installation status
# If service file exists then:
if [ -e /etc/systemd/system/redcan.service ]
then
	# If binary file exists then:
	if [ -e /usr/bin/tam-hw ]
	then
		installed="true"
	else
		installed="false"
	fi
fi

# If "y" then:
if [ "$confirmation" == "y" ]
then	
	# If "installed" == "true"
	if [ "$installed" == "true" ]
	then
		echo "Stopping service."
		systemctl stop redcan

		echo "Disabling service."
		systemctl disable redcan

		echo "Removing service files."
		rm /etc/systemd/system/redcan.service
		rm /usr/bin/tam-hw

		echo "Resetting services."
		systemctl daemon-reload
		systemctl reset-failed
	
		echo "Redcan uninstallation complete."
	# Else, service is not installed; quit
	else
		echo "Redcan is not installed, exiting."
		exit
	fi
# If "n" then:
elif [ "$confirmation" == "n" ]
then
	echo "Uninstallation aborted."
# If not "y" or "n", input is invalid then:
else
	echo "Input invalid, exiting."
fi

