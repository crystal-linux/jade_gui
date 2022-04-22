#!/usr/bin/env bash
reflector --latest 5 --sort rate --save /etc/pacman.d/mirrorlist
jade config /tmp/jade.json