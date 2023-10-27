#!/usr/bin/env python3
# run with unbuffered output: ‹python3 -u read.py /dev/ttyACM0›

import serial
import sys
import datetime
from collections import OrderedDict
from typing import List

DATA_SIZE = 31


def str_fail_code(code: int) -> str:
    match code:
        case 0: return 'fNoFail'
        case 1: return 'fBadISR'
        case 2: return 'fInitServoVCC'
        case 3: return 'fServoVCC'
        case _: return 'unknown'


def str_mode(code: int) -> str:
    match code:
        case 0: return 'mRun'
        case 1: return 'mProgramming'
        case 2: return 'mInitializing'
        case 3: return 'mFail'
        case _: return 'unknown'


def str_position(code: int) -> str:
    match code:
        case 0: return 'tpPlus'
        case 1: return 'tpMinus'
        case 2: return 'tpMovingToPlus'
        case 3: return 'tpMovingToMinus'
        case _: return 'unknown'


def parse_num(data: List[int]) -> int:
    result = 0
    for i, item in enumerate(data):
        result |= item << (8*i)
    return result


def parse(data) -> OrderedDict:
    d = OrderedDict()

    d['stream_version'] = str(data[0])
    d['fw'] = str(data[1]) + '.' + str(data[2])
    d['fail'] = str_fail_code(data[3])
    d['magnet_warn'] = bool(data[4])
    d['mode'] = str_mode(data[5])

    d['in+'] = bool(data[6] & 1)
    d['in-'] = bool((data[6] >> 1) & 1)
    d['in_btn+'] = bool((data[6] >> 2) & 1)
    d['in_btn-'] = bool((data[6] >> 3) & 1)
    d['in_btn'] = bool((data[6] >> 4) & 1)
    d['in_slave'] = bool((data[6] >> 5) & 1)

    d['out+'] = bool(data[7] & 1)
    d['out-'] = bool((data[7] >> 1) & 1)
    d['out_relay'] = bool((data[7] >> 2) & 1)
    d['out_power'] = bool((data[7] >> 3) & 1)

    d['turnout_pos'] = str_position(data[8])
    d['angle'] = parse_num(data[9:11])
    d['angle_plus'] = parse_num(data[11:13])
    d['angle_minus'] = parse_num(data[13:15])
    d['sensor_plus'] = parse_num(data[15:17])
    d['sensor_minus'] = parse_num(data[17:19])
    d['moved_plus'] = parse_num(data[19:23])
    d['moved_minus'] = parse_num(data[23:27])
    d['move_per_tick'] = str(data[27])
    d['mag_value'] = parse_num(data[28:30])
    d['servo_vcc_value'] = parse_num(data[30:32])

    return d


def show(d: OrderedDict):
    print(chr(27) + "[2J")  # clrscr
    print(str(datetime.datetime.now().time()))
    for key, val in d.items():
        print(f'{key}: {val}')


def main():
    if len(sys.argv) < 2:
        sys.stderr.write(f'Usage: {sys.argv[0]} port\n')
        sys.exit(1)

    ser = serial.Serial(port=sys.argv[1], baudrate=38400)

    while True:
        read = ser.read(1)
        if read[0] == 0xBE:
            read = ser.read()
            if read[0] == 0xEF:
                data = parse(ser.read(DATA_SIZE))
                show(data)


if __name__ == '__main__':
    main()
