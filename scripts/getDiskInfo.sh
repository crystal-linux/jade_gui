#!/usr/bin/bash
lsblk -pdo SIZE $1 | grep -v SIZE
