# Maintainer: Dancheg97 <dancheg97@fmnx.ru>

pkgname=fmnx-install
pkgver="0.1"
pkgrel="0.1"
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
  "6635c6b09bfc9ca5e45839c02db8afe59ddc80c8"
  "2b70889e272f65bc70f0e68007f2a92a80294e1d"
  "6a52eafaa1a580e08f09c9b6c616f978471c0b6e"
)

package() {
  cd "${srcdir}/fmnx-install-${pkgver}"

  flutter build linux

  # # Install app resources
  # find . -type f -exec install -Dm644 {} "${pkgdir}/usr/share/ymp/{}" \;

  # # Install bin
  # install -Dm755 "${srcdir}/ymp.sh" "${pkgdir}/usr/bin/ymp"

  # # Install desktop
  # install -Dm755 "${srcdir}/ymp.desktop" "${pkgdir}/usr/share/applications/ymp.desktop"

  # # Install icon
  # install -Dm644 "assets/icons/main_icon.png" "${pkgdir}/usr/share/icons/hicolor/128x128/apps/ymp.png"

}
