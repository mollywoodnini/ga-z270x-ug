#!/bin/bash
# just in case the device is not ready
liquidctl initialize
# set fans to quiet mode
liquidctl set fan speed  20 30  30 50  34 80  40 90  50 100
# set pump speed higher from default 60
liquidctl set pump speed 80
# set lights
liquidctl set logo color breathing 9600ff
liquidctl set ring color water-cooler