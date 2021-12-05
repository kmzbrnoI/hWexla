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
P 1300 3450
F 0 "J1" H 1218 1958 50  0000 C CNN
F 1 "DB25_Male" H 1218 2049 50  0000 C CNN
F 2 "Connector_Dsub:DSUB-25_Male_EdgeMount_P2.77mm" H 1300 3450 50  0001 C CNN
F 3 " ~" H 1300 3450 50  0001 C CNN
	1    1300 3450
	-1   0    0    1   
$EndComp
$Sheet
S 2900 1300 1500 500 
U 61AA5240
F0 "power" 50
F1 "power.sch" 50
F2 "SERVO-POWER-EN" I R 4400 1400 50 
F3 "SERVO-VCC" O R 4400 1550 50 
F4 "+12V" I L 2900 1400 50 
F5 "VCC" O R 4400 1700 50 
$EndSheet
$Sheet
S 2900 3750 1500 1000
U 61AA561A
F0 "relay" 50
F1 "relay.sch" 50
F2 "RELA+" B L 2900 3850 50 
F3 "RELA0" B L 2900 4000 50 
F4 "RELA-" B L 2900 4150 50 
F5 "RELB+" B L 2900 4350 50 
F6 "RELB0" B L 2900 4500 50 
F7 "RELB-" B L 2900 4650 50 
F8 "REL-CONTROL" I R 4400 4250 50 
F9 "REL-POWER" I R 4400 3950 50 
$EndSheet
$Comp
L power:VCC #PWR0101
U 1 1 61CEF176
P 6450 1650
F 0 "#PWR0101" H 6450 1500 50  0001 C CNN
F 1 "VCC" H 6465 1823 50  0000 C CNN
F 2 "" H 6450 1650 50  0001 C CNN
F 3 "" H 6450 1650 50  0001 C CNN
	1    6450 1650
	-1   0    0    -1  
$EndComp
$Comp
L power:GND #PWR0102
U 1 1 61CEFE33
P 6450 3850
F 0 "#PWR0102" H 6450 3600 50  0001 C CNN
F 1 "GND" H 6455 3677 50  0000 C CNN
F 2 "" H 6450 3850 50  0001 C CNN
F 3 "" H 6450 3850 50  0001 C CNN
	1    6450 3850
	-1   0    0    -1  
$EndComp
Connection ~ 6450 1650
$Comp
L power:GND #PWR0103
U 1 1 61CF241F
P 7100 1950
F 0 "#PWR0103" H 7100 1700 50  0001 C CNN
F 1 "GND" H 7105 1777 50  0000 C CNN
F 2 "" H 7100 1950 50  0001 C CNN
F 3 "" H 7100 1950 50  0001 C CNN
	1    7100 1950
	-1   0    0    -1  
$EndComp
$Comp
L Device:R R8
U 1 1 61CF35F4
P 5750 1800
F 0 "R8" H 5820 1846 50  0000 L CNN
F 1 "10k" H 5820 1755 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 5680 1800 50  0001 C CNN
F 3 "~" H 5750 1800 50  0001 C CNN
	1    5750 1800
	-1   0    0    -1  
$EndComp
Wire Wire Line
	5850 1950 5750 1950
Wire Wire Line
	6450 1650 5750 1650
Wire Wire Line
	6450 1650 7100 1650
$Comp
L Device:C C11
U 1 1 61CF0CFB
P 7100 1800
F 0 "C11" H 6985 1754 50  0000 R CNN
F 1 "100n" H 6985 1845 50  0000 R CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder" H 7138 1650 50  0001 C CNN
F 3 "~" H 7100 1800 50  0001 C CNN
	1    7100 1800
	-1   0    0    1   
$EndComp
Text Label 2150 2250 0    50   ~ 0
IN+
Text Label 2150 2450 0    50   ~ 0
IN-
Text Label 2150 2650 0    50   ~ 0
SLAVE
Text Label 2150 2850 0    50   ~ 0
OUT+
Text Label 2150 3050 0    50   ~ 0
OUT-
Text Label 2150 3250 0    50   ~ 0
BTN+
Text Label 2150 3450 0    50   ~ 0
BTN-
$Sheet
S 2900 2150 1500 1400
U 61AA542B
F0 "io" 50
F1 "io.sch" 50
F2 "BTN+" B L 2900 3250 50 
F3 "BTN-" B L 2900 3450 50 
F4 "IN+" I L 2900 2250 50 
F5 "IN-" I L 2900 2450 50 
F6 "OUT+" O L 2900 2850 50 
F7 "OUT-" O L 2900 3050 50 
F8 "L-IN+" O R 4400 2250 50 
F9 "L-IN-" O R 4400 2450 50 
F10 "L-BTN+OUT" I R 4400 3250 50 
F11 "L-BTN+IN" O R 4400 3150 50 
F12 "L-BTN-OUT" I R 4400 3450 50 
F13 "L-BTN-IN" O R 4400 3350 50 
F14 "L-OUT+" I R 4400 2850 50 
F15 "L-OUT-" I R 4400 3050 50 
F16 "SLAVE" I L 2900 2650 50 
F17 "L-SLAVE" O R 4400 2650 50 
$EndSheet
Wire Wire Line
	1600 2250 2900 2250
Wire Wire Line
	1600 2450 2900 2450
Wire Wire Line
	2900 2650 1600 2650
Wire Wire Line
	1600 2850 2900 2850
Wire Wire Line
	2900 3050 1600 3050
Wire Wire Line
	1600 3250 2900 3250
Wire Wire Line
	2900 3450 1600 3450
Wire Wire Line
	1600 2350 1700 2350
Wire Wire Line
	1700 2350 1700 2550
Wire Wire Line
	1700 2550 1600 2550
$Comp
L power:GND #PWR0106
U 1 1 61D7962C
P 1700 2550
F 0 "#PWR0106" H 1700 2300 50  0001 C CNN
F 1 "GND" V 1705 2422 50  0000 R CNN
F 2 "" H 1700 2550 50  0001 C CNN
F 3 "" H 1700 2550 50  0001 C CNN
	1    1700 2550
	0    -1   -1   0   
$EndComp
Connection ~ 1700 2550
Wire Wire Line
	1600 2750 1700 2750
Wire Wire Line
	1700 2750 1700 2950
Wire Wire Line
	1700 2950 1600 2950
$Comp
L power:+12V #PWR0107
U 1 1 61D7DEBE
P 1700 2750
F 0 "#PWR0107" H 1700 2600 50  0001 C CNN
F 1 "+12V" V 1715 2878 50  0000 L CNN
F 2 "" H 1700 2750 50  0001 C CNN
F 3 "" H 1700 2750 50  0001 C CNN
	1    1700 2750
	0    1    1    0   
$EndComp
Connection ~ 1700 2750
NoConn ~ 1600 3150
$Comp
L power:VCC #PWR0108
U 1 1 61D85285
P 1900 3350
F 0 "#PWR0108" H 1900 3200 50  0001 C CNN
F 1 "VCC" V 1915 3478 50  0000 L CNN
F 2 "" H 1900 3350 50  0001 C CNN
F 3 "" H 1900 3350 50  0001 C CNN
	1    1900 3350
	0    1    1    0   
$EndComp
$Comp
L Device:Polyfuse F4
U 1 1 61D86674
P 1750 3350
F 0 "F4" V 1525 3350 50  0000 C CNN
F 1 "50mA" V 1616 3350 50  0000 C CNN
F 2 "Fuse:Fuse_1206_3216Metric_Pad1.42x1.75mm_HandSolder" H 1800 3150 50  0001 L CNN
F 3 "~" H 1750 3350 50  0001 C CNN
	1    1750 3350
	0    1    1    0   
$EndComp
Wire Wire Line
	1600 3650 1700 3650
Wire Wire Line
	1700 3650 1700 3850
Wire Wire Line
	1700 3850 1600 3850
Wire Wire Line
	1600 4050 1700 4050
Wire Wire Line
	1700 4050 1700 4250
Wire Wire Line
	1700 4250 1600 4250
Wire Wire Line
	1600 4450 1700 4450
Wire Wire Line
	1700 4450 1700 4650
Wire Wire Line
	1700 4650 1600 4650
Wire Wire Line
	1600 4550 1800 4550
Wire Wire Line
	1800 4550 1800 4350
Wire Wire Line
	1800 4350 1600 4350
Wire Wire Line
	1600 4150 1800 4150
Wire Wire Line
	1800 4150 1800 4000
Wire Wire Line
	1800 3950 1600 3950
Wire Wire Line
	1600 3750 1800 3750
Wire Wire Line
	1800 3750 1800 3550
Wire Wire Line
	1800 3550 1600 3550
Wire Wire Line
	2900 3850 2600 3850
Wire Wire Line
	2600 3850 2600 3750
Connection ~ 1800 3750
Wire Wire Line
	2900 4000 1800 4000
Connection ~ 1800 4000
Wire Wire Line
	1800 4000 1800 3950
Connection ~ 1800 4350
Wire Wire Line
	2500 3850 2500 4350
Connection ~ 1700 3850
Wire Wire Line
	2400 4250 2400 4500
Connection ~ 1700 4250
Wire Wire Line
	1700 4650 2900 4650
Connection ~ 1700 4650
Text Label 1900 3750 0    50   ~ 0
RELA+
Text Label 1900 3850 0    50   ~ 0
RELB+
Text Label 1900 4000 0    50   ~ 0
RELA0
Text Label 1900 4350 0    50   ~ 0
RELA-
Wire Wire Line
	1800 3750 2600 3750
Wire Wire Line
	2500 4350 2900 4350
Wire Wire Line
	1700 3850 2500 3850
Wire Wire Line
	2400 4500 2900 4500
Wire Wire Line
	1700 4250 2400 4250
Wire Wire Line
	2300 4350 2300 4150
Wire Wire Line
	1800 4350 2300 4350
Wire Wire Line
	2300 4150 2900 4150
Text Label 1900 4250 0    50   ~ 0
RELB0
Text Label 1900 4650 0    50   ~ 0
RELB-
$Comp
L power:+12V #PWR0109
U 1 1 61DBD5C3
P 2700 1300
F 0 "#PWR0109" H 2700 1150 50  0001 C CNN
F 1 "+12V" H 2715 1473 50  0000 C CNN
F 2 "" H 2700 1300 50  0001 C CNN
F 3 "" H 2700 1300 50  0001 C CNN
	1    2700 1300
	1    0    0    -1  
$EndComp
Wire Wire Line
	2700 1300 2700 1400
Wire Wire Line
	2700 1400 2900 1400
$Comp
L power:VCC #PWR0110
U 1 1 61DBF31C
P 4600 1300
F 0 "#PWR0110" H 4600 1150 50  0001 C CNN
F 1 "VCC" H 4615 1473 50  0000 C CNN
F 2 "" H 4600 1300 50  0001 C CNN
F 3 "" H 4600 1300 50  0001 C CNN
	1    4600 1300
	1    0    0    -1  
$EndComp
Wire Wire Line
	4600 1300 4600 1700
Wire Wire Line
	4600 1700 4400 1700
$Comp
L MCU_Microchip_ATtiny:ATtiny1617-M U2
U 1 1 61A924E6
P 6450 2750
F 0 "U2" H 6450 1250 50  0000 C CNN
F 1 "ATtiny1617-M" H 6450 1350 50  0000 C CNN
F 2 "Package_DFN_QFN:QFN-24-1EP_4x4mm_P0.5mm_EP2.6x2.6mm" H 6450 2750 50  0001 C CIN
F 3 "http://ww1.microchip.com/downloads/en/DeviceDoc/ATtiny3217_1617-Data-Sheet-40001999B.pdf" H 6450 2750 50  0001 C CNN
	1    6450 2750
	-1   0    0    -1  
$EndComp
Wire Wire Line
	4400 1550 4500 1550
Wire Wire Line
	5750 1950 5650 1950
Connection ~ 5750 1950
Wire Wire Line
	4950 2050 5850 2050
Text GLabel 5650 1950 0    50   Input ~ 0
RESET|UPDI
Wire Wire Line
	4800 1400 4400 1400
$Comp
L Switch:SW_Push SW1
U 1 1 61E31765
P 8150 4300
F 0 "SW1" V 8196 4252 50  0000 R CNN
F 1 "SW_Push" V 8105 4252 50  0000 R CNN
F 2 "" H 8150 4500 50  0001 C CNN
F 3 "~" H 8150 4500 50  0001 C CNN
	1    8150 4300
	0    1    -1   0   
$EndComp
$Comp
L Device:R R12
U 1 1 61E337A9
P 8150 3750
F 0 "R12" H 8220 3796 50  0000 L CNN
F 1 "10k" H 8220 3705 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 8080 3750 50  0001 C CNN
F 3 "~" H 8150 3750 50  0001 C CNN
	1    8150 3750
	-1   0    0    -1  
$EndComp
$Comp
L power:GND #PWR0111
U 1 1 61E35860
P 8150 4500
F 0 "#PWR0111" H 8150 4250 50  0001 C CNN
F 1 "GND" H 8155 4327 50  0000 C CNN
F 2 "" H 8150 4500 50  0001 C CNN
F 3 "" H 8150 4500 50  0001 C CNN
	1    8150 4500
	-1   0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0112
U 1 1 61E35E87
P 8150 3600
F 0 "#PWR0112" H 8150 3450 50  0001 C CNN
F 1 "VCC" H 8165 3773 50  0000 C CNN
F 2 "" H 8150 3600 50  0001 C CNN
F 3 "" H 8150 3600 50  0001 C CNN
	1    8150 3600
	-1   0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_01x03 J2
U 1 1 61E39FD1
P 9400 1250
F 0 "J2" H 9480 1292 50  0000 L CNN
F 1 "Conn_01x03" H 9480 1201 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x03_P2.54mm_Vertical" H 9400 1250 50  0001 C CNN
F 3 "~" H 9400 1250 50  0001 C CNN
	1    9400 1250
	1    0    0    -1  
$EndComp
Wire Wire Line
	7050 3150 7950 3150
Text Label 7150 3150 0    50   ~ 0
SERVO-PWM
$Comp
L power:GND #PWR0113
U 1 1 61E410D3
P 9100 1450
F 0 "#PWR0113" H 9100 1200 50  0001 C CNN
F 1 "GND" H 9105 1277 50  0000 C CNN
F 2 "" H 9100 1450 50  0001 C CNN
F 3 "" H 9100 1450 50  0001 C CNN
	1    9100 1450
	1    0    0    -1  
$EndComp
Wire Wire Line
	9100 1450 9100 1250
Wire Wire Line
	9100 1250 9200 1250
Connection ~ 4950 1550
Text Label 6250 850  0    50   ~ 0
SERVO-VCC
Wire Wire Line
	7950 1350 8250 1350
$Comp
L Device:R R6
U 1 1 61E3B085
P 8250 1100
F 0 "R6" H 8180 1054 50  0000 R CNN
F 1 "10k" H 8180 1145 50  0000 R CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 8180 1100 50  0001 C CNN
F 3 "~" H 8250 1100 50  0001 C CNN
	1    8250 1100
	1    0    0    1   
$EndComp
Wire Wire Line
	8850 1350 9200 1350
Wire Wire Line
	9100 850  9100 1150
Wire Wire Line
	9200 1150 9100 1150
$Comp
L Device:LED D6
U 1 1 61E8A0FF
P 8750 3750
F 0 "D6" V 8789 3632 50  0000 R CNN
F 1 "RED" V 8698 3632 50  0000 R CNN
F 2 "LED_SMD:LED_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 8750 3750 50  0001 C CNN
F 3 "~" H 8750 3750 50  0001 C CNN
	1    8750 3750
	0    -1   -1   0   
$EndComp
$Comp
L Device:LED D7
U 1 1 61E8A9DA
P 9250 3750
F 0 "D7" V 9289 3632 50  0000 R CNN
F 1 "YELLOW" V 9198 3632 50  0000 R CNN
F 2 "LED_SMD:LED_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 9250 3750 50  0001 C CNN
F 3 "~" H 9250 3750 50  0001 C CNN
	1    9250 3750
	0    -1   -1   0   
$EndComp
$Comp
L Device:LED D8
U 1 1 61E8B43F
P 9750 3750
F 0 "D8" V 9789 3632 50  0000 R CNN
F 1 "GREEN" V 9698 3632 50  0000 R CNN
F 2 "LED_SMD:LED_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 9750 3750 50  0001 C CNN
F 3 "~" H 9750 3750 50  0001 C CNN
	1    9750 3750
	0    -1   -1   0   
$EndComp
$Comp
L Device:R R9
U 1 1 61E8C4E2
P 8750 3300
F 0 "R9" H 8820 3346 50  0000 L CNN
F 1 "1k" H 8820 3255 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 8680 3300 50  0001 C CNN
F 3 "~" H 8750 3300 50  0001 C CNN
	1    8750 3300
	1    0    0    -1  
$EndComp
$Comp
L Device:R R10
U 1 1 61E8CD2E
P 9250 3300
F 0 "R10" H 9320 3346 50  0000 L CNN
F 1 "1k" H 9320 3255 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 9180 3300 50  0001 C CNN
F 3 "~" H 9250 3300 50  0001 C CNN
	1    9250 3300
	1    0    0    -1  
$EndComp
$Comp
L Device:R R11
U 1 1 61E8D444
P 9750 3300
F 0 "R11" H 9820 3346 50  0000 L CNN
F 1 "1k" H 9820 3255 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 9680 3300 50  0001 C CNN
F 3 "~" H 9750 3300 50  0001 C CNN
	1    9750 3300
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0114
U 1 1 61E8E2FA
P 8750 4100
F 0 "#PWR0114" H 8750 3850 50  0001 C CNN
F 1 "GND" H 8755 3927 50  0000 C CNN
F 2 "" H 8750 4100 50  0001 C CNN
F 3 "" H 8750 4100 50  0001 C CNN
	1    8750 4100
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0115
U 1 1 61E8E8CC
P 9250 4100
F 0 "#PWR0115" H 9250 3850 50  0001 C CNN
F 1 "GND" H 9255 3927 50  0000 C CNN
F 2 "" H 9250 4100 50  0001 C CNN
F 3 "" H 9250 4100 50  0001 C CNN
	1    9250 4100
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0116
U 1 1 61E8EE2C
P 9750 4100
F 0 "#PWR0116" H 9750 3850 50  0001 C CNN
F 1 "GND" H 9755 3927 50  0000 C CNN
F 2 "" H 9750 4100 50  0001 C CNN
F 3 "" H 9750 4100 50  0001 C CNN
	1    9750 4100
	1    0    0    -1  
$EndComp
Wire Wire Line
	8750 4100 8750 3900
Wire Wire Line
	8750 3600 8750 3450
Wire Wire Line
	9250 3450 9250 3600
Wire Wire Line
	9250 4100 9250 3900
Wire Wire Line
	9750 3900 9750 4100
Wire Wire Line
	9750 3600 9750 3450
Wire Wire Line
	7050 3050 8750 3050
Wire Wire Line
	8750 3050 8750 3150
Wire Wire Line
	7050 2950 9250 2950
Wire Wire Line
	9250 2950 9250 3150
Wire Wire Line
	7050 2850 9750 2850
Wire Wire Line
	9750 2850 9750 3150
Text Label 7150 2850 0    50   ~ 0
LED-GR
Text Label 7150 2950 0    50   ~ 0
LED-YEL
Text Label 7150 3050 0    50   ~ 0
LED-RED
$Comp
L Connector_Generic:Conn_01x06 J4
U 1 1 61EB90D4
P 9400 5200
F 0 "J4" H 9480 5192 50  0000 L CNN
F 1 "Conn_01x06" H 9480 5101 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x06_P2.54mm_Vertical" H 9400 5200 50  0001 C CNN
F 3 "~" H 9400 5200 50  0001 C CNN
	1    9400 5200
	1    0    0    -1  
$EndComp
NoConn ~ 9200 5000
Text GLabel 8300 5100 0    50   Input ~ 0
TxD
Text GLabel 8300 5200 0    50   Input ~ 0
RxD
$Comp
L Jumper:SolderJumper_2_Open JP2
U 1 1 61ECAD51
P 7900 5300
F 0 "JP2" H 7900 5100 50  0000 C CNN
F 1 "SolderJumper_2_Open" H 7900 5200 50  0000 C CNN
F 2 "Jumper:SolderJumper-2_P1.3mm_Open_RoundedPad1.0x1.5mm" H 7900 5300 50  0001 C CNN
F 3 "~" H 7900 5300 50  0001 C CNN
	1    7900 5300
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0117
U 1 1 61ED017E
P 7500 5150
F 0 "#PWR0117" H 7500 5000 50  0001 C CNN
F 1 "VCC" H 7515 5323 50  0000 C CNN
F 2 "" H 7500 5150 50  0001 C CNN
F 3 "" H 7500 5150 50  0001 C CNN
	1    7500 5150
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0118
U 1 1 61ED4EE0
P 9200 5600
F 0 "#PWR0118" H 9200 5350 50  0001 C CNN
F 1 "GND" H 9205 5427 50  0000 C CNN
F 2 "" H 9200 5600 50  0001 C CNN
F 3 "" H 9200 5600 50  0001 C CNN
	1    9200 5600
	1    0    0    -1  
$EndComp
NoConn ~ 9200 5400
$Comp
L Connector_Generic:Conn_01x03 J3
U 1 1 61EE3BFC
P 9400 2200
F 0 "J3" H 9480 2242 50  0000 L CNN
F 1 "Conn_01x03" H 9480 2151 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x03_P2.54mm_Vertical" H 9400 2200 50  0001 C CNN
F 3 "~" H 9400 2200 50  0001 C CNN
	1    9400 2200
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0119
U 1 1 61EE7E50
P 9100 2400
F 0 "#PWR0119" H 9100 2150 50  0001 C CNN
F 1 "GND" H 9105 2227 50  0000 C CNN
F 2 "" H 9100 2400 50  0001 C CNN
F 3 "" H 9100 2400 50  0001 C CNN
	1    9100 2400
	1    0    0    -1  
$EndComp
Wire Wire Line
	9100 2400 9100 2300
Wire Wire Line
	9100 2300 9200 2300
$Comp
L Jumper:SolderJumper_2_Open JP1
U 1 1 61EF6D73
P 8750 2100
F 0 "JP1" H 8750 2305 50  0000 C CNN
F 1 "SolderJumper_2_Open" H 8750 2214 50  0000 C CNN
F 2 "Jumper:SolderJumper-2_P1.3mm_Open_RoundedPad1.0x1.5mm" H 8750 2100 50  0001 C CNN
F 3 "~" H 8750 2100 50  0001 C CNN
	1    8750 2100
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0120
U 1 1 61EF81EA
P 8250 1950
F 0 "#PWR0120" H 8250 1800 50  0001 C CNN
F 1 "VCC" H 8265 2123 50  0000 C CNN
F 2 "" H 8250 1950 50  0001 C CNN
F 3 "" H 8250 1950 50  0001 C CNN
	1    8250 1950
	1    0    0    -1  
$EndComp
Wire Wire Line
	8250 1950 8250 2100
Wire Wire Line
	8250 2100 8600 2100
Wire Wire Line
	8900 2100 9200 2100
Text GLabel 8650 2200 0    50   Input ~ 0
RESET|UPDI
$Comp
L Sensor_Magnetic:A1101ELHL U4
U 1 1 61F15C9F
P 6450 5150
F 0 "U4" H 6200 5000 50  0000 R CNN
F 1 "RR112-1" H 6200 4900 50  0000 R CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 6450 4800 50  0001 L CIN
F 3 "http://www.allegromicro.com/en/Products/Part_Numbers/1101/1101.pdf" H 6450 5800 50  0001 C CNN
	1    6450 5150
	-1   0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0121
U 1 1 61F1951D
P 6550 4650
F 0 "#PWR0121" H 6550 4500 50  0001 C CNN
F 1 "VCC" H 6565 4823 50  0000 C CNN
F 2 "" H 6550 4650 50  0001 C CNN
F 3 "" H 6550 4650 50  0001 C CNN
	1    6550 4650
	-1   0    0    -1  
$EndComp
$Comp
L Device:C C12
U 1 1 61F1E81D
P 6900 4800
F 0 "C12" H 6786 4754 50  0000 R CNN
F 1 "1u" H 6786 4845 50  0000 R CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder" H 6938 4650 50  0001 C CNN
F 3 "~" H 6900 4800 50  0001 C CNN
	1    6900 4800
	-1   0    0    1   
$EndComp
$Comp
L power:GND #PWR0122
U 1 1 61F208C9
P 6900 4950
F 0 "#PWR0122" H 6900 4700 50  0001 C CNN
F 1 "GND" H 6905 4777 50  0000 C CNN
F 2 "" H 6900 4950 50  0001 C CNN
F 3 "" H 6900 4950 50  0001 C CNN
	1    6900 4950
	-1   0    0    -1  
$EndComp
Wire Wire Line
	6900 4650 6550 4650
Wire Wire Line
	6550 4650 6550 4750
Connection ~ 6550 4650
$Comp
L Device:R R13
U 1 1 61F31061
P 5900 5150
F 0 "R13" V 5693 5150 50  0000 C CNN
F 1 "47k" V 5784 5150 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 5830 5150 50  0001 C CNN
F 3 "~" H 5900 5150 50  0001 C CNN
	1    5900 5150
	0    -1   1    0   
$EndComp
Wire Wire Line
	6050 5150 6150 5150
$Comp
L Device:C C13
U 1 1 61F35765
P 5550 5300
F 0 "C13" H 5665 5346 50  0000 L CNN
F 1 "100p" H 5665 5255 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder" H 5588 5150 50  0001 C CNN
F 3 "~" H 5550 5300 50  0001 C CNN
	1    5550 5300
	-1   0    0    -1  
$EndComp
$Comp
L power:GND #PWR0123
U 1 1 61F361D6
P 5550 5450
F 0 "#PWR0123" H 5550 5200 50  0001 C CNN
F 1 "GND" H 5555 5277 50  0000 C CNN
F 2 "" H 5550 5450 50  0001 C CNN
F 3 "" H 5550 5450 50  0001 C CNN
	1    5550 5450
	-1   0    0    -1  
$EndComp
Wire Wire Line
	5550 5150 5750 5150
Wire Wire Line
	7500 5150 7500 5300
Wire Wire Line
	5550 5150 5550 5000
Connection ~ 5550 5150
Text GLabel 5550 5000 1    50   Input ~ 0
MAG-SENSE
$Comp
L power:GND #PWR0124
U 1 1 61F6D146
P 6550 5550
F 0 "#PWR0124" H 6550 5300 50  0001 C CNN
F 1 "GND" H 6555 5377 50  0000 C CNN
F 2 "" H 6550 5550 50  0001 C CNN
F 3 "" H 6550 5550 50  0001 C CNN
	1    6550 5550
	1    0    0    -1  
$EndComp
Wire Wire Line
	8150 3900 8150 4050
Wire Wire Line
	7050 3350 7600 3350
Wire Wire Line
	7600 3350 7600 4050
Wire Wire Line
	7600 4050 8150 4050
Connection ~ 8150 4050
Wire Wire Line
	8150 4050 8150 4100
Text Label 7150 3350 0    50   ~ 0
BTN
NoConn ~ 7050 3250
Wire Wire Line
	5850 2250 4800 2250
Wire Wire Line
	5850 2150 5650 2150
Text GLabel 5650 2150 0    50   Input ~ 0
MAG-SENSE
$Comp
L Device:R R7
U 1 1 61FE79E8
P 8700 1350
F 0 "R7" V 8493 1350 50  0000 C CNN
F 1 "1k" V 8584 1350 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 8630 1350 50  0001 C CNN
F 3 "~" H 8700 1350 50  0001 C CNN
	1    8700 1350
	0    1    1    0   
$EndComp
Wire Wire Line
	8250 1250 8250 1350
Wire Wire Line
	8250 950  8250 850 
Connection ~ 8250 850 
Wire Wire Line
	8250 850  4950 850 
Wire Wire Line
	8250 850  9100 850 
Wire Wire Line
	8550 1350 8250 1350
Connection ~ 8250 1350
$Comp
L power:GND #PWR0125
U 1 1 6200F7A1
P 8600 5800
F 0 "#PWR0125" H 8600 5550 50  0001 C CNN
F 1 "GND" H 8605 5627 50  0000 C CNN
F 2 "" H 8600 5800 50  0001 C CNN
F 3 "" H 8600 5800 50  0001 C CNN
	1    8600 5800
	1    0    0    -1  
$EndComp
Wire Wire Line
	7500 5300 7750 5300
Wire Wire Line
	8600 5500 8600 5200
Wire Wire Line
	8600 5200 9200 5200
Wire Wire Line
	8050 5300 9200 5300
$Comp
L Diode:BZX84Cxx D10
U 1 1 620413B7
P 8600 5650
F 0 "D10" V 8550 5850 50  0000 R CNN
F 1 "BZX84C5V1" V 8650 6150 50  0000 R CNN
F 2 "Diode_SMD:D_SOT-23_ANK" H 8600 5475 50  0001 C CNN
F 3 "https://diotec.com/tl_files/diotec/files/pdf/datasheets/bzx84c2v4.pdf" H 8600 5650 50  0001 C CNN
	1    8600 5650
	0    1    1    0   
$EndComp
Wire Wire Line
	9200 5500 9200 5600
$Comp
L Diode:BZX84Cxx D9
U 1 1 620661CE
P 8400 5650
F 0 "D9" V 8350 5450 50  0000 L CNN
F 1 "BZX84C5V1" V 8450 5150 50  0000 L CNN
F 2 "Diode_SMD:D_SOT-23_ANK" H 8400 5475 50  0001 C CNN
F 3 "https://diotec.com/tl_files/diotec/files/pdf/datasheets/bzx84c2v4.pdf" H 8400 5650 50  0001 C CNN
	1    8400 5650
	0    1    1    0   
$EndComp
Wire Wire Line
	8400 5500 8400 5100
Wire Wire Line
	8400 5100 9200 5100
$Comp
L power:GND #PWR0126
U 1 1 6206C78F
P 8400 5800
F 0 "#PWR0126" H 8400 5550 50  0001 C CNN
F 1 "GND" H 8405 5627 50  0000 C CNN
F 2 "" H 8400 5800 50  0001 C CNN
F 3 "" H 8400 5800 50  0001 C CNN
	1    8400 5800
	1    0    0    -1  
$EndComp
Wire Wire Line
	8300 5200 8600 5200
Connection ~ 8600 5200
Wire Wire Line
	8400 5100 8300 5100
Connection ~ 8400 5100
$Comp
L Diode:BZX84Cxx D5
U 1 1 6208D699
P 8850 2350
F 0 "D5" V 8800 2150 50  0000 L CNN
F 1 "BZX84C30" V 8900 1850 50  0000 L CNN
F 2 "Diode_SMD:D_SOT-23_ANK" H 8850 2175 50  0001 C CNN
F 3 "https://diotec.com/tl_files/diotec/files/pdf/datasheets/bzx84c2v4.pdf" H 8850 2350 50  0001 C CNN
	1    8850 2350
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR0127
U 1 1 62094F9C
P 8850 2500
F 0 "#PWR0127" H 8850 2250 50  0001 C CNN
F 1 "GND" H 8855 2327 50  0000 C CNN
F 2 "" H 8850 2500 50  0001 C CNN
F 3 "" H 8850 2500 50  0001 C CNN
	1    8850 2500
	1    0    0    -1  
$EndComp
Wire Wire Line
	8850 2200 9200 2200
Wire Wire Line
	8650 2200 8850 2200
Connection ~ 8850 2200
Wire Wire Line
	7950 1350 7950 3150
Wire Wire Line
	4850 2650 4850 2550
Wire Wire Line
	4950 2850 4950 2650
Text GLabel 5500 3150 0    50   Input ~ 0
RxD
Text GLabel 5500 3050 0    50   Input ~ 0
TxD
Wire Wire Line
	5150 2950 5850 2950
Wire Wire Line
	4950 2650 5850 2650
Wire Wire Line
	5500 3150 5850 3150
Wire Wire Line
	5500 3050 5850 3050
Wire Wire Line
	4950 850  4950 1550
Wire Wire Line
	5050 2850 5050 3050
Wire Wire Line
	5150 2950 5150 3150
Wire Wire Line
	4850 2550 5850 2550
Wire Wire Line
	5050 2850 5850 2850
Wire Wire Line
	4800 1400 4800 2250
Wire Wire Line
	4950 1550 4950 2050
Wire Wire Line
	4700 2250 4700 2350
Wire Wire Line
	4700 2350 5850 2350
Wire Wire Line
	4400 4250 5200 4250
Wire Wire Line
	5200 4250 5200 3550
Wire Wire Line
	5200 3550 5850 3550
$Comp
L power:PWR_FLAG #FLG0102
U 1 1 62334011
P 1700 2950
F 0 "#FLG0102" H 1700 3025 50  0001 C CNN
F 1 "PWR_FLAG" V 1700 3078 50  0000 L CNN
F 2 "" H 1700 2950 50  0001 C CNN
F 3 "~" H 1700 2950 50  0001 C CNN
	1    1700 2950
	0    1    1    0   
$EndComp
Connection ~ 1700 2950
$Comp
L power:PWR_FLAG #FLG0103
U 1 1 62338445
P 1700 2350
F 0 "#FLG0103" H 1700 2425 50  0001 C CNN
F 1 "PWR_FLAG" V 1700 2478 50  0000 L CNN
F 2 "" H 1700 2350 50  0001 C CNN
F 3 "~" H 1700 2350 50  0001 C CNN
	1    1700 2350
	0    1    1    0   
$EndComp
Connection ~ 1700 2350
Wire Wire Line
	4400 2250 4700 2250
Wire Wire Line
	4400 2450 5850 2450
Wire Wire Line
	4400 2650 4850 2650
Wire Wire Line
	4400 2850 4950 2850
Wire Wire Line
	4400 3050 5050 3050
Wire Wire Line
	4400 3150 5150 3150
Wire Wire Line
	4400 3250 5850 3250
Wire Wire Line
	4400 3350 5850 3350
Wire Wire Line
	4400 3450 5850 3450
Wire Wire Line
	4500 1550 4500 3950
Wire Wire Line
	4500 3950 4400 3950
Connection ~ 4500 1550
Wire Wire Line
	4500 1550 4950 1550
$EndSCHEMATC
