# Maintainer: Matt C <matt[at]getcryst[dot]al>
pkgname=jade-gui
pkgver=1.0.0
pkgrel=1
pkgdesc="Flutter GUI for installing crystal"
arch=('any')
url="https://git.tar.black/crystal/programs/jade_gui"
makedepends=('flutter-group-pacman-hook' 'flutter')
depends=('jade')
source=("git+${url}.git")

build() {
    cd ${srcdir}/jade_gui
    flutter build linux
}

package() {
   mkdir -p ${pkgdir}/usr/bin
   cp ${srcdir}/jade_gui/build/linux/x64/release/bundle/jade_gui ${pkgdir}/usr/bin/. 
}
