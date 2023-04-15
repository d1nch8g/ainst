
.PHONY: build
build:
	sh update.sh

.PHONY: test
test:
	flutter build linux
	sudo ./build/linux/x64/release/bundle/installer
