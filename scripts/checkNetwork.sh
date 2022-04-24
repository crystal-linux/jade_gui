#!/usr/bin/env bash
ping -c3 getcryst.al -q > /dev/null
if [[ $? -eq 0 ]]; then
	echo "connected"
else
	echo "disconnected"
fi
