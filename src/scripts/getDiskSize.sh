#!/usr/bin/bash
flatpak-spawn --host lsblk -pdo SIZE $1 | grep -v SIZE