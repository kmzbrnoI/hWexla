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
DATA_SIZE = 38

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
    d['mode'] = str_mode(data[7])

    d['FAIL'] = OrderedDict()
    fail = d['FAIL']
    fail['fail'] = str_fail_code(data[3])
    fail['fail_count'] = data[5]
    fail['last_fail'] = str_fail_code(data[6])

    d['WARNINGS'] = OrderedDict()
    warn = d['WARNINGS']
    warn['all'] = data[4]
    warn['magnet_warn'] = bool(data[4] >> 7)
    warn['servo_vcc_warn_low'] = bool((data[4]) & 1)
    warn['servo_vcc_warn_high'] = bool((data[4] >> 1) & 1)
    warn['wdg_reset'] = bool((data[4] >> 2) & 1)

    d['INPUTS'] = OrderedDict()
    inp = d['INPUTS']
    inp['in+'] = bool(data[8] & 1)
    inp['in-'] = bool((data[8] >> 1) & 1)
    inp['in_btn+'] = bool((data[8] >> 2) & 1)
    inp['in_btn-'] = bool((data[8] >> 3) & 1)
    inp['in_btn'] = bool((data[8] >> 4) & 1)
    inp['in_slave'] = bool((data[8] >> 5) & 1)

    d['OUTPUTS'] = OrderedDict()
    out = d['OUTPUTS']
    out['out+'] = bool(data[9] & 1)
    out['out-'] = bool((data[9] >> 1) & 1)
    out['out_relay'] = bool((data[9] >> 2) & 1)
    out['out_power'] = bool((data[9] >> 3) & 1)

    d['CORE'] = OrderedDict()
    core = d['CORE']
    core['turnout_pos'] = str_position(data[10])
    core['angle'] = parse_num(data[11:13])

    d['CONFIG'] = OrderedDict()
    config = d['CONFIG']
    config['angle_plus'] = parse_num(data[13:15])
    config['angle_minus'] = parse_num(data[15:17])
    config['sensor_plus'] = parse_num(data[17:19])
    config['sensor_minus'] = parse_num(data[19:21])
    config['move_per_tick'] = str(data[29])

    d['STAT'] = OrderedDict()
    stat = d['STAT']
    stat['moved_plus'] = parse_num(data[21:25])
    stat['moved_minus'] = parse_num(data[25:29])

    d['SENSORS'] = OrderedDict()
    sens = d['SENSORS']
    sens['mag_value'] = parse_num(data[30:32])
    sens['mag_voltage'] = round((sens['mag_value']/1024) * 5, 2)
    sens['servo_vcc_value'] = parse_num(data[32:34])
    sens['servo_vcc_voltage'] = round((sens['servo_vcc_value']/512) * 5, 2)
    sens['servo_vcc_recorded_min'] = parse_num(data[34:36])
    sens['servo_vcc_recorded_min_voltage'] = round((sens['servo_vcc_recorded_min']/512) * 5, 2)
    sens['servo_vcc_recorded_max'] = parse_num(data[36:38])
    sens['servo_vcc_recorded_max_voltage'] = round((sens['servo_vcc_recorded_max']/512) * 5, 2)

    return d


def print_dict(d, prefix: str) -> None:
    for key, val in d.items():
        if isinstance(val, dict):
            print(f'{prefix}{key}')
            print_dict(val, prefix+'| ')
        else:
            print(f'{prefix}{key}: {val}')


def show(args, raw: List[int]):
    d = parse(raw)
    print('' if args['--no-clear'] else chr(27) + '[2J')  # clrscr or \n
    print(str(datetime.datetime.now().time()))
    if args['--raw']:
        print(humanify_buf(raw))

    print_dict(d, '')


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
