EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 4 4
Title "hWexla - IO protection"
Date "2021-12-04"
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Device:R R?
U 1 1 61AD6C62
P 4100 6900
AR Path="/61AA5240/61AD6C62" Ref="R?"  Part="1" 
AR Path="/61AA542B/61AD6C62" Ref="R5"  Part="1" 
F 0 "R5" H 4030 6854 50  0000 R CNN
F 1 "2k2" H 4030 6945 50  0000 R CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 4030 6900 50  0001 C CNN
F 3 "~" H 4100 6900 50  0001 C CNN
	1    4100 6900
	1    0    0    1   
$EndComp
$Comp
L Device:C C?
U 1 1 61AD6C68
P 4400 6900
AR Path="/61AA5240/61AD6C68" Ref="C?"  Part="1" 
AR Path="/61AA542B/61AD6C68" Ref="C10"  Part="1" 
F 0 "C10" H 4515 6946 50  0000 L CNN
F 1 "100n" H 4515 6855 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder" H 4438 6750 50  0001 C CNN
F 3 "~" H 4400 6900 50  0001 C CNN
	1    4400 6900
	1    0    0    -1  
$EndComp
$Comp
L Diode:BZX84Cxx D?
U 1 1 61AD6C6E
P 4100 6450
AR Path="/61AA5240/61AD6C6E" Ref="D?"  Part="1" 
AR Path="/61AA542B/61AD6C6E" Ref="D4"  Part="1" 
F 0 "D4" V 4054 6370 50  0000 R CNN
F 1 "BZX84C5V1" V 4145 6370 50  0000 R CNN
F 2 "Diode_SMD:D_SOT-23_ANK" H 4100 6275 50  0001 C CNN
F 3 "https://diotec.com/tl_files/diotec/files/pdf/datasheets/bzx84c2v4.pdf" H 4100 6450 50  0001 C CNN
	1    4100 6450
	0    -1   1    0   
$EndComp
Wire Wire Line
	4100 6600 4400 6600
Wire Wire Line
	4600 6600 4600 6550
Connection ~ 4100 6600
Connection ~ 4400 6600
Wire Wire Line
	4400 6600 4600 6600
Wire Wire Line
	4750 6600 4750 7200
Wire Wire Line
	4400 6750 4400 6600
Wire Wire Line
	4100 6750 4100 6600
Wire Wire Line
	4100 7050 4100 7200
Wire Wire Line
	4100 7200 4400 7200
Wire Wire Line
	4400 7050 4400 7200
Connection ~ 4400 7200
Wire Wire Line
	4400 7200 4750 7200
$Comp
L Triac_Thyristor:BT169D Q?
U 1 1 61AD6C87
P 4750 6450
AR Path="/61AA5240/61AD6C87" Ref="Q?"  Part="1" 
AR Path="/61AA542B/61AD6C87" Ref="Q2"  Part="1" 
F 0 "Q2" H 4838 6496 50  0000 L CNN
F 1 "BT148" H 4838 6405 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-223" H 4850 6375 50  0001 L CIN
F 3 "https://media.digikey.com/pdf/Data%20Sheets/NXP%20PDFs/BT169_Series.pdf" H 4750 6450 50  0001 L CNN
	1    4750 6450
	1    0    0    -1  
$EndComp
Wire Wire Line
	4100 6300 4750 6300
$Comp
L power:GND #PWR?
U 1 1 61AD6C9B
P 4100 7350
AR Path="/61AA5240/61AD6C9B" Ref="#PWR?"  Part="1" 
AR Path="/61AA542B/61AD6C9B" Ref="#PWR010"  Part="1" 
F 0 "#PWR010" H 4100 7100 50  0001 C CNN
F 1 "GND" H 4105 7177 50  0000 C CNN
F 2 "" H 4100 7350 50  0001 C CNN
F 3 "" H 4100 7350 50  0001 C CNN
	1    4100 7350
	1    0    0    -1  
$EndComp
Connection ~ 4100 7200
Wire Wire Line
	4100 7350 4100 7200
$Comp
L Diode:BAT54C D3
U 1 1 61AD8962
P 3600 4100
F 0 "D3" V 3646 4188 50  0000 L CNN
F 1 "BAT54C" V 3555 4188 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 3675 4225 50  0001 L CNN
F 3 "http://www.diodes.com/_files/datasheets/ds11005.pdf" H 3520 4100 50  0001 C CNN
	1    3600 4100
	0    -1   -1   0   
$EndComp
$Comp
L Device:Polyfuse F3
U 1 1 61ADAEDE
P 2750 3800
F 0 "F3" V 2525 3800 50  0000 C CNN
F 1 "200mA" V 2616 3800 50  0000 C CNN
F 2 "Fuse:Fuse_1206_3216Metric_Pad1.42x1.75mm_HandSolder" H 2800 3600 50  0001 L CNN
F 3 "~" H 2750 3800 50  0001 C CNN
	1    2750 3800
	0    1    1    0   
$EndComp
Text HLabel 2350 3800 0    50   BiDi ~ 0
BTN+
Text HLabel 2350 4400 0    50   BiDi ~ 0
BTN-
Text HLabel 2350 2300 0    50   Input ~ 0
IN+
Text HLabel 2350 2900 0    50   Input ~ 0
IN-
Text HLabel 2350 5300 0    50   Output ~ 0
OUT+
Text HLabel 2350 5900 0    50   Output ~ 0
OUT-
$Comp
L Device:Polyfuse F8
U 1 1 61AEE6B7
P 2750 4400
F 0 "F8" V 2525 4400 50  0000 C CNN
F 1 "200mA" V 2616 4400 50  0000 C CNN
F 2 "Fuse:Fuse_1206_3216Metric_Pad1.42x1.75mm_HandSolder" H 2800 4200 50  0001 L CNN
F 3 "~" H 2750 4400 50  0001 C CNN
	1    2750 4400
	0    1    1    0   
$EndComp
$Comp
L Device:Polyfuse F6
U 1 1 61AEEAD2
P 2750 2300
F 0 "F6" V 2525 2300 50  0000 C CNN
F 1 "50mA" V 2616 2300 50  0000 C CNN
F 2 "Fuse:Fuse_1206_3216Metric_Pad1.42x1.75mm_HandSolder" H 2800 2100 50  0001 L CNN
F 3 "~" H 2750 2300 50  0001 C CNN
	1    2750 2300
	0    1    1    0   
$EndComp
$Comp
L Device:Polyfuse F7
U 1 1 61AEEF05
P 2750 2900
F 0 "F7" V 2525 2900 50  0000 C CNN
F 1 "50mA" V 2616 2900 50  0000 C CNN
F 2 "Fuse:Fuse_1206_3216Metric_Pad1.42x1.75mm_HandSolder" H 2800 2700 50  0001 L CNN
F 3 "~" H 2750 2900 50  0001 C CNN
	1    2750 2900
	0    1    1    0   
$EndComp
$Comp
L Device:Polyfuse F9
U 1 1 61AF2F04
P 2750 5300
F 0 "F9" V 2525 5300 50  0000 C CNN
F 1 "200mA" V 2616 5300 50  0000 C CNN
F 2 "Fuse:Fuse_1206_3216Metric_Pad1.42x1.75mm_HandSolder" H 2800 5100 50  0001 L CNN
F 3 "~" H 2750 5300 50  0001 C CNN
	1    2750 5300
	0    1    1    0   
$EndComp
$Comp
L Device:Polyfuse F10
U 1 1 61AF2F0A
P 2750 5900
F 0 "F10" V 2525 5900 50  0000 C CNN
F 1 "200mA" V 2616 5900 50  0000 C CNN
F 2 "Fuse:Fuse_1206_3216Metric_Pad1.42x1.75mm_HandSolder" H 2800 5700 50  0001 L CNN
F 3 "~" H 2750 5900 50  0001 C CNN
	1    2750 5900
	0    1    1    0   
$EndComp
$Comp
L Diode:BAT54C D14
U 1 1 61AFFF13
P 3600 2600
F 0 "D14" V 3646 2688 50  0000 L CNN
F 1 "BAT54C" V 3555 2688 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 3675 2725 50  0001 L CNN
F 3 "http://www.diodes.com/_files/datasheets/ds11005.pdf" H 3520 2600 50  0001 C CNN
	1    3600 2600
	0    -1   -1   0   
$EndComp
$Comp
L Diode:BAT54C D15
U 1 1 61B07AF9
P 3600 5600
F 0 "D15" V 3646 5688 50  0000 L CNN
F 1 "BAT54C" V 3555 5688 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 3675 5725 50  0001 L CNN
F 3 "http://www.diodes.com/_files/datasheets/ds11005.pdf" H 3520 5600 50  0001 C CNN
	1    3600 5600
	0    -1   -1   0   
$EndComp
$Comp
L Device:R_Pack04_SIP_Split RN1
U 1 1 61B2FD42
P 4600 1950
F 0 "RN1" H 4900 2000 50  0000 R CNN
F 1 "10k" H 4850 1900 50  0000 R CNN
F 2 "Resistor_SMD:R_Array_Concave_4x0603" V 4520 1950 50  0001 C CNN
F 3 "http://www.vishay.com/docs/31509/csc.pdf" H 4600 1950 50  0001 C CNN
	1    4600 1950
	-1   0    0    -1  
$EndComp
$Comp
L Device:R_Pack04_SIP_Split RN1
U 2 1 61B2FD48
P 5100 1950
F 0 "RN1" H 5188 1996 50  0000 L CNN
F 1 "10k" H 5188 1905 50  0000 L CNN
F 2 "Resistor_SMD:R_Array_Concave_4x0603" V 5020 1950 50  0001 C CNN
F 3 "http://www.vishay.com/docs/31509/csc.pdf" H 5100 1950 50  0001 C CNN
	2    5100 1950
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Pack04_SIP_Split RN1
U 3 1 61B2FD4E
P 4600 3450
F 0 "RN1" H 4300 3500 50  0000 L CNN
F 1 "10k" H 4350 3400 50  0000 L CNN
F 2 "Resistor_SMD:R_Array_Concave_4x0603" V 4520 3450 50  0001 C CNN
F 3 "http://www.vishay.com/docs/31509/csc.pdf" H 4600 3450 50  0001 C CNN
	3    4600 3450
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Pack04_SIP_Split RN1
U 4 1 61B2FD54
P 5100 3450
F 0 "RN1" H 5188 3496 50  0000 L CNN
F 1 "10k" H 5188 3405 50  0000 L CNN
F 2 "Resistor_SMD:R_Array_Concave_4x0603" V 5020 3450 50  0001 C CNN
F 3 "http://www.vishay.com/docs/31509/csc.pdf" H 5100 3450 50  0001 C CNN
	4    5100 3450
	1    0    0    -1  
$EndComp
$Comp
L Device:R R17
U 1 1 61B428D5
P 5750 2300
F 0 "R17" V 5543 2300 50  0000 C CNN
F 1 "2k2" V 5634 2300 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 5680 2300 50  0001 C CNN
F 3 "~" H 5750 2300 50  0001 C CNN
	1    5750 2300
	0    1    1    0   
$EndComp
$Comp
L Device:R R18
U 1 1 61B43498
P 5750 2900
F 0 "R18" V 5543 2900 50  0000 C CNN
F 1 "2k2" V 5634 2900 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 5680 2900 50  0001 C CNN
F 3 "~" H 5750 2900 50  0001 C CNN
	1    5750 2900
	0    1    1    0   
$EndComp
Wire Wire Line
	2600 2300 2350 2300
Wire Wire Line
	2350 2900 2600 2900
Wire Wire Line
	2600 3800 2350 3800
Wire Wire Line
	2350 4400 2600 4400
Wire Wire Line
	2600 5300 2350 5300
Wire Wire Line
	2350 5900 2600 5900
Wire Wire Line
	2900 5900 3600 5900
Wire Wire Line
	3600 5300 2900 5300
Wire Wire Line
	2900 4400 3600 4400
Wire Wire Line
	3600 3800 2900 3800
Wire Wire Line
	2900 2900 3600 2900
Wire Wire Line
	3600 2300 2900 2300
Wire Wire Line
	3600 2300 4600 2300
Connection ~ 3600 2300
Wire Wire Line
	5600 2900 5100 2900
Connection ~ 3600 2900
Wire Wire Line
	5100 2100 5100 2900
Connection ~ 5100 2900
$Comp
L power:VCC #PWR0130
U 1 1 61B4EFE7
P 4600 1800
F 0 "#PWR0130" H 4600 1650 50  0001 C CNN
F 1 "VCC" H 4615 1973 50  0000 C CNN
F 2 "" H 4600 1800 50  0001 C CNN
F 3 "" H 4600 1800 50  0001 C CNN
	1    4600 1800
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0131
U 1 1 61B4F48D
P 5100 1800
F 0 "#PWR0131" H 5100 1650 50  0001 C CNN
F 1 "VCC" H 5115 1973 50  0000 C CNN
F 2 "" H 5100 1800 50  0001 C CNN
F 3 "" H 5100 1800 50  0001 C CNN
	1    5100 1800
	1    0    0    -1  
$EndComp
Wire Wire Line
	3600 3800 4600 3800
Connection ~ 3600 3800
Connection ~ 3600 4400
Wire Wire Line
	5100 3600 5100 4400
Connection ~ 5100 4400
$Comp
L power:VCC #PWR0132
U 1 1 61B56B18
P 4600 3300
F 0 "#PWR0132" H 4600 3150 50  0001 C CNN
F 1 "VCC" H 4615 3473 50  0000 C CNN
F 2 "" H 4600 3300 50  0001 C CNN
F 3 "" H 4600 3300 50  0001 C CNN
	1    4600 3300
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0133
U 1 1 61B56E93
P 5100 3300
F 0 "#PWR0133" H 5100 3150 50  0001 C CNN
F 1 "VCC" H 5115 3473 50  0000 C CNN
F 2 "" H 5100 3300 50  0001 C CNN
F 3 "" H 5100 3300 50  0001 C CNN
	1    5100 3300
	1    0    0    -1  
$EndComp
Wire Wire Line
	3600 4400 5100 4400
Wire Wire Line
	3600 2900 5100 2900
Wire Wire Line
	4600 2100 4600 2300
Connection ~ 4600 2300
Wire Wire Line
	4600 2300 5600 2300
Wire Wire Line
	4600 3600 4600 3800
Connection ~ 4600 3800
Text HLabel 9050 2300 2    50   Output ~ 0
L-IN+
Text HLabel 9050 2900 2    50   Output ~ 0
L-IN-
Wire Wire Line
	3800 4100 4100 4100
Wire Wire Line
	4100 4100 4100 6300
Connection ~ 4100 6300
Wire Wire Line
	3800 2600 4100 2600
Wire Wire Line
	4100 2600 4100 4100
Connection ~ 4100 4100
$Comp
L Device:R R?
U 1 1 61B7647E
P 5600 6900
AR Path="/61AA5240/61B7647E" Ref="R?"  Part="1" 
AR Path="/61AA542B/61B7647E" Ref="R23"  Part="1" 
F 0 "R23" H 5530 6854 50  0000 R CNN
F 1 "2k2" H 5530 6945 50  0000 R CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 5530 6900 50  0001 C CNN
F 3 "~" H 5600 6900 50  0001 C CNN
	1    5600 6900
	1    0    0    1   
$EndComp
$Comp
L Device:C C?
U 1 1 61B76484
P 5900 6900
AR Path="/61AA5240/61B76484" Ref="C?"  Part="1" 
AR Path="/61AA542B/61B76484" Ref="C14"  Part="1" 
F 0 "C14" H 6015 6946 50  0000 L CNN
F 1 "100n" H 6015 6855 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder" H 5938 6750 50  0001 C CNN
F 3 "~" H 5900 6900 50  0001 C CNN
	1    5900 6900
	1    0    0    -1  
$EndComp
$Comp
L Diode:BZX84Cxx D?
U 1 1 61B7648A
P 5600 6450
AR Path="/61AA5240/61B7648A" Ref="D?"  Part="1" 
AR Path="/61AA542B/61B7648A" Ref="D16"  Part="1" 
F 0 "D16" V 5554 6370 50  0000 R CNN
F 1 "BZX84C30" V 5645 6370 50  0000 R CNN
F 2 "Diode_SMD:D_SOT-23_ANK" H 5600 6275 50  0001 C CNN
F 3 "https://diotec.com/tl_files/diotec/files/pdf/datasheets/bzx84c2v4.pdf" H 5600 6450 50  0001 C CNN
	1    5600 6450
	0    -1   1    0   
$EndComp
Wire Wire Line
	5600 6600 5900 6600
Wire Wire Line
	6100 6600 6100 6550
Connection ~ 5600 6600
Connection ~ 5900 6600
Wire Wire Line
	5900 6600 6100 6600
Wire Wire Line
	6250 6600 6250 7200
Wire Wire Line
	5900 6750 5900 6600
Wire Wire Line
	5600 6750 5600 6600
Wire Wire Line
	5600 7050 5600 7200
Wire Wire Line
	5600 7200 5900 7200
Wire Wire Line
	5900 7050 5900 7200
Connection ~ 5900 7200
Wire Wire Line
	5900 7200 6250 7200
$Comp
L Triac_Thyristor:BT169D Q?
U 1 1 61B7649D
P 6250 6450
AR Path="/61AA5240/61B7649D" Ref="Q?"  Part="1" 
AR Path="/61AA542B/61B7649D" Ref="Q8"  Part="1" 
F 0 "Q8" H 6338 6496 50  0000 L CNN
F 1 "BT148" H 6338 6405 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-223" H 6350 6375 50  0001 L CIN
F 3 "https://media.digikey.com/pdf/Data%20Sheets/NXP%20PDFs/BT169_Series.pdf" H 6250 6450 50  0001 L CNN
	1    6250 6450
	1    0    0    -1  
$EndComp
Wire Wire Line
	5600 6300 6250 6300
$Comp
L power:GND #PWR?
U 1 1 61B764A4
P 5600 7350
AR Path="/61AA5240/61B764A4" Ref="#PWR?"  Part="1" 
AR Path="/61AA542B/61B764A4" Ref="#PWR0134"  Part="1" 
F 0 "#PWR0134" H 5600 7100 50  0001 C CNN
F 1 "GND" H 5605 7177 50  0000 C CNN
F 2 "" H 5600 7350 50  0001 C CNN
F 3 "" H 5600 7350 50  0001 C CNN
	1    5600 7350
	1    0    0    -1  
$EndComp
Connection ~ 5600 7200
Wire Wire Line
	5600 7350 5600 7200
Wire Wire Line
	3800 5600 5600 5600
Wire Wire Line
	5600 5600 5600 6300
Connection ~ 5600 6300
$Comp
L Transistor_FET:2N7002 Q6
U 1 1 61B7E2C2
P 6750 5200
F 0 "Q6" V 6999 5200 50  0000 C CNN
F 1 "2N7002" V 7090 5200 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 6950 5125 50  0001 L CIN
F 3 "https://www.onsemi.com/pub/Collateral/NDS7002A-D.PDF" H 6750 5200 50  0001 L CNN
	1    6750 5200
	0    -1   1    0   
$EndComp
$Comp
L Transistor_FET:2N7002 Q7
U 1 1 61B85DA3
P 7300 5800
F 0 "Q7" V 7549 5800 50  0000 C CNN
F 1 "2N7002" V 7640 5800 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 7500 5725 50  0001 L CIN
F 3 "https://www.onsemi.com/pub/Collateral/NDS7002A-D.PDF" H 7300 5800 50  0001 L CNN
	1    7300 5800
	0    -1   1    0   
$EndComp
$Comp
L power:GND #PWR0135
U 1 1 61BA9E12
P 7100 5300
F 0 "#PWR0135" H 7100 5050 50  0001 C CNN
F 1 "GND" H 7105 5127 50  0000 C CNN
F 2 "" H 7100 5300 50  0001 C CNN
F 3 "" H 7100 5300 50  0001 C CNN
	1    7100 5300
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0136
U 1 1 61BAA7E4
P 7650 5900
F 0 "#PWR0136" H 7650 5650 50  0001 C CNN
F 1 "GND" H 7655 5727 50  0000 C CNN
F 2 "" H 7650 5900 50  0001 C CNN
F 3 "" H 7650 5900 50  0001 C CNN
	1    7650 5900
	1    0    0    -1  
$EndComp
Wire Wire Line
	6950 5300 7100 5300
Wire Wire Line
	7500 5900 7650 5900
Wire Wire Line
	7100 5900 3600 5900
Connection ~ 3600 5900
Wire Wire Line
	3600 5300 6550 5300
Connection ~ 3600 5300
$Comp
L Transistor_FET:2N7002 Q4
U 1 1 61BDED63
P 6750 3700
F 0 "Q4" V 6999 3700 50  0000 C CNN
F 1 "2N7002" V 7090 3700 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 6950 3625 50  0001 L CIN
F 3 "https://www.onsemi.com/pub/Collateral/NDS7002A-D.PDF" H 6750 3700 50  0001 L CNN
	1    6750 3700
	0    -1   1    0   
$EndComp
$Comp
L Transistor_FET:2N7002 Q5
U 1 1 61BDED69
P 7300 4300
F 0 "Q5" V 7549 4300 50  0000 C CNN
F 1 "2N7002" V 7640 4300 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 7500 4225 50  0001 L CIN
F 3 "https://www.onsemi.com/pub/Collateral/NDS7002A-D.PDF" H 7300 4300 50  0001 L CNN
	1    7300 4300
	0    -1   1    0   
$EndComp
$Comp
L power:GND #PWR0137
U 1 1 61BDED6F
P 7100 3800
F 0 "#PWR0137" H 7100 3550 50  0001 C CNN
F 1 "GND" H 7105 3627 50  0000 C CNN
F 2 "" H 7100 3800 50  0001 C CNN
F 3 "" H 7100 3800 50  0001 C CNN
	1    7100 3800
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0138
U 1 1 61BDED75
P 7650 4400
F 0 "#PWR0138" H 7650 4150 50  0001 C CNN
F 1 "GND" H 7655 4227 50  0000 C CNN
F 2 "" H 7650 4400 50  0001 C CNN
F 3 "" H 7650 4400 50  0001 C CNN
	1    7650 4400
	1    0    0    -1  
$EndComp
Wire Wire Line
	6950 3800 7100 3800
Wire Wire Line
	7500 4400 7650 4400
Wire Wire Line
	4600 3800 6450 3800
Wire Wire Line
	5100 4400 6950 4400
$Comp
L Device:R R20
U 1 1 61C044E0
P 7650 4250
F 0 "R20" H 7720 4296 50  0000 L CNN
F 1 "10k" H 7720 4205 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 7580 4250 50  0001 C CNN
F 3 "~" H 7650 4250 50  0001 C CNN
	1    7650 4250
	1    0    0    -1  
$EndComp
Connection ~ 7650 4400
$Comp
L Device:R R22
U 1 1 61C07737
P 7650 5750
F 0 "R22" H 7720 5796 50  0000 L CNN
F 1 "10k" H 7720 5705 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 7580 5750 50  0001 C CNN
F 3 "~" H 7650 5750 50  0001 C CNN
	1    7650 5750
	1    0    0    -1  
$EndComp
Connection ~ 7650 5900
$Comp
L Device:R R21
U 1 1 61C096D3
P 7100 5150
F 0 "R21" H 7170 5196 50  0000 L CNN
F 1 "10k" H 7170 5105 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 7030 5150 50  0001 C CNN
F 3 "~" H 7100 5150 50  0001 C CNN
	1    7100 5150
	1    0    0    -1  
$EndComp
Connection ~ 7100 5300
$Comp
L Device:R R19
U 1 1 61C0AA94
P 7100 3650
F 0 "R19" H 7170 3696 50  0000 L CNN
F 1 "10k" H 7170 3605 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 7030 3650 50  0001 C CNN
F 3 "~" H 7100 3650 50  0001 C CNN
	1    7100 3650
	1    0    0    -1  
$EndComp
Connection ~ 7100 3800
Wire Wire Line
	6750 3500 7100 3500
Text HLabel 9050 3500 2    50   Input ~ 0
L-BTN+OUT
Wire Wire Line
	6450 3800 6450 3400
Connection ~ 6450 3800
Wire Wire Line
	6450 3800 6550 3800
Text HLabel 9050 3400 2    50   Output ~ 0
L-BTN+IN
Wire Wire Line
	7300 4100 7650 4100
Text HLabel 9050 4100 2    50   Input ~ 0
L-BTN-OUT
Wire Wire Line
	6950 4400 6950 4000
Connection ~ 6950 4400
Wire Wire Line
	6950 4400 7100 4400
Text HLabel 9050 4000 2    50   Output ~ 0
L-BTN-IN
Wire Wire Line
	6750 5000 7100 5000
Text HLabel 9050 5000 2    50   Input ~ 0
L-OUT+
Wire Wire Line
	7300 5600 7650 5600
Text HLabel 9050 5600 2    50   Input ~ 0
L-OUT-
Wire Wire Line
	7650 5600 9050 5600
Connection ~ 7650 5600
Wire Wire Line
	7100 5000 9050 5000
Connection ~ 7100 5000
Wire Wire Line
	7650 4100 9050 4100
Connection ~ 7650 4100
Wire Wire Line
	6950 4000 9050 4000
Wire Wire Line
	7100 3500 9050 3500
Connection ~ 7100 3500
Wire Wire Line
	6450 3400 9050 3400
Wire Wire Line
	5900 2900 9050 2900
Wire Wire Line
	5900 2300 9050 2300
Wire Wire Line
	2350 1450 2600 1450
$Comp
L Device:Polyfuse F5
U 1 1 61D21450
P 2750 1450
F 0 "F5" V 2525 1450 50  0000 C CNN
F 1 "50mA" V 2616 1450 50  0000 C CNN
F 2 "Fuse:Fuse_1206_3216Metric_Pad1.42x1.75mm_HandSolder" H 2800 1250 50  0001 L CNN
F 3 "~" H 2750 1450 50  0001 C CNN
	1    2750 1450
	0    1    1    0   
$EndComp
$Comp
L Diode:BAT54C D13
U 1 1 61D27D1C
P 3550 1150
F 0 "D13" V 3596 1238 50  0000 L CNN
F 1 "BAT54C" V 3505 1238 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 3625 1275 50  0001 L CNN
F 3 "http://www.diodes.com/_files/datasheets/ds11005.pdf" H 3470 1150 50  0001 C CNN
	1    3550 1150
	0    -1   -1   0   
$EndComp
Wire Wire Line
	2900 1450 3550 1450
$Comp
L Device:R R15
U 1 1 61D2D6EB
P 4550 1150
F 0 "R15" H 4620 1196 50  0000 L CNN
F 1 "10k" H 4620 1105 50  0000 L CNN
F 2 "" V 4480 1150 50  0001 C CNN
F 3 "~" H 4550 1150 50  0001 C CNN
	1    4550 1150
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0139
U 1 1 61D2E156
P 4550 1000
F 0 "#PWR0139" H 4550 850 50  0001 C CNN
F 1 "VCC" H 4565 1173 50  0000 C CNN
F 2 "" H 4550 1000 50  0001 C CNN
F 3 "" H 4550 1000 50  0001 C CNN
	1    4550 1000
	1    0    0    -1  
$EndComp
Wire Wire Line
	3550 1450 4550 1450
Wire Wire Line
	4550 1450 4550 1300
Connection ~ 3550 1450
$Comp
L Device:R R16
U 1 1 61D3122D
P 5750 1450
F 0 "R16" V 5543 1450 50  0000 C CNN
F 1 "2k2" V 5634 1450 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 5680 1450 50  0001 C CNN
F 3 "~" H 5750 1450 50  0001 C CNN
	1    5750 1450
	0    1    1    0   
$EndComp
Wire Wire Line
	5600 1450 4550 1450
Connection ~ 4550 1450
Wire Wire Line
	5900 1450 9050 1450
Text HLabel 9050 1450 2    50   Output ~ 0
L-SLAVE
Wire Wire Line
	3750 1150 4100 1150
Wire Wire Line
	4100 1150 4100 2600
Connection ~ 4100 2600
Text HLabel 2350 1450 0    50   Input ~ 0
SLAVE
NoConn ~ 3550 850 
$EndSCHEMATC
