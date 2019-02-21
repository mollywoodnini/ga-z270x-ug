#!/bin/bash
# just in case the device is not ready
# if errors no big deal because its ready
liquidctl initialize
# set fans to generous speed in 5 steps
liquidctl set fan speed  20 25  32 40  42 52  52 70  60 100
# set pump speed to range in 2 steps
liquidctl set pump speed 20 60 60 100
# set lights
liquidctl set logo color fixed ffffff
liquidctl set ring color fixed ffffff
