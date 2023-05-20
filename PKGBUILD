# PKGBUILD generated by pack.
# More info at: https://fmnx.su/core/pack

pkgname="ainst"
pkgdesc="⚙️ System installation utility configurable in runtime"
pkgver=`git describe --tags`
pkgrel="1"
arch=('x86_64')
url="https://fmnx.su/core/ainst"

# Edit build dependencies
makedepends=(
  "fmnx.su/pkg/flutter"
  "gtk3"
  "ninja"
  "clang"
  "cmake"
)

build() {
  cd ..
  sudo flutter build linux
}

package() {
  cd ..
  install -Dm755 ainst.sh $pkgdir/usr/bin/ainst
  install -Dm755 ainst.desktop $pkgdir/usr/share/applications/ainst.desktop
  install -Dm755 assets/ainst.png $pkgdir/usr/share/icons/hicolor/512x512/apps/ainst.png
  cd build/linux/x64/release/bundle && find . -type f -exec install -Dm755 {} $pkgdir/usr/share/ainst/{} \; && cd $srcdir/..
}
