
.PHONY: package
package:
	mkdir -p src
	mkdir -p pkg
	cp -R build/linux/x64/release/bundle/** src
	makepkg -s

.PHONY: build
build:
	flutter build linux

.PHONY: test
test:
	flutter build linux
	sudo ./build/linux/x64/release/bundle/installer
