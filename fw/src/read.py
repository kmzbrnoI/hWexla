#!/usr/bin/env python3
# run with unbuffered output: ‹python3 -u read.py /dev/ttyACM0›

import serial
import sys
import datetime


assert len(sys.argv) >= 2

ser = serial.Serial(port=sys.argv[1], baudrate=38400)

while True:
    line = ser.readline()
    print(f'[{datetime.datetime.now().time()}]', end=' ')
    print(line.decode('utf-8'), end='')
