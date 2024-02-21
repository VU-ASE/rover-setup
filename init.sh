#!/bin/bash

debug() {
	echo "🟡 $1"
}

success() {
	echo "✅ $1"
}

error() {
	echo ; echo "❌ $1" ; echo ; exit 1
}


if [ -n "$(command -v dnf)" ] ; then
	debug "Detected a Redhat based system"
	PACKAGE_MANAGER="dnf"
elif [ -n "$(command -v apt-get)" ] ; then
	debug "Detected a Debian based system"
	PACKAGE_MANAGER="apt"
else
	error "Couldn't find dnf or apt package managers"
fi


debug "Updating..."
sudo $PACKAGE_MANAGER update -y


debug "Upgrading..."
sudo $PACKAGE_MANAGER upgrade -y


debug "Installing common packages..."
sudo $PACKAGE_MANAGER install python3-pip vim cmake -y


debug "Install ansible via pip..."
python3 -m pip install --user ansible psutil


debug "Upgrading ansible via pip..."
python3 -m pip install --upgrade --user ansible


debug "Installing ansible collections..."
ansible-galaxy collection install -f community.general

debug "Installing custom roles"
ansible-galaxy install fubarhouse.golang --ignore-errors


debug "Starting Playbook..."
ansible-playbook main.yaml -K

make install

success "Done"

