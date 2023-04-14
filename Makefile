.PHONY: pkg
pkg:
	sudo rm -r src
	sudo rm -r pkg
	makepkg -s

.PHONY: build
build:
	flutter build linux

.PHONY: test
test:
	flutter build linux
	sudo ./build/linux/x64/release/bundle/installer
