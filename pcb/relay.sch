EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 3 4
Title "hWexla - relay"
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Text HLabel 5400 3000 0    50   BiDi ~ 0
RELA+
Text HLabel 6300 3100 2    50   BiDi ~ 0
RELA0
Text HLabel 5400 3200 0    50   BiDi ~ 0
RELA-
Text HLabel 5400 3400 0    50   BiDi ~ 0
RELB+
Text HLabel 6300 3500 2    50   BiDi ~ 0
RELB0
Text HLabel 5400 3600 0    50   BiDi ~ 0
RELB-
Text HLabel 7650 4300 2    50   Input ~ 0
REL-CONTROL
$Comp
L Relay:EC2-5NU K1
U 1 1 620E6427
P 5850 3500
F 0 "K1" V 6617 3500 50  0000 C CNN
F 1 "HFD2/005" V 6526 3500 50  0000 C CNN
F 2 "Relay_THT:Relay_DPDT_Kemet_EC2" H 5850 3500 50  0001 C CNN
F 3 "https://content.kemet.com/datasheets/KEM_R7002_EC2_EE2.pdf" H 5850 3500 50  0001 C CNN
	1    5850 3500
	0    -1   -1   0   
$EndComp
Wire Wire Line
	5550 3000 5400 3000
Wire Wire Line
	5550 3200 5400 3200
Wire Wire Line
	5550 3400 5400 3400
Wire Wire Line
	5550 3600 5400 3600
Wire Wire Line
	6150 3500 6300 3500
Wire Wire Line
	6150 3100 6300 3100
Wire Wire Line
	5400 3900 5450 3900
$Comp
L Transistor_FET:2N7002 Q3
U 1 1 620F3648
P 6750 4300
F 0 "Q3" H 6955 4346 50  0000 L CNN
F 1 "2N7002" H 6955 4255 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 6950 4225 50  0001 L CIN
F 3 "https://www.onsemi.com/pub/Collateral/NDS7002A-D.PDF" H 6750 4300 50  0001 L CNN
	1    6750 4300
	-1   0    0    -1  
$EndComp
Wire Wire Line
	6150 3900 6250 3900
Wire Wire Line
	6650 3900 6650 4100
$Comp
L power:GND #PWR0129
U 1 1 620F8FA6
P 6650 4750
F 0 "#PWR0129" H 6650 4500 50  0001 C CNN
F 1 "GND" H 6655 4577 50  0000 C CNN
F 2 "" H 6650 4750 50  0001 C CNN
F 3 "" H 6650 4750 50  0001 C CNN
	1    6650 4750
	1    0    0    -1  
$EndComp
Wire Wire Line
	6650 4750 6650 4600
$Comp
L Device:R R14
U 1 1 620F9B3B
P 7150 4450
F 0 "R14" H 7220 4496 50  0000 L CNN
F 1 "10k" H 7220 4405 50  0000 L CNN
F 2 "" V 7080 4450 50  0001 C CNN
F 3 "~" H 7150 4450 50  0001 C CNN
	1    7150 4450
	1    0    0    -1  
$EndComp
Wire Wire Line
	7150 4600 6650 4600
Connection ~ 6650 4600
Wire Wire Line
	6650 4600 6650 4500
Wire Wire Line
	6950 4300 7150 4300
Wire Wire Line
	7150 4300 7650 4300
Connection ~ 7150 4300
$Comp
L Diode:1N4148 D12
U 1 1 621017B8
P 5850 4300
F 0 "D12" H 5850 4150 50  0000 C CNN
F 1 "1N4148" H 5850 4050 50  0000 C CNN
F 2 "Diode_THT:D_DO-35_SOD27_P7.62mm_Horizontal" H 5850 4125 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/1N4148_1N4448.pdf" H 5850 4300 50  0001 C CNN
	1    5850 4300
	1    0    0    -1  
$EndComp
Wire Wire Line
	6000 4300 6250 4300
Wire Wire Line
	6250 4300 6250 3900
Connection ~ 6250 3900
Wire Wire Line
	6250 3900 6650 3900
Wire Wire Line
	5700 4300 5450 4300
Wire Wire Line
	5450 4300 5450 3900
Connection ~ 5450 3900
Wire Wire Line
	5450 3900 5550 3900
Text HLabel 5400 3900 0    50   Input ~ 0
REL-POWER
$EndSCHEMATC
