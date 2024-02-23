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

run() {
	$1 || error "failed command: $1"
}


debug "Password will be prompted later, so don't go away!"
sleep 1


cd /home/debix || error "unable to enter /home/debix directory"

if [ -n "$(command -v dnf)" ] ; then
	debug "Detected a Redhat based system"
	PACKAGE_MANAGER="dnf"
elif [ -n "$(command -v apt-get)" ] ; then
	debug "Detected a Debian based system"
	PACKAGE_MANAGER="apt"
else
	error "Couldn't find dnf or apt package managers"
fi

export PATH=$PATH:/home/debix/.local/bin

debug "Updating..."
run "sudo $PACKAGE_MANAGER update -y"

debug "Upgrading..."
run "sudo $PACKAGE_MANAGER upgrade -y"

debug "Installing common packages..."
run "sudo $PACKAGE_MANAGER install python3-pip git -y"

if [ -d "/home/debix/rover-setup/" ]; then
	run "cd /home/debix/rover-setup"
	run "git switch main"
	run "git pull"
else
	debug "Clone VU-ASE/rover-setup"
	run "git clone https://github.com/VU-ASE/rover-setup.git"
	run "cd /home/debix/rover-setup"
fi

debug "Install ansible via pip..."
run "python3 -m pip install --user ansible psutil"

debug "Upgrading ansible via pip..."
run "python3 -m pip install --upgrade --user ansible"

debug "Installing ansible collections..."
run "ansible-galaxy collection install -f community.general"

debug "Installing custom roles"
run "ansible-galaxy install fubarhouse.golang --ignore-errors"

debug "Starting Playbook... password needed!"
run "ansible-playbook main.yaml -K"

# run "cd gocv-prebuilt && make install"


success "Success! Head to https://docs.ase.vu.nl for more info"
