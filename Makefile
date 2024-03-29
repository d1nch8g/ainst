
gitadd:
	git remote add github https://github.com/fmnx-su/ainst
	git remote add codeberg https://codeberg.org/fmnx/ainst

push:
	git push
	git push github
	git push codeberg
	pack -Bqs
	pack -P fmnx.su/core/ainst

prepare:
	sudo pacman -Syu --noconfirm cmake clang
	cp ainst.yml ${HOME}/ainst.yml
	cp ainst.md ${HOME}/ainst.md
