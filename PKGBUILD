# Maintainer: Dancheg97 <dancheg97@fmnx.ru>

pkgname=fmnx-install
pkgver="0.7.1"
pkgrel="0.7.1"
pkgdesc="UI wrapper over archinstall written in dart."
arch=("x86_64")
url="https://fmnx.ru/dancheg97/fmnx-install"
options=(!lto)
license=("GPL3")
depends=(
  "archinstall"
  "networkmanager"
)
optdepends=(
  "sudo: privilege elevation"
  "doas: privilege elevation"
)
makedepends=(
  "flutter"
  "clang"
  "cmake"
)
source=(
  "fmnx-install-v${pkgver}.tar.gz::${url}/archive/v${pkgver}.tar.gz"
  "fmnx-install.desktop"
  "fmnx-install.sh"
)
sha1sums=(
  "SKIP"
  "SKIP"
  "SKIP"
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
  install -Dm755 "${srcdir}/fmnx-install.desktop" "${pkgdir}/usr/share/applications/fmnx-install.desktop"

  # # Install icon
  install -Dm644 "data/flutter_assets/assets/installer.png" "${pkgdir}/usr/share/icons/hicolor/512x512/apps/fmnx-install.png"
}
