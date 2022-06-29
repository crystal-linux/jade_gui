<p align="center">
  <a href="https://github.com/crystal-linux/todo/">
    <img src="https://github.com/crystal-linux/branding/blob/main/logos/crystal-logo-minimal.png?raw=true" alt="Logo" width="150" height="150">
  </a>
</p>

<h2 align="center">Jade</h2>

<p align="center">
    <a href="https://discord.gg/yp4xpZeAgW"><img alt="Discord" src="https://img.shields.io/discord/825473796227858482?color=blue&label=Discord&logo=Discord&logoColor=white"?link=https://discord.gg/yp4xpZeAgW&link=https://discord.gg/yp4xpZeAgW> </a>
    <img href="https://stopthemingmy.app" src="https://stopthemingmy.app/badge.svg" alt="Please don't theme this app">
</p>

<p align="center"> The libadwaita/gtk based gui installer using jade as the backend
</p>

[The jade gui mockups](https://github.com/crystal-linux/demos-mockups/blob/main/preview.pdf)

![](main-page-screenshot.png)


### Building
__NOTE: the jade gui libadwaita rewrite is not complete and CAN'T install a crystal system yet__

using gnome-builder to build and run this currently doesn't work as jade_gui requires python-pytz which gnome-builder doesn't provide when building

dependencies:
- python-pytz
- python-gobject


first you have to clone this repo and change the branch:
```sh
git clone https://github.com/crystal-linux/jade_gui/
cd jade_gui
git checkout libadwaita-rewrite
```
then you can simply run
```sh
./build.sh build # to just build it
./build.sh install # to install a previous build
./build.sh install-build # to build and install it
```
