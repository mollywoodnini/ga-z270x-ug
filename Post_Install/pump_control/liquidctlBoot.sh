#!/bin/bash
# just in case the device is not ready
# if errors no big deal because its ready
liquidctl initialize
# set fans to aggressive speed in 5 steps
liquidctl set fan speed  25 25  32 52  42 60  52 70  58 100
# set pump speed to range in 2 steps
liquidctl set pump speed 25 65 58 100
# set lights
liquidctl set logo color fixed ffffff
liquidctl set ring color fixed ffffff
