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
L power:VCC #PWR01
U 1 1 61CEF176
P 7900 900
F 0 "#PWR01" H 7900 750 50  0001 C CNN
F 1 "VCC" H 7915 1073 50  0000 C CNN
F 2 "" H 7900 900 50  0001 C CNN
F 3 "" H 7900 900 50  0001 C CNN
	1    7900 900 
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR04
U 1 1 61CF241F
P 8750 1350
F 0 "#PWR04" H 8750 1100 50  0001 C CNN
F 1 "GND" H 8755 1177 50  0000 C CNN
F 2 "" H 8750 1350 50  0001 C CNN
F 3 "" H 8750 1350 50  0001 C CNN
	1    8750 1350
	1    0    0    -1  
$EndComp
$Comp
L Device:C C1
U 1 1 61CF0CFB
P 8750 1200
F 0 "C1" H 8635 1154 50  0000 R CNN
F 1 "100n" H 8635 1245 50  0000 R CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder" H 8788 1050 50  0001 C CNN
F 3 "~" H 8750 1200 50  0001 C CNN
F 4 "C49678" H 8750 1200 50  0001 C CNN "LCSC"
	1    8750 1200
	-1   0    0    1   
$EndComp
Text Label 2150 2450 0    50   ~ 0
IN+
Text Label 2150 2250 0    50   ~ 0
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
F4 "IN+" I L 2900 2450 50 
F5 "IN-" I L 2900 2250 50 
F6 "OUT+" O L 2900 2850 50 
F7 "OUT-" O L 2900 3050 50 
F8 "L-IN+" O R 4400 2450 50 
F9 "L-IN-" O R 4400 2250 50 
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
L power:GND #PWR06
U 1 1 61D7962C
P 1700 2550
F 0 "#PWR06" H 1700 2300 50  0001 C CNN
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
L power:+12V #PWR07
U 1 1 61D7DEBE
P 1700 2750
F 0 "#PWR07" H 1700 2600 50  0001 C CNN
F 1 "+12V" V 1715 2878 50  0000 L CNN
F 2 "" H 1700 2750 50  0001 C CNN
F 3 "" H 1700 2750 50  0001 C CNN
	1    1700 2750
	0    1    1    0   
$EndComp
Connection ~ 1700 2750
NoConn ~ 1600 3150
$Comp
L power:VCC #PWR08
U 1 1 61D85285
P 1900 3350
F 0 "#PWR08" H 1900 3200 50  0001 C CNN
F 1 "VCC" V 1915 3478 50  0000 L CNN
F 2 "" H 1900 3350 50  0001 C CNN
F 3 "" H 1900 3350 50  0001 C CNN
	1    1900 3350
	0    1    1    0   
$EndComp
$Comp
L Device:Polyfuse F1
U 1 1 61D86674
P 1750 3350
F 0 "F1" V 1525 3350 50  0000 C CNN
F 1 "200mA/460mA" V 1616 3350 50  0000 C CNN
F 2 "Fuse:Fuse_1206_3216Metric_Pad1.42x1.75mm_HandSolder" H 1800 3150 50  0001 L CNN
F 3 "~" H 1750 3350 50  0001 C CNN
F 4 "C69680" H 1750 3350 50  0001 C CNN "LCSC"
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
Connection ~ 1700 3850
Wire Wire Line
	2200 4250 2200 4500
Connection ~ 1700 4250
Text Label 1900 3750 0    50   ~ 0
RELA+
Text Label 1900 4650 0    50   ~ 0
RELB+
Text Label 1900 4000 0    50   ~ 0
RELA0
Text Label 1900 4350 0    50   ~ 0
RELA-
Wire Wire Line
	1800 3750 2600 3750
Wire Wire Line
	1700 3850 2500 3850
Wire Wire Line
	1700 4250 2200 4250
Wire Wire Line
	2300 4350 2300 4150
Wire Wire Line
	1800 4350 2300 4350
Wire Wire Line
	2300 4150 2900 4150
Text Label 1900 4250 0    50   ~ 0
RELB0
Text Label 1900 3850 0    50   ~ 0
RELB-
$Comp
L power:+12V #PWR02
U 1 1 61DBD5C3
P 2700 1300
F 0 "#PWR02" H 2700 1150 50  0001 C CNN
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
L power:VCC #PWR03
U 1 1 61DBF31C
P 4600 1300
F 0 "#PWR03" H 4600 1150 50  0001 C CNN
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
L Switch:SW_Push SW1
U 1 1 61E31765
P 6850 5050
F 0 "SW1" V 6896 5002 50  0000 R CNN
F 1 "SW_Push" V 6805 5002 50  0000 R CNN
F 2 "Button_Switch_SMD:SW_Push_1P1T_NO_6x6mm_H9.5mm" H 6850 5250 50  0001 C CNN
F 3 "~" H 6850 5250 50  0001 C CNN
	1    6850 5050
	0    1    -1   0   
$EndComp
$Comp
L Device:R R6
U 1 1 61E337A9
P 6850 4500
F 0 "R6" H 6920 4546 50  0000 L CNN
F 1 "10k" H 6920 4455 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 6780 4500 50  0001 C CNN
F 3 "~" H 6850 4500 50  0001 C CNN
F 4 "C17414" H 6850 4500 50  0001 C CNN "LCSC"
	1    6850 4500
	-1   0    0    -1  
$EndComp
$Comp
L power:GND #PWR016
U 1 1 61E35860
P 6850 5250
F 0 "#PWR016" H 6850 5000 50  0001 C CNN
F 1 "GND" H 6855 5077 50  0000 C CNN
F 2 "" H 6850 5250 50  0001 C CNN
F 3 "" H 6850 5250 50  0001 C CNN
	1    6850 5250
	-1   0    0    -1  
$EndComp
$Comp
L power:VCC #PWR011
U 1 1 61E35E87
P 6850 4350
F 0 "#PWR011" H 6850 4200 50  0001 C CNN
F 1 "VCC" H 6865 4523 50  0000 C CNN
F 2 "" H 6850 4350 50  0001 C CNN
F 3 "" H 6850 4350 50  0001 C CNN
	1    6850 4350
	-1   0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_01x03 J2
U 1 1 61E39FD1
P 10350 3550
F 0 "J2" H 10430 3592 50  0000 L CNN
F 1 "Conn_01x03" H 10430 3501 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x03_P2.54mm_Vertical" H 10350 3550 50  0001 C CNN
F 3 "~" H 10350 3550 50  0001 C CNN
	1    10350 3550
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR09
U 1 1 61E410D3
P 10050 3750
F 0 "#PWR09" H 10050 3500 50  0001 C CNN
F 1 "GND" H 10055 3577 50  0000 C CNN
F 2 "" H 10050 3750 50  0001 C CNN
F 3 "" H 10050 3750 50  0001 C CNN
	1    10050 3750
	1    0    0    -1  
$EndComp
Wire Wire Line
	10050 3750 10050 3550
Wire Wire Line
	10050 3550 10150 3550
$Comp
L Device:R R1
U 1 1 61E3B085
P 9350 3450
F 0 "R1" H 9280 3404 50  0000 R CNN
F 1 "10k" H 9280 3495 50  0000 R CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 9280 3450 50  0001 C CNN
F 3 "~" H 9350 3450 50  0001 C CNN
F 4 "C17414" H 9350 3450 50  0001 C CNN "LCSC"
	1    9350 3450
	1    0    0    1   
$EndComp
Wire Wire Line
	9800 3650 10150 3650
Wire Wire Line
	10150 3450 10050 3450
$Comp
L Device:LED D3
U 1 1 61E8A0FF
P 6150 4700
F 0 "D3" V 6189 4582 50  0000 R CNN
F 1 "RED" V 6098 4582 50  0000 R CNN
F 2 "LED_SMD:LED_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 6150 4700 50  0001 C CNN
F 3 "~" H 6150 4700 50  0001 C CNN
F 4 "C84256" H 6150 4700 50  0001 C CNN "LCSC"
	1    6150 4700
	0    1    -1   0   
$EndComp
$Comp
L Device:LED D2
U 1 1 61E8A9DA
P 5750 4700
F 0 "D2" V 5789 4582 50  0000 R CNN
F 1 "YEL" V 5698 4582 50  0000 R CNN
F 2 "LED_SMD:LED_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 5750 4700 50  0001 C CNN
F 3 "~" H 5750 4700 50  0001 C CNN
F 4 "C2296" H 5750 4700 50  0001 C CNN "LCSC"
	1    5750 4700
	0    1    -1   0   
$EndComp
$Comp
L Device:LED D1
U 1 1 61E8B43F
P 5350 4700
F 0 "D1" V 5389 4582 50  0000 R CNN
F 1 "GR" V 5298 4582 50  0000 R CNN
F 2 "LED_SMD:LED_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 5350 4700 50  0001 C CNN
F 3 "~" H 5350 4700 50  0001 C CNN
F 4 "C2297" H 5350 4700 50  0001 C CNN "LCSC"
	1    5350 4700
	0    1    -1   0   
$EndComp
$Comp
L Device:R R5
U 1 1 61E8C4E2
P 6150 4250
F 0 "R5" H 6220 4296 50  0000 L CNN
F 1 "1k" H 6220 4205 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 6080 4250 50  0001 C CNN
F 3 "~" H 6150 4250 50  0001 C CNN
F 4 "C17513" H 6150 4250 50  0001 C CNN "LCSC"
	1    6150 4250
	-1   0    0    -1  
$EndComp
$Comp
L Device:R R4
U 1 1 61E8CD2E
P 5750 4250
F 0 "R4" H 5820 4296 50  0000 L CNN
F 1 "1k" H 5820 4205 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 5680 4250 50  0001 C CNN
F 3 "~" H 5750 4250 50  0001 C CNN
F 4 "C17513" H 5750 4250 50  0001 C CNN "LCSC"
	1    5750 4250
	-1   0    0    -1  
$EndComp
$Comp
L Device:R R3
U 1 1 61E8D444
P 5350 4250
F 0 "R3" H 5420 4296 50  0000 L CNN
F 1 "1k" H 5420 4205 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 5280 4250 50  0001 C CNN
F 3 "~" H 5350 4250 50  0001 C CNN
F 4 "C17513" H 5350 4250 50  0001 C CNN "LCSC"
	1    5350 4250
	-1   0    0    -1  
$EndComp
$Comp
L power:GND #PWR015
U 1 1 61E8E2FA
P 6150 5050
F 0 "#PWR015" H 6150 4800 50  0001 C CNN
F 1 "GND" H 6155 4877 50  0000 C CNN
F 2 "" H 6150 5050 50  0001 C CNN
F 3 "" H 6150 5050 50  0001 C CNN
	1    6150 5050
	-1   0    0    -1  
$EndComp
$Comp
L power:GND #PWR014
U 1 1 61E8E8CC
P 5750 5050
F 0 "#PWR014" H 5750 4800 50  0001 C CNN
F 1 "GND" H 5755 4877 50  0000 C CNN
F 2 "" H 5750 5050 50  0001 C CNN
F 3 "" H 5750 5050 50  0001 C CNN
	1    5750 5050
	-1   0    0    -1  
$EndComp
$Comp
L power:GND #PWR013
U 1 1 61E8EE2C
P 5350 5050
F 0 "#PWR013" H 5350 4800 50  0001 C CNN
F 1 "GND" H 5355 4877 50  0000 C CNN
F 2 "" H 5350 5050 50  0001 C CNN
F 3 "" H 5350 5050 50  0001 C CNN
	1    5350 5050
	-1   0    0    -1  
$EndComp
Wire Wire Line
	6150 5050 6150 4850
Wire Wire Line
	6150 4550 6150 4400
Wire Wire Line
	5750 4400 5750 4550
Wire Wire Line
	5750 5050 5750 4850
Wire Wire Line
	5350 4850 5350 5050
Wire Wire Line
	5350 4550 5350 4400
Wire Wire Line
	6150 4000 6150 4100
Wire Wire Line
	5350 3800 5350 4100
$Comp
L Connector_Generic:Conn_01x06 J4
U 1 1 61EB90D4
P 6000 6400
F 0 "J4" H 6080 6392 50  0000 L CNN
F 1 "Conn_01x06" H 6080 6301 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x06_P2.54mm_Vertical" H 6000 6400 50  0001 C CNN
F 3 "~" H 6000 6400 50  0001 C CNN
	1    6000 6400
	1    0    0    -1  
$EndComp
NoConn ~ 5800 6200
Text GLabel 4900 6300 0    50   Input ~ 0
TxD
Text GLabel 4900 6400 0    50   Input ~ 0
RxD
$Comp
L Jumper:SolderJumper_2_Open JP2
U 1 1 61ECAD51
P 4500 6500
F 0 "JP2" H 4500 6300 50  0000 C CNN
F 1 "SolderJumper_2_Open" H 4500 6400 50  0000 C CNN
F 2 "Jumper:SolderJumper-2_P1.3mm_Open_RoundedPad1.0x1.5mm" H 4500 6500 50  0001 C CNN
F 3 "~" H 4500 6500 50  0001 C CNN
	1    4500 6500
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR021
U 1 1 61ED017E
P 4100 6350
F 0 "#PWR021" H 4100 6200 50  0001 C CNN
F 1 "VCC" H 4115 6523 50  0000 C CNN
F 2 "" H 4100 6350 50  0001 C CNN
F 3 "" H 4100 6350 50  0001 C CNN
	1    4100 6350
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR024
U 1 1 61ED4EE0
P 5800 6800
F 0 "#PWR024" H 5800 6550 50  0001 C CNN
F 1 "GND" H 5805 6627 50  0000 C CNN
F 2 "" H 5800 6800 50  0001 C CNN
F 3 "" H 5800 6800 50  0001 C CNN
	1    5800 6800
	1    0    0    -1  
$EndComp
NoConn ~ 5800 6600
$Comp
L Sensor_Magnetic:A1101ELHL U2
U 1 1 61F15C9F
P 2650 6400
F 0 "U2" H 2400 6250 50  0000 R CNN
F 1 "RR112-1" H 2400 6150 50  0000 R CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 2650 6050 50  0001 L CIN
F 3 "http://www.allegromicro.com/en/Products/Part_Numbers/1101/1101.pdf" H 2650 7050 50  0001 C CNN
	1    2650 6400
	-1   0    0    -1  
$EndComp
$Comp
L power:VCC #PWR017
U 1 1 61F1951D
P 2750 5900
F 0 "#PWR017" H 2750 5750 50  0001 C CNN
F 1 "VCC" H 2765 6073 50  0000 C CNN
F 2 "" H 2750 5900 50  0001 C CNN
F 3 "" H 2750 5900 50  0001 C CNN
	1    2750 5900
	-1   0    0    -1  
$EndComp
$Comp
L Device:C C3
U 1 1 61F1E81D
P 3100 6050
F 0 "C3" H 2986 6004 50  0000 R CNN
F 1 "1u" H 2986 6095 50  0000 R CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder" H 3138 5900 50  0001 C CNN
F 3 "~" H 3100 6050 50  0001 C CNN
F 4 "C28323" H 3100 6050 50  0001 C CNN "LCSC"
	1    3100 6050
	-1   0    0    1   
$EndComp
$Comp
L power:GND #PWR020
U 1 1 61F208C9
P 3100 6200
F 0 "#PWR020" H 3100 5950 50  0001 C CNN
F 1 "GND" H 3105 6027 50  0000 C CNN
F 2 "" H 3100 6200 50  0001 C CNN
F 3 "" H 3100 6200 50  0001 C CNN
	1    3100 6200
	-1   0    0    -1  
$EndComp
Wire Wire Line
	3100 5900 2750 5900
Wire Wire Line
	2750 5900 2750 6000
Connection ~ 2750 5900
$Comp
L Device:R R8
U 1 1 61F31061
P 2100 6400
F 0 "R8" V 1893 6400 50  0000 C CNN
F 1 "47k" V 1984 6400 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 2030 6400 50  0001 C CNN
F 3 "~" H 2100 6400 50  0001 C CNN
F 4 "C17713" H 2100 6400 50  0001 C CNN "LCSC"
	1    2100 6400
	0    -1   1    0   
$EndComp
Wire Wire Line
	2250 6400 2350 6400
$Comp
L Device:C C4
U 1 1 61F35765
P 1750 6550
F 0 "C4" H 1865 6596 50  0000 L CNN
F 1 "100p" H 1865 6505 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder" H 1788 6400 50  0001 C CNN
F 3 "~" H 1750 6550 50  0001 C CNN
F 4 "C1790" H 1750 6550 50  0001 C CNN "LCSC"
	1    1750 6550
	-1   0    0    -1  
$EndComp
$Comp
L power:GND #PWR022
U 1 1 61F361D6
P 1750 6700
F 0 "#PWR022" H 1750 6450 50  0001 C CNN
F 1 "GND" H 1755 6527 50  0000 C CNN
F 2 "" H 1750 6700 50  0001 C CNN
F 3 "" H 1750 6700 50  0001 C CNN
	1    1750 6700
	-1   0    0    -1  
$EndComp
Wire Wire Line
	1750 6400 1950 6400
Wire Wire Line
	4100 6350 4100 6500
Wire Wire Line
	1750 6400 1750 6250
Connection ~ 1750 6400
Text GLabel 1750 6250 1    50   Input ~ 0
MAG-SENSE
$Comp
L power:GND #PWR023
U 1 1 61F6D146
P 2750 6800
F 0 "#PWR023" H 2750 6550 50  0001 C CNN
F 1 "GND" H 2755 6627 50  0000 C CNN
F 2 "" H 2750 6800 50  0001 C CNN
F 3 "" H 2750 6800 50  0001 C CNN
	1    2750 6800
	1    0    0    -1  
$EndComp
$Comp
L Device:R R2
U 1 1 61FE79E8
P 9650 3650
F 0 "R2" V 9443 3650 50  0000 C CNN
F 1 "1k" V 9534 3650 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 9580 3650 50  0001 C CNN
F 3 "~" H 9650 3650 50  0001 C CNN
F 4 "C17513" H 9650 3650 50  0001 C CNN "LCSC"
	1    9650 3650
	0    1    1    0   
$EndComp
Wire Wire Line
	4100 6500 4350 6500
Wire Wire Line
	4650 6500 5800 6500
Wire Wire Line
	5800 6700 5800 6800
$Comp
L power:GND #PWR025
U 1 1 6206C78F
P 5250 7000
F 0 "#PWR025" H 5250 6750 50  0001 C CNN
F 1 "GND" H 5255 6827 50  0000 C CNN
F 2 "" H 5250 7000 50  0001 C CNN
F 3 "" H 5250 7000 50  0001 C CNN
	1    5250 7000
	1    0    0    -1  
$EndComp
$Comp
L power:PWR_FLAG #FLG02
U 1 1 62334011
P 1700 2950
F 0 "#FLG02" H 1700 3025 50  0001 C CNN
F 1 "PWR_FLAG" V 1700 3078 50  0000 L CNN
F 2 "" H 1700 2950 50  0001 C CNN
F 3 "~" H 1700 2950 50  0001 C CNN
	1    1700 2950
	0    1    1    0   
$EndComp
Connection ~ 1700 2950
$Comp
L power:PWR_FLAG #FLG01
U 1 1 62338445
P 1700 2350
F 0 "#FLG01" H 1700 2425 50  0001 C CNN
F 1 "PWR_FLAG" V 1700 2478 50  0000 L CNN
F 2 "" H 1700 2350 50  0001 C CNN
F 3 "~" H 1700 2350 50  0001 C CNN
	1    1700 2350
	0    1    1    0   
$EndComp
Connection ~ 1700 2350
$Comp
L power:GND #PWR010
U 1 1 61CEFE33
P 7900 4300
F 0 "#PWR010" H 7900 4050 50  0001 C CNN
F 1 "GND" H 7905 4127 50  0000 C CNN
F 2 "" H 7900 4300 50  0001 C CNN
F 3 "" H 7900 4300 50  0001 C CNN
	1    7900 4300
	1    0    0    -1  
$EndComp
$Comp
L Device:C C2
U 1 1 61B47FCD
P 8750 2300
F 0 "C2" H 8635 2254 50  0000 R CNN
F 1 "100n" H 8635 2345 50  0000 R CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder" H 8788 2150 50  0001 C CNN
F 3 "~" H 8750 2300 50  0001 C CNN
F 4 "C49678" H 8750 2300 50  0001 C CNN "LCSC"
	1    8750 2300
	-1   0    0    1   
$EndComp
$Comp
L power:GND #PWR05
U 1 1 61B48A19
P 8750 2450
F 0 "#PWR05" H 8750 2200 50  0001 C CNN
F 1 "GND" H 8755 2277 50  0000 C CNN
F 2 "" H 8750 2450 50  0001 C CNN
F 3 "" H 8750 2450 50  0001 C CNN
	1    8750 2450
	-1   0    0    -1  
$EndComp
Wire Wire Line
	7900 1300 7800 1300
Wire Wire Line
	8750 1050 7900 1050
Wire Wire Line
	7900 1050 7900 900 
Wire Wire Line
	7900 1050 7900 1300
Connection ~ 7900 1050
Text GLabel 6850 1900 0    50   Input ~ 0
MOSI
Text GLabel 6850 2000 0    50   Input ~ 0
MISO
Text GLabel 6850 2100 0    50   Input ~ 0
SCK
Text GLabel 6850 3100 0    50   Input ~ 0
RESET
Text GLabel 6850 3400 0    50   Input ~ 0
TxD
Text GLabel 6850 3300 0    50   Input ~ 0
RxD
Text GLabel 6850 1700 0    50   Input ~ 0
SERVO-PWM
Wire Wire Line
	4400 1550 4750 1550
Wire Wire Line
	4400 3950 4750 3950
Wire Wire Line
	5750 3900 5750 4100
Wire Wire Line
	4950 3700 4950 4250
Wire Wire Line
	6850 4650 6850 4750
Wire Wire Line
	8750 2150 8750 1600
Wire Wire Line
	8500 1600 8750 1600
Wire Wire Line
	8500 1900 8850 1900
Text GLabel 8850 1900 2    50   Input ~ 0
MAG-SENSE
Wire Wire Line
	6850 4750 6550 4750
Wire Wire Line
	6550 4750 6550 2600
Connection ~ 6850 4750
Wire Wire Line
	6850 4750 6850 4850
Wire Wire Line
	4750 1550 4750 2500
Wire Wire Line
	6550 2600 7300 2600
Wire Wire Line
	5350 3800 7300 3800
Wire Wire Line
	5750 3900 7300 3900
Wire Wire Line
	6150 4000 7300 4000
Wire Wire Line
	4950 3700 7300 3700
Text GLabel 9200 3650 0    50   Input ~ 0
SERVO-PWM
Wire Wire Line
	9200 3650 9350 3650
Connection ~ 9350 3650
Wire Wire Line
	9350 3650 9500 3650
Wire Wire Line
	9350 3250 10050 3250
Wire Wire Line
	10050 3250 10050 3450
Wire Wire Line
	9350 3250 9200 3250
Connection ~ 9350 3250
Text GLabel 9200 3250 0    50   Input ~ 0
SERVO-VCC
$Comp
L power:GND #PWR019
U 1 1 61E3C644
P 8850 6100
F 0 "#PWR019" H 8850 5850 50  0001 C CNN
F 1 "GND" H 8855 5927 50  0000 C CNN
F 2 "" H 8850 6100 50  0001 C CNN
F 3 "" H 8850 6100 50  0001 C CNN
	1    8850 6100
	1    0    0    -1  
$EndComp
Text GLabel 9500 5600 2    50   Input ~ 0
RESET
Text GLabel 9500 5500 2    50   Input ~ 0
SCK
Text GLabel 9500 5400 2    50   Input ~ 0
MOSI
Text GLabel 9500 5300 2    50   Input ~ 0
MISO
$Comp
L power:GND #PWR018
U 1 1 61DC462B
P 7800 5900
F 0 "#PWR018" H 7800 5650 50  0001 C CNN
F 1 "GND" H 7805 5727 50  0000 C CNN
F 2 "" H 7800 5900 50  0001 C CNN
F 3 "" H 7800 5900 50  0001 C CNN
	1    7800 5900
	1    0    0    -1  
$EndComp
Wire Wire Line
	8600 4900 8600 4800
Wire Wire Line
	7800 4900 7900 4900
Wire Wire Line
	7800 5000 7800 4900
$Comp
L power:VCC #PWR012
U 1 1 61EF81EA
P 8600 4800
F 0 "#PWR012" H 8600 4650 50  0001 C CNN
F 1 "VCC" H 8615 4973 50  0000 C CNN
F 2 "" H 8600 4800 50  0001 C CNN
F 3 "" H 8600 4800 50  0001 C CNN
	1    8600 4800
	1    0    0    -1  
$EndComp
$Comp
L Jumper:SolderJumper_2_Open JP1
U 1 1 61EF6D73
P 8050 4900
F 0 "JP1" H 8050 5105 50  0000 C CNN
F 1 "SolderJumper_2_Open" H 8050 5014 50  0000 C CNN
F 2 "Jumper:SolderJumper-2_P1.3mm_Open_RoundedPad1.0x1.5mm" H 8050 4900 50  0001 C CNN
F 3 "~" H 8050 4900 50  0001 C CNN
	1    8050 4900
	1    0    0    -1  
$EndComp
$Comp
L Device:R R7
U 1 1 61CF35F4
P 8500 5100
F 0 "R7" H 8570 5146 50  0000 L CNN
F 1 "10k" H 8570 5055 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 8430 5100 50  0001 C CNN
F 3 "~" H 8500 5100 50  0001 C CNN
F 4 "C17414" H 8500 5100 50  0001 C CNN "LCSC"
	1    8500 5100
	1    0    0    -1  
$EndComp
Wire Wire Line
	4950 4250 4400 4250
Wire Wire Line
	4400 3450 4950 3450
Wire Wire Line
	4400 3250 5800 3250
Wire Wire Line
	5700 3150 4400 3150
Wire Wire Line
	4400 3050 5600 3050
Wire Wire Line
	5500 2850 4400 2850
Wire Wire Line
	4400 2650 5400 2650
Wire Wire Line
	7300 2500 4750 2500
Connection ~ 4750 2500
Wire Wire Line
	4750 2500 4750 3950
Wire Wire Line
	7300 2300 5400 2300
Wire Wire Line
	5400 2300 5400 2650
Wire Wire Line
	7300 1600 5750 1600
Wire Wire Line
	5750 1600 5750 1400
Wire Wire Line
	5750 1400 4400 1400
Text Label 7200 2300 2    50   ~ 0
L-SLAVE
Text Label 7200 2500 2    50   ~ 0
SERVO-VCC
Text Label 7200 2600 2    50   ~ 0
BTN
Text Label 7200 3000 2    50   ~ 0
L-BTN+IN
Text Label 7200 2900 2    50   ~ 0
L-BTN-IN
Text Label 7200 3700 2    50   ~ 0
REL-CONTROL
Text Label 7200 3800 2    50   ~ 0
LED-GR
Text Label 7200 3900 2    50   ~ 0
LED-YEL
Text Label 7200 4000 2    50   ~ 0
LED-RED
Text Label 7200 1600 2    50   ~ 0
SERVO-POWER-EN
Wire Wire Line
	6850 1700 7300 1700
Wire Wire Line
	6850 1900 7300 1900
Wire Wire Line
	6850 2000 7300 2000
Wire Wire Line
	6850 2100 7300 2100
Wire Wire Line
	6850 3100 7300 3100
Wire Wire Line
	6850 3300 7300 3300
Wire Wire Line
	6850 3400 7300 3400
Wire Wire Line
	4750 1550 4850 1550
Connection ~ 4750 1550
Text GLabel 4850 1550 2    50   Input ~ 0
SERVO-VCC
$Comp
L Connector:AVR-ISP-6 J3
U 1 1 61D93AFA
P 7900 5500
F 0 "J3" H 7571 5596 50  0000 R CNN
F 1 "AVR-ISP-6" H 7571 5505 50  0000 R CNN
F 2 "Connector_PinSocket_2.54mm:PinSocket_2x03_P2.54mm_Vertical" V 7650 5550 50  0001 C CNN
F 3 " ~" H 6625 4950 50  0001 C CNN
	1    7900 5500
	1    0    0    -1  
$EndComp
Wire Wire Line
	8300 5600 8500 5600
Connection ~ 8500 5600
Connection ~ 8500 4900
Wire Wire Line
	8500 4900 8600 4900
Wire Wire Line
	8200 4900 8500 4900
Wire Wire Line
	9350 3600 9350 3650
Wire Wire Line
	9350 3300 9350 3250
Wire Wire Line
	8500 5250 8500 5600
Wire Wire Line
	8500 4950 8500 4900
Wire Wire Line
	2900 2250 1600 2250
Wire Wire Line
	2900 2450 1600 2450
Wire Wire Line
	2500 4650 2900 4650
Wire Wire Line
	2500 3850 2500 4650
Wire Wire Line
	2200 4500 2900 4500
Wire Wire Line
	1700 4650 2400 4650
Wire Wire Line
	2400 4650 2400 4350
Wire Wire Line
	2400 4350 2900 4350
Connection ~ 1700 4650
$Comp
L Mechanical:MountingHole_Pad H2
U 1 1 61C39558
P 10000 4200
F 0 "H2" H 10100 4249 50  0000 L CNN
F 1 "MountingHole_Pad" H 10100 4158 50  0000 L CNN
F 2 "MountingHole:MountingHole_2.2mm_M2_Pad_Via" H 10000 4200 50  0001 C CNN
F 3 "~" H 10000 4200 50  0001 C CNN
	1    10000 4200
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole_Pad H1
U 1 1 61C397FD
P 9050 4200
F 0 "H1" H 9150 4249 50  0000 L CNN
F 1 "MountingHole_Pad" H 9150 4158 50  0000 L CNN
F 2 "MountingHole:MountingHole_2.2mm_M2_Pad_Via" H 9050 4200 50  0001 C CNN
F 3 "~" H 9050 4200 50  0001 C CNN
	1    9050 4200
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR026
U 1 1 61C3AB52
P 9050 4300
F 0 "#PWR026" H 9050 4050 50  0001 C CNN
F 1 "GND" H 9055 4127 50  0000 C CNN
F 2 "" H 9050 4300 50  0001 C CNN
F 3 "" H 9050 4300 50  0001 C CNN
	1    9050 4300
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR046
U 1 1 61C3AE25
P 10000 4300
F 0 "#PWR046" H 10000 4050 50  0001 C CNN
F 1 "GND" H 10005 4127 50  0000 C CNN
F 2 "" H 10000 4300 50  0001 C CNN
F 3 "" H 10000 4300 50  0001 C CNN
	1    10000 4300
	1    0    0    -1  
$EndComp
$Comp
L Device:C C13
U 1 1 62057D9B
P 9200 1200
F 0 "C13" H 9085 1154 50  0000 R CNN
F 1 "100n" H 9085 1245 50  0000 R CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder" H 9238 1050 50  0001 C CNN
F 3 "~" H 9200 1200 50  0001 C CNN
F 4 "C49678" H 9200 1200 50  0001 C CNN "LCSC"
	1    9200 1200
	-1   0    0    1   
$EndComp
Wire Wire Line
	8750 1050 9200 1050
Connection ~ 8750 1050
$Comp
L power:GND #PWR047
U 1 1 6205FAC8
P 9200 1350
F 0 "#PWR047" H 9200 1100 50  0001 C CNN
F 1 "GND" H 9205 1177 50  0000 C CNN
F 2 "" H 9200 1350 50  0001 C CNN
F 3 "" H 9200 1350 50  0001 C CNN
	1    9200 1350
	1    0    0    -1  
$EndComp
Wire Wire Line
	6150 2250 6150 2700
Wire Wire Line
	6150 2700 7300 2700
Wire Wire Line
	4400 2250 6150 2250
Wire Wire Line
	6050 2450 6050 2800
Wire Wire Line
	6050 2800 7300 2800
Wire Wire Line
	4400 2450 6050 2450
Text Label 7200 2700 2    50   ~ 0
L-IN-
Text Label 7200 2800 2    50   ~ 0
L-IN+
Wire Wire Line
	6050 3350 6050 2900
Wire Wire Line
	6050 2900 7300 2900
Wire Wire Line
	4400 3350 6050 3350
Wire Wire Line
	7300 3000 5700 3000
Wire Wire Line
	5700 3000 5700 3150
Wire Wire Line
	5500 1800 5500 2850
Wire Wire Line
	5600 2200 5600 3050
Wire Wire Line
	5500 1800 7300 1800
Wire Wire Line
	5600 2200 7300 2200
Wire Wire Line
	7300 3600 5800 3600
Wire Wire Line
	5800 3250 5800 3600
Wire Wire Line
	4950 3450 4950 3500
Wire Wire Line
	4950 3500 7300 3500
Text Label 7200 2200 2    50   ~ 0
L-OUT-
Text Label 7200 1800 2    50   ~ 0
L-OUT+
Text Label 7200 3600 2    50   ~ 0
L-BTN+OUT
Text Label 7200 3500 2    50   ~ 0
L-BTN-OUT
Connection ~ 7900 1300
$Comp
L MCU_Microchip_ATmega:ATmega328P-AU U1
U 1 1 61AED7D8
P 7900 2800
F 0 "U1" H 8050 1300 50  0000 C CNN
F 1 "ATmega8A-AU" H 8300 1200 50  0000 C CNN
F 2 "Package_QFP:TQFP-32_7x7mm_P0.8mm" H 7900 2800 50  0001 C CIN
F 3 "http://ww1.microchip.com/downloads/en/DeviceDoc/ATmega328_P%20AVR%20MCU%20with%20picoPower%20Technology%20Data%20Sheet%2040001984A.pdf" H 7900 2800 50  0001 C CNN
F 4 "C16190" H 7900 2800 50  0001 C CNN "LCSC"
F 5 "0;0;-90" H 7900 2800 50  0001 C CNN "JLCPCB_CORRECTION"
	1    7900 2800
	-1   0    0    -1  
$EndComp
Wire Wire Line
	8300 5300 8850 5300
Wire Wire Line
	8300 5400 8950 5400
Wire Wire Line
	8300 5500 9050 5500
$Comp
L Power_Protection:SP0505BAJT D4
U 1 1 6238AAFD
P 8850 5900
F 0 "D4" H 9155 5946 50  0000 L CNN
F 1 "SMF05" H 9155 5855 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-363_SC-70-6" H 9150 5850 50  0001 L CNN
F 3 "https://datasheet.lcsc.com/lcsc/1810311712_onsemi-SMF05CT1G_C15879.pdf" H 8975 6025 50  0001 C CNN
F 4 "C15879" H 8850 5900 50  0001 C CNN "LCSC"
	1    8850 5900
	1    0    0    -1  
$EndComp
Wire Wire Line
	8500 5600 8650 5600
Wire Wire Line
	8650 5700 8650 5600
Connection ~ 8650 5600
Wire Wire Line
	8650 5600 9500 5600
Wire Wire Line
	9050 5700 9050 5500
Connection ~ 9050 5500
Wire Wire Line
	9050 5500 9500 5500
Wire Wire Line
	8950 5700 8950 5400
Connection ~ 8950 5400
Wire Wire Line
	8950 5400 9500 5400
Wire Wire Line
	8850 5700 8850 5300
Connection ~ 8850 5300
Wire Wire Line
	8850 5300 9500 5300
NoConn ~ 8750 5700
Wire Wire Line
	4900 6400 5050 6400
Wire Wire Line
	4900 6300 5250 6300
$Comp
L Power_Protection:SP0505BAJT D5
U 1 1 62414A26
P 5250 6800
F 0 "D5" H 4945 6846 50  0000 R CNN
F 1 "SMF05" H 5150 6600 50  0000 R CNN
F 2 "Package_TO_SOT_SMD:SOT-363_SC-70-6" H 5550 6750 50  0001 L CNN
F 3 "https://datasheet.lcsc.com/lcsc/1810311712_onsemi-SMF05CT1G_C15879.pdf" H 5375 6925 50  0001 C CNN
F 4 "C15879" H 5250 6800 50  0001 C CNN "LCSC"
	1    5250 6800
	-1   0    0    -1  
$EndComp
Wire Wire Line
	5250 6600 5250 6300
Connection ~ 5250 6300
Wire Wire Line
	5250 6300 5800 6300
Wire Wire Line
	5050 6600 5050 6400
Connection ~ 5050 6400
Wire Wire Line
	5050 6400 5800 6400
NoConn ~ 5450 6600
NoConn ~ 5350 6600
NoConn ~ 5150 6600
Text Notes 8550 3000 0    50   ~ 0
Variants:\nATmega328p, ATmega328pb
Wire Wire Line
	8500 1800 8850 1800
$Comp
L Connector:TestPoint TP1
U 1 1 61D44F93
P 8850 1800
F 0 "TP1" H 8908 1918 50  0000 L CNN
F 1 "TestPoint" H 8908 1827 50  0000 L CNN
F 2 "TestPoint:TestPoint_Pad_D1.5mm" H 9050 1800 50  0001 C CNN
F 3 "~" H 9050 1800 50  0001 C CNN
	1    8850 1800
	1    0    0    -1  
$EndComp
$Comp
L Connector:TestPoint TP2
U 1 1 61D60F98
P 10200 1650
F 0 "TP2" H 10258 1768 50  0000 L CNN
F 1 "TestPoint" H 10258 1677 50  0000 L CNN
F 2 "TestPoint:TestPoint_Loop_D3.50mm_Drill1.4mm_Beaded" H 10400 1650 50  0001 C CNN
F 3 "~" H 10400 1650 50  0001 C CNN
	1    10200 1650
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR048
U 1 1 61D6232B
P 10200 1650
F 0 "#PWR048" H 10200 1400 50  0001 C CNN
F 1 "GND" H 10205 1477 50  0000 C CNN
F 2 "" H 10200 1650 50  0001 C CNN
F 3 "" H 10200 1650 50  0001 C CNN
	1    10200 1650
	1    0    0    -1  
$EndComp
$EndSCHEMATC
