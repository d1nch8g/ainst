.PHONY: pkg
pkg:
	sudo rm -rf src
	sudo rm -rf pkg
	rm -f gnome-archinstall-1-1-x86_64.pkg.tar.zst
	makepkg -s

.PHONY: build
build:
	flutter build linux

.PHONY: test
test:
	flutter build linux
	sudo ./build/linux/x64/release/bundle/installer
