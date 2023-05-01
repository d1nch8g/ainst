# Maintainer: Dancheg97 <dancheg97@fmnx.ru>

pkgname=fmnx-install
pkgver="0.29"
pkgrel="1"
pkgdesc="UI wrapper over archinstall written in dart."
arch=("x86_64")
url="https://fmnx.io/dev/fmnx-install"
options=(!lto)
makedepends=(
  "flutter"
  "clang"
  "cmake"
)

package() {
  cd "${srcdir}/fmnx-install"

  flutter build linux

  cd build/linux/x64/release/bundle

  # # Install app resources
  find . -type f -exec install -Dm755 {} "${pkgdir}/usr/share/fmnx-install/{}" \;

  # # Install bin
  install -Dm755 "${srcdir}/fmnx-install.sh" "${pkgdir}/usr/bin/fmnx-install"

  # # Install desktop
  install -Dm755 "${srcdir}/installer.desktop" "${pkgdir}/usr/share/applications/installer.desktop"

  # # Install icon
  install -Dm644 "data/flutter_assets/assets/installer.png" "${pkgdir}/usr/share/icons/hicolor/512x512/apps/fmnx-install.png"
}
