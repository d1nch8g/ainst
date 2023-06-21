# Maintainer: Danila Fominykh <dancheg97@fmnx.su>

pkgname="ainst"
pkgdesc="Graphical system installation utility configurable in runtime"
pkgver="0.2"
pkgrel="1"
arch=('x86_64')
url="https://fmnx.su/core/ainst"
makedepends=(
  # "flutter"
  "gtk3"
  "ninja"
  "clang"
  "cmake"
)

build() {
  cd ..
  flutter build linux
}

package() {
  cd ..
  install -Dm755 ainst.sh $pkgdir/usr/bin/ainst
  install -Dm755 ainst.desktop $pkgdir/usr/share/applications/ainst.desktop
  install -Dm755 assets/ainst.png $pkgdir/usr/share/icons/hicolor/512x512/apps/ainst.png
  cd build/linux/x64/release/bundle && find . -type f -exec install -Dm755 {} $pkgdir/usr/share/ainst/{} \; && cd $srcdir/..
}
