#!/bin/bash
(( EUID != 0 )) && exec sudo -- "$0" "$@"
# Repair kext permissions
chmod -Rf 755 /S*/L*/E*
chmod -Rf 755 /L*/E*
chown -Rf 0:0 /S*/L*/E*
chown -Rf 0:0 /L*/E*