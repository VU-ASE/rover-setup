# Makefile in accordance with the docs on git management (to use in combination with meta)
.PHONY: build start clean test


deps:
	@ansible-galaxy install fubarhouse.golang


#
# You can specify run arguments with runargs, like this:
# make runargs="--tags local"
#
all: deps
	ansible-playbook main.yaml --ask-pass -K ${runargs}



