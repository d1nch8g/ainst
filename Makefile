
gitadd:
	git remote add github https://github.com/fmnx-su/ainst
	git remote add codeberg https://codeberg.org/fmnx/ainst

push:
	git push
	git push github
	git push codeberg

prepare:
	sudo pacman -Syu --noconfirm cmake clang
	cp ainst.yml ${HOME}/ainst.yml	
