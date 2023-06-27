
gitadd:
	git remote add github https://github.com/fmnx-su/ainst
	git remote add codeberg https://codeberg.org/fmnx/ainst

push:
	git push
	git push github
	git push codeberg

.PHONY: build
build:
	sh update.sh

.PHONY: test
test:
	flutter build linux
	sudo ./build/linux/x64/release/bundle/ainst
