hWexla – Switch motor
=====================

hWexla is a switch motor designed in [Model Railroader Club Brno I](https://kmz-brno.cz/)
to switch their turnouts. The project is opensource & openhardware, this repository
contains all data.

## Features

* Model 9g servo used as a drive force.
* Magnetic detection of movement. No mechanical parts detecting servo movement.
* Installation via unified D-SUB 25 connector.
* 2 inputs for position setting.
* 2 outputs for position indication (up to 200 mA).
* 2 IO pins for debug/panel.
* 2×3 relay for switching track current (up to 3 A).
* Diagnostic interface.
* IO protection.
* Slave mode.
* Input voltage: 10–20 V.
* Stabilizing of servo-voltage is solved in external board – hWexla contains
  only connector. Stepdowns like [RB0005](https://github.com/RoboticsBrno/RB0005-UniversalStepDown)
  are expected to be used.

## Parts

1. [PCB](pcb)
2. [Firmware](fw)
3. [WEXLACON PCB](wexlacon)
4. [Diagnostic PCB](diagpcb)

## [Requirements](requirements.md)

In czech only

## Authors

hWexla was designed in [Model Railroaders Club
Brno](https://www.kmz-brno.cz/) by [Jan Horáček](mailto:jan.horacek@kmz-brno.cz).
