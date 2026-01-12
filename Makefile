# Makefile in accordance with the docs on git management (to use in combination with meta)
.PHONY: build start clean test


#
# You can specify run arguments with runargs, like this:
# make runargs="--tags local"
#
all: deps
	ansible-playbook main.yaml --ask-pass -K ${runargs}


# Currently not used, because necessary binary blobs are in ./kernel/built_blobs
# check-kernel:
# 	@if [ ! -d "./kernel/linux-kernel-6.1.22" ]; then echo "Error: please run sudo ./kernel/cross-compile-kernel.sh to build the kernel, then re-run the command"; exit 1; fi

deps:
	@ansible-galaxy install gantsign.golang

ping:
	ansible fleet -m ping --ask-pass