EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 2 4
Title "hWexla - power"
Date ""
Rev ""
Comp "Model Railroader Club Brno I – KMŽ Brno I – https://kmz-brno.cz/"
Comment1 "Jan Horáček"
Comment2 "https://github.com/kmzbrnoI/hwexla"
Comment3 "https://creativecommons.org/licenses/by-sa/4.0/"
Comment4 "Released under the Creative Commons Attribution-ShareAlike 4.0 License"
$EndDescr
$Comp
L Device:R R9
U 1 1 5F15D8D9
P 6350 2850
F 0 "R9" H 6420 2896 50  0000 L CNN
F 1 "10k" H 6420 2805 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 6280 2850 50  0001 C CNN
F 3 "~" H 6350 2850 50  0001 C CNN
F 4 "C17414" H 6350 2850 50  0001 C CNN "LCSC"
	1    6350 2850
	-1   0    0    -1  
$EndComp
$Comp
L power:GND #PWR027
U 1 1 61AAF3B3
P 6350 3150
F 0 "#PWR027" H 6350 2900 50  0001 C CNN
F 1 "GND" H 6355 2977 50  0000 C CNN
F 2 "" H 6350 3150 50  0001 C CNN
F 3 "" H 6350 3150 50  0001 C CNN
	1    6350 3150
	1    0    0    -1  
$EndComp
Wire Wire Line
	6350 3150 6350 3000
Text HLabel 6200 2550 0    50   Input ~ 0
SERVO-POWER-EN
Text HLabel 9750 2350 2    50   Output ~ 0
SERVO-VCC
$Comp
L Device:C C6
U 1 1 61ACB33B
P 5700 4900
F 0 "C6" H 5815 4946 50  0000 L CNN
F 1 "22u/25V" H 5815 4855 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 5738 4750 50  0001 C CNN
F 3 "~" H 5700 4900 50  0001 C CNN
F 4 "C45783" H 5700 4900 50  0001 C CNN "LCSC"
	1    5700 4900
	1    0    0    -1  
$EndComp
$Comp
L Device:C C7
U 1 1 61ACC4A3
P 7300 4900
F 0 "C7" H 7415 4946 50  0000 L CNN
F 1 "47u" H 7415 4855 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 7338 4750 50  0001 C CNN
F 3 "~" H 7300 4900 50  0001 C CNN
F 4 " C16780" H 7300 4900 50  0001 C CNN "LCSC"
	1    7300 4900
	1    0    0    -1  
$EndComp
$Comp
L Device:R R10
U 1 1 61AD0B2A
P 2750 2950
F 0 "R10" H 2680 2904 50  0000 R CNN
F 1 "2k2" H 2680 2995 50  0000 R CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 2680 2950 50  0001 C CNN
F 3 "~" H 2750 2950 50  0001 C CNN
F 4 "C17520" H 2750 2950 50  0001 C CNN "LCSC"
	1    2750 2950
	1    0    0    1   
$EndComp
$Comp
L Device:C C5
U 1 1 61AD0E86
P 3050 2950
F 0 "C5" H 3165 2996 50  0000 L CNN
F 1 "100n" H 3165 2905 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder" H 3088 2800 50  0001 C CNN
F 3 "~" H 3050 2950 50  0001 C CNN
F 4 "C49678" H 3050 2950 50  0001 C CNN "LCSC"
	1    3050 2950
	1    0    0    -1  
$EndComp
$Comp
L Diode:BZX84Cxx D11
U 1 1 61AD1913
P 2750 2500
F 0 "D11" V 2704 2420 50  0000 R CNN
F 1 "BZX84C18" V 2795 2420 50  0000 R CNN
F 2 "Diode_SMD:D_SOT-23_ANK" H 2750 2325 50  0001 C CNN
F 3 "https://diotec.com/tl_files/diotec/files/pdf/datasheets/bzx84c2v4.pdf" H 2750 2500 50  0001 C CNN
F 4 "" H 2750 2500 50  0001 C CNN "LCSC"
F 5 "0;0;180" H 2750 2500 50  0001 C CNN "JLCPCB_CORRECTION"
	1    2750 2500
	0    -1   1    0   
$EndComp
Wire Wire Line
	2750 2650 3050 2650
Wire Wire Line
	3250 2650 3250 2600
Connection ~ 2750 2650
Connection ~ 3050 2650
Wire Wire Line
	3050 2650 3250 2650
Wire Wire Line
	3400 2650 3400 3250
Wire Wire Line
	3050 2800 3050 2650
Wire Wire Line
	2750 2800 2750 2650
Wire Wire Line
	2750 3100 2750 3250
Wire Wire Line
	2750 3250 3050 3250
Wire Wire Line
	3050 3100 3050 3250
Connection ~ 3050 3250
Wire Wire Line
	3050 3250 3400 3250
Wire Wire Line
	6200 4650 5700 4650
Wire Wire Line
	6800 4650 7300 4650
$Comp
L power:VCC #PWR030
U 1 1 61B01EA1
P 7300 4550
F 0 "#PWR030" H 7300 4400 50  0001 C CNN
F 1 "VCC" H 7315 4723 50  0000 C CNN
F 2 "" H 7300 4550 50  0001 C CNN
F 3 "" H 7300 4550 50  0001 C CNN
	1    7300 4550
	1    0    0    -1  
$EndComp
Wire Wire Line
	7300 4650 7300 4550
Connection ~ 7300 4650
$Comp
L power:GND #PWR033
U 1 1 61B0A66A
P 7300 5150
F 0 "#PWR033" H 7300 4900 50  0001 C CNN
F 1 "GND" H 7305 4977 50  0000 C CNN
F 2 "" H 7300 5150 50  0001 C CNN
F 3 "" H 7300 5150 50  0001 C CNN
	1    7300 5150
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR032
U 1 1 61B0A8B3
P 6500 5150
F 0 "#PWR032" H 6500 4900 50  0001 C CNN
F 1 "GND" H 6505 4977 50  0000 C CNN
F 2 "" H 6500 5150 50  0001 C CNN
F 3 "" H 6500 5150 50  0001 C CNN
	1    6500 5150
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR031
U 1 1 61B0ABB8
P 5700 5150
F 0 "#PWR031" H 5700 4900 50  0001 C CNN
F 1 "GND" H 5705 4977 50  0000 C CNN
F 2 "" H 5700 5150 50  0001 C CNN
F 3 "" H 5700 5150 50  0001 C CNN
	1    5700 5150
	1    0    0    -1  
$EndComp
$Comp
L Device:D D10
U 1 1 61B23DA3
P 2000 2500
F 0 "D10" V 1954 2580 50  0000 L CNN
F 1 "SS34" V 2045 2580 50  0000 L CNN
F 2 "Diode_SMD:D_SMA_Handsoldering" H 2000 2500 50  0001 C CNN
F 3 "~" H 2000 2500 50  0001 C CNN
F 4 "C8678" H 2000 2500 50  0001 C CNN "LCSC"
	1    2000 2500
	0    1    1    0   
$EndComp
$Comp
L Triac_Thyristor:BT169D Q1
U 1 1 61ACF0B2
P 3400 2500
F 0 "Q1" H 3488 2546 50  0000 L CNN
F 1 "BT148" H 3488 2455 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-223" H 3500 2425 50  0001 L CIN
F 3 "https://media.digikey.com/pdf/Data%20Sheets/NXP%20PDFs/BT169_Series.pdf" H 3400 2500 50  0001 L CNN
F 4 "C256433" H 3400 2500 50  0001 C CNN "LCSC"
	1    3400 2500
	1    0    0    -1  
$EndComp
Wire Wire Line
	3400 2350 3950 2350
Wire Wire Line
	2750 2350 3400 2350
Connection ~ 2750 2350
Connection ~ 3400 2350
$Comp
L Device:Polyfuse F2
U 1 1 61B2DC02
P 1750 2350
F 0 "F2" V 1525 2350 50  0000 C CNN
F 1 "1A/1.8A" V 1616 2350 50  0000 C CNN
F 2 "Fuse:Fuse_1206_3216Metric_Pad1.42x1.75mm_HandSolder" H 1800 2150 50  0001 L CNN
F 3 "~" H 1750 2350 50  0001 C CNN
F 4 "C910830" H 1750 2350 50  0001 C CNN "LCSC"
	1    1750 2350
	0    1    1    0   
$EndComp
Wire Wire Line
	1900 2350 2000 2350
Wire Wire Line
	1600 2350 1450 2350
Text HLabel 1450 2350 0    50   Input ~ 0
+12V
Wire Wire Line
	3950 2350 3950 4650
Text HLabel 9750 4650 2    50   Output ~ 0
VCC
$Comp
L power:GND #PWR029
U 1 1 61B4B123
P 2750 3400
F 0 "#PWR029" H 2750 3150 50  0001 C CNN
F 1 "GND" H 2755 3227 50  0000 C CNN
F 2 "" H 2750 3400 50  0001 C CNN
F 3 "" H 2750 3400 50  0001 C CNN
	1    2750 3400
	1    0    0    -1  
$EndComp
Wire Wire Line
	2000 3250 2000 2650
Connection ~ 2750 3250
Wire Wire Line
	2750 3400 2750 3250
Wire Wire Line
	7300 4750 7300 4650
Wire Wire Line
	7300 5150 7300 5050
Wire Wire Line
	5700 4650 5700 4750
Wire Wire Line
	5700 5050 5700 5150
Wire Wire Line
	6500 5150 6500 4950
$Comp
L Device:Fuse F3
U 1 1 61AAD188
P 8350 2350
F 0 "F3" V 8153 2350 50  0000 C CNN
F 1 "1A" V 8244 2350 50  0000 C CNN
F 2 "Fuse:Fuse_1206_3216Metric_Pad1.42x1.75mm_HandSolder" V 8280 2350 50  0001 C CNN
F 3 "~" H 8350 2350 50  0001 C CNN
F 4 "C182974" H 8350 2350 50  0001 C CNN "LCSC"
	1    8350 2350
	0    1    1    0   
$EndComp
Wire Wire Line
	3950 4650 4700 4650
Connection ~ 5700 4650
Wire Wire Line
	7300 4650 9750 4650
Wire Wire Line
	5000 4650 5700 4650
$Comp
L power:PWR_FLAG #FLG04
U 1 1 6233BB02
P 5700 4650
F 0 "#FLG04" H 5700 4725 50  0001 C CNN
F 1 "PWR_FLAG" H 5700 4823 50  0000 C CNN
F 2 "" H 5700 4650 50  0001 C CNN
F 3 "~" H 5700 4650 50  0001 C CNN
	1    5700 4650
	1    0    0    -1  
$EndComp
$Comp
L power:PWR_FLAG #FLG03
U 1 1 6233E48C
P 2350 2350
F 0 "#FLG03" H 2350 2425 50  0001 C CNN
F 1 "PWR_FLAG" H 2350 2523 50  0000 C CNN
F 2 "" H 2350 2350 50  0001 C CNN
F 3 "~" H 2350 2350 50  0001 C CNN
	1    2350 2350
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_01x04 J5
U 1 1 61B03DFB
P 6450 1650
F 0 "J5" V 6414 1362 50  0000 R CNN
F 1 "Conn_01x04" V 6323 1362 50  0000 R CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x04_P2.54mm_Vertical" H 6450 1650 50  0001 C CNN
F 3 "~" H 6450 1650 50  0001 C CNN
	1    6450 1650
	0    -1   -1   0   
$EndComp
Wire Wire Line
	8500 2350 9750 2350
$Comp
L power:GND #PWR028
U 1 1 61B0CA73
P 6550 3150
F 0 "#PWR028" H 6550 2900 50  0001 C CNN
F 1 "GND" H 6555 2977 50  0000 C CNN
F 2 "" H 6550 3150 50  0001 C CNN
F 3 "" H 6550 3150 50  0001 C CNN
	1    6550 3150
	1    0    0    -1  
$EndComp
Wire Wire Line
	6200 2550 6350 2550
Wire Wire Line
	6350 2550 6350 2700
Text Label 6350 1850 3    50   ~ 0
EN
Text Label 6450 1850 3    50   ~ 0
STEPIN
Text Label 6550 1850 3    50   ~ 0
GND
Text Label 6650 1850 3    50   ~ 0
STEPOUT
Wire Wire Line
	6350 1850 6350 2550
Connection ~ 6350 2550
Wire Wire Line
	6450 1850 6450 2350
Wire Wire Line
	6650 1850 6650 2350
Wire Wire Line
	6550 1850 6550 3150
Wire Wire Line
	6450 2350 3950 2350
Connection ~ 3950 2350
Wire Wire Line
	6650 2350 8200 2350
Text Notes 8050 2500 0    50   ~ 0
Non-reversible
$Comp
L Regulator_Linear:KA78M05_TO252 U3
U 1 1 61BB8EA3
P 6500 4650
F 0 "U3" H 6500 4892 50  0000 C CNN
F 1 "KA78M05_TO252" H 6500 4801 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:TO-252-2" H 6500 4875 50  0001 C CIN
F 3 "https://www.onsemi.com/pub/Collateral/MC78M00-D.PDF" H 6500 4600 50  0001 C CNN
F 4 "C58069" H 6500 4650 50  0001 C CNN "LCSC"
	1    6500 4650
	1    0    0    -1  
$EndComp
Connection ~ 2000 2350
$Comp
L Device:C C10
U 1 1 61CE7F32
P 2350 2950
F 0 "C10" H 2465 2996 50  0000 L CNN
F 1 "100n" H 2465 2905 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder" H 2388 2800 50  0001 C CNN
F 3 "~" H 2350 2950 50  0001 C CNN
F 4 "C49678" H 2350 2950 50  0001 C CNN "LCSC"
	1    2350 2950
	-1   0    0    -1  
$EndComp
Wire Wire Line
	2350 3100 2350 3250
Wire Wire Line
	2350 2800 2350 2350
Connection ~ 2350 2350
Wire Wire Line
	2350 2350 2750 2350
Connection ~ 2350 3250
Wire Wire Line
	2350 3250 2750 3250
Wire Wire Line
	2000 3250 2350 3250
Wire Wire Line
	2000 2350 2350 2350
$Comp
L Diode:1N4007 D7
U 1 1 61D76032
P 4850 4650
F 0 "D7" H 4850 4433 50  0000 C CNN
F 1 "1N4007" H 4850 4524 50  0000 C CNN
F 2 "Diode_SMD:D_SOD-123" H 4850 4475 50  0001 C CNN
F 3 "http://www.vishay.com/docs/88503/1n4001.pdf" H 4850 4650 50  0001 C CNN
F 4 "C64898" H 4850 4650 50  0001 C CNN "LCSC"
	1    4850 4650
	-1   0    0    1   
$EndComp
Text Notes 6150 1450 0    50   ~ 0
External stepdown
Text Notes 6150 1550 0    50   ~ 0
5-18 V, min 1 A
Text Notes 5900 4250 0    100  ~ 0
Power for logic
Text Notes 5600 1300 0    100  ~ 0
Power for servo & relay
$EndSCHEMATC
