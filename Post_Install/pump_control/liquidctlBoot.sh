#!/bin/bash
# just in case the device is not ready
liquidctl initialize
# set fans to quiet mode
liquidctl set fan speed  20 25  32 38  40 50  52 70  65 100
# set pump speed higher from default 60
liquidctl set pump speed 80
# set lights
liquidctl set logo color breathing ffffff
liquidctl set ring color water-cooler
