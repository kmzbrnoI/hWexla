#!/usr/bin/env python3

"""
Communication with hWexla over UART

Usage:
  manage.py [options] <port>
  manage.py resetterminal
  manage.py -h | --help
  manage.py --version

Options:
  -h --help         Show this screen.
  --version         Show version.
  -c --no-clear     Do not clear view after each arriving packet.
  -r --raw          Show raw data.

By default, this application does 2 things:
1. It reads hWexla's diagnostic stream and prints human-readable stream to stdout.
2. It reads stdin and sends pressed keys to hWexla.
"""

import serial
import sys
import datetime
from collections import OrderedDict
from typing import List
import select
import termios
import docopt

SW_VERSION = '1.0'
DATA_SIZE = 32

BEGIN1 = 0xBE
BEGIN2 = 0xEF


def str_fail_code(code: int) -> str:
    match code:
        case 0: return 'fNoFail'
        case 1: return 'fBadISR'
        case 2: return 'fInitServoVCC'
        case 3: return 'fServoVCC'
        case 4: return 'fDiag'
        case 5: return 'fOscCalMissing'
        case _: return 'unknown'


def str_mode(code: int) -> str:
    match code:
        case 0: return 'mRun'
        case 1: return 'mProgramming'
        case 2: return 'mInitializing'
        case 3: return 'mFail'
        case 4: return 'mOverride'
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
        result |= (item << (8*i))
    return result


def parse(data) -> OrderedDict:
    d = OrderedDict()

    d['stream_version'] = str(data[0])
    d['fw'] = str(data[1]) + '.' + str(data[2])
    d['mode'] = str_mode(data[5])
    d['fail'] = str_fail_code(data[3])
    d['magnet_warn'] = bool(data[4])

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


def show(args, raw: List[int]):
    d = parse(raw)
    print('' if args['--no-clear'] else chr(27) + '[2J')  # clrscr or \n
    print(str(datetime.datetime.now().time()))
    if args['--raw']:
        print(humanify_buf(raw))

    for key, val in d.items():
        print(f'{key}: {val}')


def init_stdin():
    # get characters as typed (without waiting for newline), do not write them back to terminal
    mode = termios.tcgetattr(sys.stdin)
    mode[3] &= ~(termios.ECHO | termios.ICANON)
    termios.tcsetattr(sys.stdin, termios.TCSAFLUSH, mode)


def reset_stdin():
    mode = termios.tcgetattr(sys.stdin)
    mode[3] |= (termios.ECHO | termios.ICANON)
    termios.tcsetattr(sys.stdin, termios.TCSAFLUSH, mode)


def humanify_buf(data: List[int]) -> str:
    return ' '.join(['0x{:02x}'.format(byte) for byte in data])


def main():
    args = docopt.docopt(__doc__, version=SW_VERSION)
    if args['resetterminal'] or args['<port>'] == 'resetterminal':
        reset_stdin()
        sys.exit(0)

    ser = serial.Serial(port=args['<port>'], baudrate=38400)
    init_stdin()

    while selected := select.select([sys.stdin, ser], [], []):
        read, _, _ = selected
        if ser in read:
            read = ser.read(1)
            if read and read[0] == BEGIN1:
                read = ser.read(1)
                if read and read[0] == BEGIN2:
                    show(args, ser.read(DATA_SIZE))
        else:
            ser.write(sys.stdin.read(1).lower().encode('ascii'))


if __name__ == '__main__':
    main()
