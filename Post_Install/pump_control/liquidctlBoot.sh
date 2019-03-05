#!/bin/bash
# just in case the device is not ready
# if errors no big deal because its ready
liquidctl initialize
# set fans in 7 steps
liquidctl set fan speed 25 35  30 45  35 60  40 70  45 80  50 90  60 100
# set pump in 7 steps
liquidctl set pump speed 25 60  30 65  35 70  40 80  45 90  50 90  60 100
# set lights
liquidctl set logo color fixed ffffff
liquidctl set ring color fixed ffffff
