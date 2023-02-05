#!/bin/sh

set -e

if [ -z "$1" ]
then
	echo "ERROR: Provide a ref to clone"
	exit 1
fi

# Clone
if [ -d 'Marlin' ]
then
	rm -rf 'Marlin'
fi
git clone --depth=1 --branch=$1 https://github.com/MarlinFirmware/Marlin.git

# Patch config
ln -fs $(pwd)/config/examples/Creality/Ender-3\ Pro/BigTreeTech\ SKR\ Mini\ E3\ 2.0/Configuration*.h Marlin/Marlin/

# Patch platform.ini
patch --no-backup-if-mismatch Marlin/platformio.ini 0001_set_default_envs.patch
