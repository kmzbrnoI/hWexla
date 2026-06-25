#!/usr/bin/env python3

import sys
import subprocess

EEPROM_ADDR_POS_PLUS = 0x20
EEPROM_ADDR_POS_MINUS = 0x22
EEPROM_POS_BYTES = 2

def main() -> None:
    if len(sys.argv) < 2:
        sys.stderr.write(f'Usage: {sys.argv[0]} hwexla-programmer-device\n')
        sys.exit(1)

    device = sys.argv[1]
    avrdude_header = [
        'avrdude',
        '-p', 'atmega8',
        '-P', device,
        '-c', 'stk500',
    ]

    print('Erasing device flash...')
    subprocess.run(avrdude_header + ['-e'])

    print('Reading EEPROM...')
    subprocess.run(avrdude_header + ['-U', 'eeprom:r:eeprom_read.bin'])

    with open('eeprom_read.bin', 'rb') as eeprom_file:
        eeprom_content = bytearray(eeprom_file.read())

    pos_plus = (eeprom_content[EEPROM_ADDR_POS_PLUS]) | (eeprom_content[EEPROM_ADDR_POS_PLUS+1] << 8)
    pos_minus = (eeprom_content[EEPROM_ADDR_POS_MINUS]) | (eeprom_content[EEPROM_ADDR_POS_MINUS+1] << 8)
    print(f'old_pos_plus={pos_plus}')
    print(f'old_pos_minus={pos_minus}')
    pos_plus += 250
    pos_minus += 250
    print(f'new_pos_plus={pos_plus}')
    print(f'ne_pos_minus={pos_minus}')

    eeprom_content[EEPROM_ADDR_POS_PLUS] = (pos_plus & 0xFF)
    eeprom_content[EEPROM_ADDR_POS_PLUS+1] = ((pos_plus>>8) & 0xFF)
    eeprom_content[EEPROM_ADDR_POS_MINUS] = (pos_minus & 0xFF)
    eeprom_content[EEPROM_ADDR_POS_MINUS+1] = ((pos_minus>>8) & 0xFF)

    with open('eeprom_write.bin', 'wb') as eeprom_file:
        eeprom_file.write(eeprom_content)

    print('Writing new EEPROM...')
    subprocess.run(avrdude_header + ['-U', 'eeprom:w:eeprom_write.bin'])


if __name__ == '__main__':
    main()
