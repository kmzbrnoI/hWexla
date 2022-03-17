# hWexla firmware

## Build & requirements

This firmware is developed in C language, compiled via `avr-gcc` with help
of `make`. You may also find tools like `avrdude` helpful.

Hex files are available in *Releases* section.

## Programming

Firmware could be programmed directly to board via ISP programming connector.

Flash main application & fuses:

```bash
$ make
$ make fuses
$ make program
```

## Author's toolkit

Text editor + `make`. No more, no less.

## License

This application is released under the [Apache License v2.0
](https://www.apache.org/licenses/LICENSE-2.0).
