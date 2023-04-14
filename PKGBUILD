# Maintainer: Dancheg97 <dangdancheg@gmail.com>

pkgname=gnome-archinstall
pkgver=1
pkgrel=1
pkgdesc="UI wrapper over archinstall written in dart."
arch=('i686' 'pentium4' 'x86_64' 'arm' 'armv7h' 'armv6h' 'aarch64')
url="https://dancheg97.ru/dancheg97/gnome-archinstall"
options=(!lto)
license=('GPL3')
depends=(
  'archinstall'
  'networkmanager'
)
optdepends=(
  'sudo: privilege elevation'
  'doas: privilege elevation'
)
makedepends=()
checks=("skip")

build() {
  git clone https://dancheg97.ru/dancheg97/gnome-archinstall
  cd gnome-archinstall
  make build
}

package() {
  cp -R $srcdir/gnome-archinstall/build/linux/x64/release/bundle/** $pkgdir/lib/installer
}
