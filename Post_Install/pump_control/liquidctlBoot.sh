#!/bin/bash
# just in case the device is not ready
# if errors no big deal because its ready
liquidctl initialize
# set fans to generous speed in 5 steps
liquidctl set fan speed  20 25  32 38  40 50  52 70  62 100
# set pump speed to range in 2 steps
liquidctl set pump speed 20 60 62 100
# set lights
liquidctl set logo color breathing ffffff
liquidctl set ring color water-cooler
