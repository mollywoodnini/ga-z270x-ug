#!/bin/bash
(( EUID != 0 )) && exec sudo -- "$0" "$@"
# Reset Finder
killall Finder
rm -rf /Users/chase/Library/Caches/com.apple.finder/*
rm /Users/chase/Library/Preferences/com.apple.finder.plist
