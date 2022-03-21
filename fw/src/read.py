#!/usr/bin/env python3
# run with unbuffered output: ‹python3 -u read.py /dev/ttyACM0›

import serial
import sys
import datetime


assert len(sys.argv) >= 2

ser = serial.Serial(port=sys.argv[1], baudrate=19200)

while True:
    chars = ser.read(1)
    if not chars:
        continue
    print(chr(chars[0]), end='')
