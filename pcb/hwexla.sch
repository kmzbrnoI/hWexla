EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 4
Title "hWexla - turnout controller"
Date "2021-12-02"
Rev "1.0"
Comp "Model Railroader Club Brno I – KMŽ Brno I – https://kmz-brno.cz/"
Comment1 "Jan Horáček"
Comment2 "https://github.com/kmzbrnoI/hwexla"
Comment3 "https://creativecommons.org/licenses/by-sa/4.0/"
Comment4 "Released under the Creative Commons Attribution-ShareAlike 4.0 License"
$EndDescr
$Comp
L Connector:DB25_Male J1
U 1 1 61A8E3F4
P 1000 3550
F 0 "J1" H 918 2058 50  0000 C CNN
F 1 "DB25_Male" H 918 2149 50  0000 C CNN
F 2 "" H 1000 3550 50  0001 C CNN
F 3 " ~" H 1000 3550 50  0001 C CNN
	1    1000 3550
	-1   0    0    1   
$EndComp
$Comp
L MCU_Microchip_ATtiny:ATtiny1617-M U2
U 1 1 61A924E6
P 9450 3450
F 0 "U2" H 9450 4731 50  0000 C CNN
F 1 "ATtiny1617-M" H 9450 4640 50  0000 C CNN
F 2 "Package_DFN_QFN:QFN-24-1EP_4x4mm_P0.5mm_EP2.6x2.6mm" H 9450 3450 50  0001 C CIN
F 3 "http://ww1.microchip.com/downloads/en/DeviceDoc/ATtiny3217_1617-Data-Sheet-40001999B.pdf" H 9450 3450 50  0001 C CNN
	1    9450 3450
	1    0    0    -1  
$EndComp
$Sheet
S 2900 2300 1500 500 
U 61AA5240
F0 "power" 50
F1 "power.sch" 50
F2 "SERVO-POWER-EN" I R 4400 2400 50 
F3 "SERVO-VCC" O R 4400 2550 50 
F4 "+12V" I L 2900 2400 50 
F5 "VCC" O R 4400 2700 50 
$EndSheet
$Sheet
S 2900 3550 1500 900 
U 61AA542B
F0 "io" 50
F1 "io.sch" 50
F2 "CAN-BTN+" B L 2900 3850 50 
F3 "CAN-BTN-" B L 2900 4050 50 
F4 "CAN-IN+" I L 2900 3650 50 
F5 "CAN-IN-" I L 2900 3750 50 
F6 "CAN-OUT+" O L 2900 4250 50 
F7 "CAN-OUT-" O L 2900 4350 50 
F8 "CPU-IN+" O R 4400 3650 50 
F9 "CPU-IN-" O R 4400 3750 50 
F10 "CPU-BTN+-OUT" I R 4400 3950 50 
F11 "CPU-BTN+-IN" O R 4400 3850 50 
F12 "CPU-BTN--OUT" I R 4400 4150 50 
F13 "CPU-BTN--IN" O R 4400 4050 50 
F14 "CPU-OUT+" I R 4400 4250 50 
F15 "CPU-OUT-" I R 4400 4350 50 
$EndSheet
$Sheet
S 2900 4800 1500 850 
U 61AA561A
F0 "relay" 50
F1 "relay.sch" 50
$EndSheet
$EndSCHEMATC
