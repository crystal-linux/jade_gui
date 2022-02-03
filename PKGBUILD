# Maintainer: Matt C <matt[at]getcryst[dot]al>
pkgname=jade_gui
pkgver=1.0.1
pkgrel=1
pkgdesc="Flutter GUI for installing crystal"
arch=('any')
url="https://git.tar.black/crystal/programs/jade_gui"
depends=('gtk3' 'jade')
makedepends=('clang' 'ninja' 'cmake' 'git' 'unzip' 'flutter' 'flutter-group-pacman-hook')

source=("gui::git+${url}.git")
sha256sums=('SKIP')

build() {
    cd ${srcdir}/gui
    flutter config --enable-linux-desktop
    flutter config --no-analytics
    flutter clean
    flutter pub get
    flutter build linux --release --verbose
}

package() {
    install -dm755 ${pkgdir}/opt
    mv ${srcdir}/gui/build/linux/x64/release/bundle ${pkgdir}/opt/jade_gui

    install -dm755 ${pkgdir}/usr/bin
    ln -s /opt/jade_gui/jade_gui ${pkgdir}/usr/bin/jade_gui

}
