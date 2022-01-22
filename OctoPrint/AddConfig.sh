#!/bin/bash
#
#
# This script will attempt to copy the Controls YAML file into your OctoPrint main configuration.  It should only be run ONCE, and not again if successful.
#
# First, install the CustomControl module inside OctoPrint or go to https://github.com/Salandora/octoprint-customControl and do a manual install.
#
# Next log into your OctoPrint directory and run this:
#
# wget https://raw.githubusercontent.com/Pontiac76/3DPrinting/main/OctoPrint/AddConfig.sh -O AddConfig.sh; chmod +x AddConfig.sh
#
# This will download THIS FILE you're reading.
#
# Next, execute the AddConfig.sh script by running
# 
# ./AddConfig.sh
#
# The script will backup your existing OctoPrint config (Assuming it lives in ~/.octoprint ) with the current date and time and 
# then append the contents of this file to your config.
#
# If you need to revert, go into ~/.octoprint and copy the oldest (or whatever version) of 

if [ -f ~/.octoprint/AddedCustomControls.txt ];
then
  echo "It appears that this config has already been applied.  Aborting before serious damage happens to your configuration file."
  exit 2
 fi
 
if [ -f /tmp/CustomControl.yaml ];
then
  echo "Removing possible stale file"
  rm -v /tmp/CustomControl.yaml
fi

echo "Downloading Yaml file"
wget "https://raw.githubusercontent.com/Pontiac76/3DPrinting/main/OctoPrint/CustomControl.yaml" -O /tmp/CustomControl.yaml

if [ ! -f /tmp/CustomControl.yaml ];
then
  echo "Something went wrong with the download.  Aborting."
  exit 1
fi

echo "Backing up exiting configuration file"
cp -v ~/.octoprint/config.yaml ~/.octoprint/config.yaml.`date +%Y-%m-%d-%H-%M-%S`

## Add a blank space 'just in case'.  Shouldn't hurt anything.
echo "" >> ~/.octoprint/config.yaml
cat /tmp/CustomControl.yaml >> ~/.octoprint/config.yaml

## Should be done!
echo "Installation complete!"
