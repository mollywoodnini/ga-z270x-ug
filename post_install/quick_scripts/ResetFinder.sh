#!/bin/bash
(( EUID != 0 )) && exec sudo -- "$0" "$@"
# Reset Finder
killall Finder
rm -rf ~/Library/Caches/com.apple.finder/*
rm ~/Library/Preferences/com.apple.finder.*
