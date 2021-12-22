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
AR Path="/61AA542B/61AD6C62" Ref="R20"  Part="1" 
F 0 "R20" H 4030 6854 50  0000 R CNN
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
AR Path="/61AA542B/61AD6C68" Ref="C8"  Part="1" 
F 0 "C8" H 4515 6946 50  0000 L CNN
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
AR Path="/61AA542B/61AD6C6E" Ref="D18"  Part="1" 
F 0 "D18" V 4054 6370 50  0000 R CNN
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
AR Path="/61AA542B/61AD6C87" Ref="Q7"  Part="1" 
F 0 "Q7" H 4838 6496 50  0000 L CNN
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
AR Path="/61AA542B/61AD6C9B" Ref="#PWR044"  Part="1" 
F 0 "#PWR044" H 4100 7100 50  0001 C CNN
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
L Diode:BAT54C D16
U 1 1 61AD8962
P 3600 4100
F 0 "D16" V 3646 4188 50  0000 L CNN
F 1 "BAT54C" V 3555 4188 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 3675 4225 50  0001 L CNN
F 3 "http://www.diodes.com/_files/datasheets/ds11005.pdf" H 3520 4100 50  0001 C CNN
	1    3600 4100
	0    -1   -1   0   
$EndComp
$Comp
L Device:Polyfuse F7
U 1 1 61ADAEDE
P 2750 3800
F 0 "F7" V 2525 3800 50  0000 C CNN
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
L Device:Polyfuse F5
U 1 1 61AEEAD2
P 2750 2300
F 0 "F5" V 2525 2300 50  0000 C CNN
F 1 "50mA" V 2616 2300 50  0000 C CNN
F 2 "Fuse:Fuse_1206_3216Metric_Pad1.42x1.75mm_HandSolder" H 2800 2100 50  0001 L CNN
F 3 "~" H 2750 2300 50  0001 C CNN
	1    2750 2300
	0    1    1    0   
$EndComp
$Comp
L Device:Polyfuse F6
U 1 1 61AEEF05
P 2750 2900
F 0 "F6" V 2525 2900 50  0000 C CNN
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
L Diode:BAT54C D15
U 1 1 61AFFF13
P 3600 2600
F 0 "D15" V 3646 2688 50  0000 L CNN
F 1 "BAT54C" V 3555 2688 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 3675 2725 50  0001 L CNN
F 3 "http://www.diodes.com/_files/datasheets/ds11005.pdf" H 3520 2600 50  0001 C CNN
	1    3600 2600
	0    -1   -1   0   
$EndComp
$Comp
L Diode:BAT54C D17
U 1 1 61B07AF9
P 3600 5600
F 0 "D17" V 3646 5688 50  0000 L CNN
F 1 "BAT54C" V 3555 5688 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 3675 5725 50  0001 L CNN
F 3 "http://www.diodes.com/_files/datasheets/ds11005.pdf" H 3520 5600 50  0001 C CNN
	1    3600 5600
	0    -1   -1   0   
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
Connection ~ 3600 2900
Wire Wire Line
	5100 2100 5100 2900
Connection ~ 5100 2900
$Comp
L power:VCC #PWR036
U 1 1 61B4EFE7
P 4600 1800
F 0 "#PWR036" H 4600 1650 50  0001 C CNN
F 1 "VCC" H 4615 1973 50  0000 C CNN
F 2 "" H 4600 1800 50  0001 C CNN
F 3 "" H 4600 1800 50  0001 C CNN
	1    4600 1800
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR037
U 1 1 61B4F48D
P 5100 1800
F 0 "#PWR037" H 5100 1650 50  0001 C CNN
F 1 "VCC" H 5115 1973 50  0000 C CNN
F 2 "" H 5100 1800 50  0001 C CNN
F 3 "" H 5100 1800 50  0001 C CNN
	1    5100 1800
	1    0    0    -1  
$EndComp
Connection ~ 3600 3800
Connection ~ 3600 4400
Wire Wire Line
	5100 3600 5100 4400
Connection ~ 5100 4400
$Comp
L power:VCC #PWR038
U 1 1 61B56B18
P 4600 3300
F 0 "#PWR038" H 4600 3150 50  0001 C CNN
F 1 "VCC" H 4615 3473 50  0000 C CNN
F 2 "" H 4600 3300 50  0001 C CNN
F 3 "" H 4600 3300 50  0001 C CNN
	1    4600 3300
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR039
U 1 1 61B56E93
P 5100 3300
F 0 "#PWR039" H 5100 3150 50  0001 C CNN
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
AR Path="/61AA542B/61B7647E" Ref="R21"  Part="1" 
F 0 "R21" H 5530 6854 50  0000 R CNN
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
AR Path="/61AA542B/61B76484" Ref="C9"  Part="1" 
F 0 "C9" H 6015 6946 50  0000 L CNN
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
AR Path="/61AA542B/61B7648A" Ref="D19"  Part="1" 
F 0 "D19" V 5554 6370 50  0000 R CNN
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
AR Path="/61AA542B/61B764A4" Ref="#PWR045"  Part="1" 
F 0 "#PWR045" H 5600 7100 50  0001 C CNN
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
L Transistor_FET:2N7002 Q5
U 1 1 61B7E2C2
P 6300 5200
F 0 "Q5" V 6549 5200 50  0000 C CNN
F 1 "2N7002" V 6640 5200 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 6500 5125 50  0001 L CIN
F 3 "https://www.onsemi.com/pub/Collateral/NDS7002A-D.PDF" H 6300 5200 50  0001 L CNN
	1    6300 5200
	0    -1   1    0   
$EndComp
$Comp
L Transistor_FET:2N7002 Q6
U 1 1 61B85DA3
P 7300 5800
F 0 "Q6" V 7549 5800 50  0000 C CNN
F 1 "2N7002" V 7640 5800 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 7500 5725 50  0001 L CIN
F 3 "https://www.onsemi.com/pub/Collateral/NDS7002A-D.PDF" H 7300 5800 50  0001 L CNN
	1    7300 5800
	0    -1   1    0   
$EndComp
$Comp
L power:GND #PWR042
U 1 1 61BA9E12
P 6650 5300
F 0 "#PWR042" H 6650 5050 50  0001 C CNN
F 1 "GND" H 6655 5127 50  0000 C CNN
F 2 "" H 6650 5300 50  0001 C CNN
F 3 "" H 6650 5300 50  0001 C CNN
	1    6650 5300
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR043
U 1 1 61BAA7E4
P 7650 5900
F 0 "#PWR043" H 7650 5650 50  0001 C CNN
F 1 "GND" H 7655 5727 50  0000 C CNN
F 2 "" H 7650 5900 50  0001 C CNN
F 3 "" H 7650 5900 50  0001 C CNN
	1    7650 5900
	1    0    0    -1  
$EndComp
Wire Wire Line
	6500 5300 6650 5300
Wire Wire Line
	7500 5900 7650 5900
Wire Wire Line
	7100 5900 3600 5900
Connection ~ 3600 5900
Connection ~ 3600 5300
$Comp
L Transistor_FET:2N7002 Q3
U 1 1 61BDED63
P 6300 3700
F 0 "Q3" V 6549 3700 50  0000 C CNN
F 1 "2N7002" V 6640 3700 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 6500 3625 50  0001 L CIN
F 3 "https://www.onsemi.com/pub/Collateral/NDS7002A-D.PDF" H 6300 3700 50  0001 L CNN
	1    6300 3700
	0    -1   1    0   
$EndComp
$Comp
L Transistor_FET:2N7002 Q4
U 1 1 61BDED69
P 7300 4300
F 0 "Q4" V 7549 4300 50  0000 C CNN
F 1 "2N7002" V 7640 4300 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 7500 4225 50  0001 L CIN
F 3 "https://www.onsemi.com/pub/Collateral/NDS7002A-D.PDF" H 7300 4300 50  0001 L CNN
	1    7300 4300
	0    -1   1    0   
$EndComp
$Comp
L power:GND #PWR040
U 1 1 61BDED6F
P 6650 3800
F 0 "#PWR040" H 6650 3550 50  0001 C CNN
F 1 "GND" H 6655 3627 50  0000 C CNN
F 2 "" H 6650 3800 50  0001 C CNN
F 3 "" H 6650 3800 50  0001 C CNN
	1    6650 3800
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR041
U 1 1 61BDED75
P 7650 4400
F 0 "#PWR041" H 7650 4150 50  0001 C CNN
F 1 "GND" H 7655 4227 50  0000 C CNN
F 2 "" H 7650 4400 50  0001 C CNN
F 3 "" H 7650 4400 50  0001 C CNN
	1    7650 4400
	1    0    0    -1  
$EndComp
Wire Wire Line
	6500 3800 6650 3800
Wire Wire Line
	7500 4400 7650 4400
Wire Wire Line
	5100 4400 6950 4400
Text HLabel 9050 3500 2    50   Input ~ 0
L-BTN+OUT
Wire Wire Line
	6000 3800 6000 3400
Connection ~ 6000 3800
Wire Wire Line
	6000 3800 6100 3800
Text HLabel 9050 3400 2    50   Output ~ 0
L-BTN+IN
Text HLabel 9050 4100 2    50   Input ~ 0
L-BTN-OUT
Wire Wire Line
	6950 4400 6950 4000
Connection ~ 6950 4400
Wire Wire Line
	6950 4400 7100 4400
Text HLabel 9050 4000 2    50   Output ~ 0
L-BTN-IN
Text HLabel 9050 5000 2    50   Input ~ 0
L-OUT+
Text HLabel 9050 5600 2    50   Input ~ 0
L-OUT-
Wire Wire Line
	6950 4000 7950 4000
Wire Wire Line
	2350 1450 2600 1450
$Comp
L Device:Polyfuse F4
U 1 1 61D21450
P 2750 1450
F 0 "F4" V 2525 1450 50  0000 C CNN
F 1 "50mA" V 2616 1450 50  0000 C CNN
F 2 "Fuse:Fuse_1206_3216Metric_Pad1.42x1.75mm_HandSolder" H 2800 1250 50  0001 L CNN
F 3 "~" H 2750 1450 50  0001 C CNN
	1    2750 1450
	0    1    1    0   
$EndComp
$Comp
L Diode:BAT54C D14
U 1 1 61D27D1C
P 3550 1150
F 0 "D14" V 3596 1238 50  0000 L CNN
F 1 "BAT54C" V 3505 1238 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 3625 1275 50  0001 L CNN
F 3 "http://www.diodes.com/_files/datasheets/ds11005.pdf" H 3470 1150 50  0001 C CNN
	1    3550 1150
	0    -1   -1   0   
$EndComp
Wire Wire Line
	2900 1450 3550 1450
$Comp
L Device:R R12
U 1 1 61D2D6EB
P 4550 1150
F 0 "R12" H 4620 1196 50  0000 L CNN
F 1 "10k" H 4620 1105 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 4480 1150 50  0001 C CNN
F 3 "~" H 4550 1150 50  0001 C CNN
	1    4550 1150
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR035
U 1 1 61D2E156
P 4550 1000
F 0 "#PWR035" H 4550 850 50  0001 C CNN
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
Connection ~ 4550 1450
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
$Comp
L Device:C C?
U 1 1 61CF1D4A
P 3750 6900
AR Path="/61AA5240/61CF1D4A" Ref="C?"  Part="1" 
AR Path="/61AA542B/61CF1D4A" Ref="C11"  Part="1" 
F 0 "C11" H 3865 6946 50  0000 L CNN
F 1 "100n" H 3865 6855 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder" H 3788 6750 50  0001 C CNN
F 3 "~" H 3750 6900 50  0001 C CNN
	1    3750 6900
	-1   0    0    -1  
$EndComp
Wire Wire Line
	4100 7200 3750 7200
Wire Wire Line
	3750 7200 3750 7050
Wire Wire Line
	3750 6750 3750 6300
Wire Wire Line
	3750 6300 4100 6300
$Comp
L Device:C C?
U 1 1 61CFAC6A
P 5250 6900
AR Path="/61AA5240/61CFAC6A" Ref="C?"  Part="1" 
AR Path="/61AA542B/61CFAC6A" Ref="C12"  Part="1" 
F 0 "C12" H 5365 6946 50  0000 L CNN
F 1 "100n" H 5365 6855 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder" H 5288 6750 50  0001 C CNN
F 3 "~" H 5250 6900 50  0001 C CNN
	1    5250 6900
	-1   0    0    1   
$EndComp
Wire Wire Line
	5600 7200 5250 7200
Wire Wire Line
	5250 7200 5250 7050
Wire Wire Line
	5600 6300 5250 6300
Wire Wire Line
	5250 6300 5250 6750
Wire Wire Line
	8250 3400 9050 3400
Wire Wire Line
	8250 4000 9050 4000
Wire Wire Line
	8250 2900 9050 2900
Wire Wire Line
	8250 2300 9050 2300
Wire Wire Line
	8250 1450 9050 1450
Wire Wire Line
	4550 1450 7950 1450
Wire Wire Line
	4600 2300 7950 2300
Wire Wire Line
	5100 2900 7950 2900
Wire Wire Line
	4600 3800 6000 3800
Wire Wire Line
	3600 3800 4600 3800
Wire Wire Line
	3600 5300 6100 5300
Wire Wire Line
	2900 5300 3600 5300
Wire Wire Line
	6000 3400 7950 3400
$Comp
L Device:R_Pack04_Split RN1
U 1 1 61D96A6C
P 4600 1950
F 0 "RN1" H 4688 1996 50  0000 L CNN
F 1 "10k" H 4688 1905 50  0000 L CNN
F 2 "Resistor_SMD:R_Array_Concave_4x0603" V 4520 1950 50  0001 C CNN
F 3 "~" H 4600 1950 50  0001 C CNN
	1    4600 1950
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Pack04_Split RN1
U 3 1 61D9AFCF
P 4600 3450
F 0 "RN1" H 4688 3496 50  0000 L CNN
F 1 "10k" H 4688 3405 50  0000 L CNN
F 2 "Resistor_SMD:R_Array_Concave_4x0603" V 4520 3450 50  0001 C CNN
F 3 "~" H 4600 3450 50  0001 C CNN
	3    4600 3450
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Pack04_Split RN1
U 4 1 61D9BF43
P 5100 3450
F 0 "RN1" H 5188 3496 50  0000 L CNN
F 1 "10k" H 5188 3405 50  0000 L CNN
F 2 "Resistor_SMD:R_Array_Concave_4x0603" V 5020 3450 50  0001 C CNN
F 3 "~" H 5100 3450 50  0001 C CNN
	4    5100 3450
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Pack04_Split RN1
U 2 1 61D9CA0D
P 5100 1950
F 0 "RN1" H 5188 1996 50  0000 L CNN
F 1 "10k" H 5188 1905 50  0000 L CNN
F 2 "Resistor_SMD:R_Array_Concave_4x0603" V 5020 1950 50  0001 C CNN
F 3 "~" H 5100 1950 50  0001 C CNN
	2    5100 1950
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Pack04_Split RN2
U 1 1 61E4CA97
P 8100 2900
F 0 "RN2" V 7893 2900 50  0000 C CNN
F 1 "2k2" V 7984 2900 50  0000 C CNN
F 2 "Resistor_SMD:R_Array_Concave_4x0603" V 8020 2900 50  0001 C CNN
F 3 "~" H 8100 2900 50  0001 C CNN
	1    8100 2900
	0    1    1    0   
$EndComp
$Comp
L Device:R_Pack04_Split RN2
U 2 1 61E4D1BE
P 8100 2300
F 0 "RN2" V 7893 2300 50  0000 C CNN
F 1 "2k2" V 7984 2300 50  0000 C CNN
F 2 "Resistor_SMD:R_Array_Concave_4x0603" V 8020 2300 50  0001 C CNN
F 3 "~" H 8100 2300 50  0001 C CNN
	2    8100 2300
	0    1    1    0   
$EndComp
$Comp
L Device:R_Pack04_Split RN2
U 3 1 61E4D92B
P 8100 4000
F 0 "RN2" V 7893 4000 50  0000 C CNN
F 1 "2k2" V 7984 4000 50  0000 C CNN
F 2 "Resistor_SMD:R_Array_Concave_4x0603" V 8020 4000 50  0001 C CNN
F 3 "~" H 8100 4000 50  0001 C CNN
	3    8100 4000
	0    1    1    0   
$EndComp
$Comp
L Device:R_Pack04_Split RN2
U 4 1 61E4E152
P 8100 3400
F 0 "RN2" V 7893 3400 50  0000 C CNN
F 1 "2k2" V 7984 3400 50  0000 C CNN
F 2 "Resistor_SMD:R_Array_Concave_4x0603" V 8020 3400 50  0001 C CNN
F 3 "~" H 8100 3400 50  0001 C CNN
	4    8100 3400
	0    1    1    0   
$EndComp
$Comp
L Device:R R13
U 1 1 61D3122D
P 8100 1450
F 0 "R13" V 7893 1450 50  0000 C CNN
F 1 "2k2" V 7984 1450 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 8030 1450 50  0001 C CNN
F 3 "~" H 8100 1450 50  0001 C CNN
	1    8100 1450
	0    1    1    0   
$EndComp
$Comp
L Device:R_Pack04_Split RN3
U 1 1 61E6A767
P 6650 3650
F 0 "RN3" H 6738 3696 50  0000 L CNN
F 1 "10k" H 6738 3605 50  0000 L CNN
F 2 "Resistor_SMD:R_Array_Concave_4x0603" V 6570 3650 50  0001 C CNN
F 3 "~" H 6650 3650 50  0001 C CNN
	1    6650 3650
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Pack04_Split RN3
U 3 1 61E6C884
P 7650 5750
F 0 "RN3" H 7738 5796 50  0000 L CNN
F 1 "10k" H 7738 5705 50  0000 L CNN
F 2 "Resistor_SMD:R_Array_Concave_4x0603" V 7570 5750 50  0001 C CNN
F 3 "~" H 7650 5750 50  0001 C CNN
	3    7650 5750
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Pack04_Split RN3
U 4 1 61E6DD2A
P 6650 5150
F 0 "RN3" H 6738 5196 50  0000 L CNN
F 1 "10k" H 6738 5105 50  0000 L CNN
F 2 "Resistor_SMD:R_Array_Concave_4x0603" V 6570 5150 50  0001 C CNN
F 3 "~" H 6650 5150 50  0001 C CNN
	4    6650 5150
	1    0    0    -1  
$EndComp
Wire Wire Line
	6300 3500 6650 3500
Wire Wire Line
	7300 4100 7650 4100
Wire Wire Line
	7300 5600 7650 5600
Connection ~ 6650 3800
Connection ~ 6650 3500
Wire Wire Line
	6650 3500 9050 3500
Wire Wire Line
	6300 5000 6650 5000
$Comp
L Device:R_Pack04_Split RN3
U 2 1 61E6BA91
P 7650 4250
F 0 "RN3" H 7738 4296 50  0000 L CNN
F 1 "10k" H 7738 4205 50  0000 L CNN
F 2 "Resistor_SMD:R_Array_Concave_4x0603" V 7570 4250 50  0001 C CNN
F 3 "~" H 7650 4250 50  0001 C CNN
	2    7650 4250
	1    0    0    -1  
$EndComp
Connection ~ 7650 4400
Connection ~ 7650 4100
Wire Wire Line
	7650 4100 9050 4100
Connection ~ 6650 5300
Connection ~ 6650 5000
Wire Wire Line
	6650 5000 9050 5000
Connection ~ 7650 5900
Connection ~ 7650 5600
Wire Wire Line
	7650 5600 9050 5600
$EndSCHEMATC
