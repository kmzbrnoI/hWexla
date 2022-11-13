#!/usr/bin/env python3
# run with unbuffered output: ‹python3 -u read.py /dev/ttyACM0›

import serial
import sys
import datetime
import select


assert len(sys.argv) >= 2

ser = serial.Serial(port=sys.argv[1], baudrate=38400)

# Wait until beginning of browser (special terminal sequence 'move n lines above')
byte = ser.read(1)
while byte != b'\x1B':
    byte = ser.read(1)

ser.read(4) # read rest of the special sequence

while True:
    line = ser.readline()
    if line.startswith(b'\x1B'):
        special, line = line[:5], line[5:]
        print(special.decode('ascii'), end='')
    print(f'[{datetime.datetime.now().time()}]', end=' ')
    print(line.decode('ascii'), end='')
