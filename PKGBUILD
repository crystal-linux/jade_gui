# Maintainer: Matt C <matt[at]getcryst[dot]al>
pkgname=jade-gui
pkgver=1.0.0
pkgrel=1
pkgdesc="Flutter GUI for installing crystal"
arch=('any')
url="https://git.tar.black/crystal/programs/jade_gui"
makedepends=('flutter-group-pacman-hook' 'flutter' 'cmake' 'ninja' 'clang')
depends=('jade')
source=("gui::git+${url}.git")
sha256sums=('SKIP')

build() {
    cd ${srcdir}/gui
	flutter config --enable-linux-desktop
    flutter build linux
}

package() {
   mkdir -p ${pkgdir}/usr/{bin,lib}
   cp ${srcdir}/gui/build/linux/x64/release/bundle/jade_gui ${pkgdir}/usr/bin/. 
   cp ${srcdir}/gui/build/linux/x64/release/bundle/lib/* ${pkgdir}/usr/lib/.
}
