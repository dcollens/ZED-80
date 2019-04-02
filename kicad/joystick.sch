EESchema Schematic File Version 4
LIBS:z80-cache
EELAYER 29 0
EELAYER END
$Descr USLetter 11000 8500
encoding utf-8
Sheet 2 11
Title "Joystick Ports"
Date "2018-07-20"
Rev "12"
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L 74xx:74LS541 U13
U 1 1 59D6AABB
P 4850 2650
F 0 "U13" H 5050 3300 50  0000 C CNN
F 1 "74AHC541" H 4650 2000 50  0000 C CNN
F 2 "Housings_DIP:DIP-20_W7.62mm_LongPads" H 4850 2650 50  0001 C CNN
F 3 "" H 4850 2650 50  0001 C CNN
	1    4850 2650
	-1   0    0    -1  
$EndComp
$Comp
L Connector:DB9_Male_MountingHoles JOY1
U 1 1 59D6AAC2
P 7050 2400
F 0 "JOY1" H 7050 3050 50  0000 C CNN
F 1 "DB9-M" H 7050 2975 50  0000 C CNN
F 2 "z80_footprints:L717SDE09P1ACH" H 7050 2400 50  0001 C CNN
F 3 "" H 7050 2400 50  0001 C CNN
	1    7050 2400
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR024
U 1 1 59D6AAC9
P 7050 3000
F 0 "#PWR024" H 7050 2750 50  0001 C CNN
F 1 "GND" H 7050 2850 50  0000 C CNN
F 2 "" H 7050 3000 50  0001 C CNN
F 3 "" H 7050 3000 50  0001 C CNN
	1    7050 3000
	1    0    0    -1  
$EndComp
Entry Wire Line
	3700 2950 3800 2850
Entry Wire Line
	3700 2850 3800 2750
Entry Wire Line
	3700 2750 3800 2650
Entry Wire Line
	3700 2650 3800 2550
Entry Wire Line
	3700 2550 3800 2450
Entry Wire Line
	3700 2450 3800 2350
Entry Wire Line
	3700 2350 3800 2250
Entry Wire Line
	3700 2250 3800 2150
Text Label 3800 2150 0    60   ~ 0
D0
Text Label 3800 2250 0    60   ~ 0
D1
Text Label 3800 2350 0    60   ~ 0
D2
Text Label 3800 2450 0    60   ~ 0
D3
Text Label 3800 2550 0    60   ~ 0
D4
Text Label 3800 2650 0    60   ~ 0
D5
Text Label 3800 2750 0    60   ~ 0
D6
Text Label 3800 2850 0    60   ~ 0
D7
Wire Wire Line
	5350 3050 5650 3050
Text Label 5650 3050 2    60   ~ 0
~RD
$Comp
L Device:R R2
U 1 1 59D6AAEA
P 5450 1900
F 0 "R2" V 5530 1900 50  0000 C CNN
F 1 "10K" V 5450 1900 50  0000 C CNN
F 2 "Resistors_THT:R_Axial_DIN0204_L3.6mm_D1.6mm_P5.08mm_Horizontal" V 5380 1900 50  0001 C CNN
F 3 "" H 5450 1900 50  0001 C CNN
	1    5450 1900
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR025
U 1 1 59D6AAF1
P 5450 1750
F 0 "#PWR025" H 5450 1600 50  0001 C CNN
F 1 "VCC" H 5450 1900 50  0000 C CNN
F 2 "" H 5450 1750 50  0001 C CNN
F 3 "" H 5450 1750 50  0001 C CNN
	1    5450 1750
	1    0    0    -1  
$EndComp
$Comp
L Device:R R4
U 1 1 59D6AAF7
P 5650 1900
F 0 "R4" V 5730 1900 50  0000 C CNN
F 1 "10K" V 5650 1900 50  0000 C CNN
F 2 "Resistors_THT:R_Axial_DIN0204_L3.6mm_D1.6mm_P5.08mm_Horizontal" V 5580 1900 50  0001 C CNN
F 3 "" H 5650 1900 50  0001 C CNN
	1    5650 1900
	1    0    0    -1  
$EndComp
$Comp
L Device:R R6
U 1 1 59D6AAFE
P 5850 1900
F 0 "R6" V 5930 1900 50  0000 C CNN
F 1 "10K" V 5850 1900 50  0000 C CNN
F 2 "Resistors_THT:R_Axial_DIN0204_L3.6mm_D1.6mm_P5.08mm_Horizontal" V 5780 1900 50  0001 C CNN
F 3 "" H 5850 1900 50  0001 C CNN
	1    5850 1900
	1    0    0    -1  
$EndComp
$Comp
L Device:R R8
U 1 1 59D6AB05
P 6050 1900
F 0 "R8" V 6130 1900 50  0000 C CNN
F 1 "10K" V 6050 1900 50  0000 C CNN
F 2 "Resistors_THT:R_Axial_DIN0204_L3.6mm_D1.6mm_P5.08mm_Horizontal" V 5980 1900 50  0001 C CNN
F 3 "" H 6050 1900 50  0001 C CNN
	1    6050 1900
	1    0    0    -1  
$EndComp
$Comp
L Device:R R10
U 1 1 59D6AB0C
P 6250 1900
F 0 "R10" V 6330 1900 50  0000 C CNN
F 1 "10K" V 6250 1900 50  0000 C CNN
F 2 "Resistors_THT:R_Axial_DIN0204_L3.6mm_D1.6mm_P5.08mm_Horizontal" V 6180 1900 50  0001 C CNN
F 3 "" H 6250 1900 50  0001 C CNN
	1    6250 1900
	1    0    0    -1  
$EndComp
Wire Wire Line
	5450 1750 5650 1750
Connection ~ 6050 1750
Connection ~ 5850 1750
Connection ~ 5650 1750
Wire Wire Line
	5350 2150 5450 2150
Wire Wire Line
	5450 2150 5450 2050
Wire Wire Line
	5350 2250 5650 2250
Wire Wire Line
	5650 2250 5650 2050
Wire Wire Line
	5350 2350 5850 2350
Wire Wire Line
	5850 2350 5850 2050
Wire Wire Line
	5350 2450 6050 2450
Wire Wire Line
	6050 2450 6050 2050
Wire Wire Line
	5350 2550 6250 2550
Wire Wire Line
	6250 2550 6250 2050
$Comp
L power:GND #PWR026
U 1 1 59D6AB23
P 5400 2850
F 0 "#PWR026" H 5400 2600 50  0001 C CNN
F 1 "GND" H 5400 2700 50  0000 C CNN
F 2 "" H 5400 2850 50  0001 C CNN
F 3 "" H 5400 2850 50  0001 C CNN
	1    5400 2850
	1    0    0    -1  
$EndComp
Wire Wire Line
	6750 2800 6500 2800
Wire Wire Line
	6500 2800 6500 2150
Connection ~ 5450 2150
Wire Wire Line
	6450 2250 6450 2600
Wire Wire Line
	6450 2600 6750 2600
Connection ~ 5650 2250
Wire Wire Line
	6750 2400 6400 2400
Wire Wire Line
	6400 2400 6400 2350
Connection ~ 5850 2350
Wire Wire Line
	6750 2200 6350 2200
Wire Wire Line
	6350 2200 6350 2450
Connection ~ 6050 2450
Wire Wire Line
	6750 2700 6300 2700
Wire Wire Line
	6300 2700 6300 2550
Connection ~ 6250 2550
Wire Wire Line
	6750 2300 6700 2300
Wire Wire Line
	6700 2300 6700 3000
Wire Wire Line
	6700 3000 7050 3000
NoConn ~ 6750 2500
NoConn ~ 6750 2100
NoConn ~ 6750 2000
$Comp
L 74xx:74LS541 U14
U 1 1 59D6AB41
P 4850 4700
F 0 "U14" H 5050 5350 50  0000 C BNN
F 1 "74AHC541" H 4650 4050 50  0000 C TNN
F 2 "Housings_DIP:DIP-20_W7.62mm_LongPads" H 4850 4700 50  0001 C CNN
F 3 "" H 4850 4700 50  0001 C CNN
	1    4850 4700
	-1   0    0    -1  
$EndComp
$Comp
L Connector:DB9_Male_MountingHoles JOY2
U 1 1 59D6AB48
P 7050 4450
F 0 "JOY2" H 7050 5100 50  0000 C CNN
F 1 "DB9-M" H 7050 5025 50  0000 C CNN
F 2 "z80_footprints:L717SDE09P1ACH" H 7050 4450 50  0001 C CNN
F 3 "" H 7050 4450 50  0001 C CNN
	1    7050 4450
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR027
U 1 1 59D6AB4F
P 7050 5050
F 0 "#PWR027" H 7050 4800 50  0001 C CNN
F 1 "GND" H 7050 4900 50  0000 C CNN
F 2 "" H 7050 5050 50  0001 C CNN
F 3 "" H 7050 5050 50  0001 C CNN
	1    7050 5050
	1    0    0    -1  
$EndComp
Entry Wire Line
	3700 5000 3800 4900
Entry Wire Line
	3700 4900 3800 4800
Entry Wire Line
	3700 4800 3800 4700
Entry Wire Line
	3700 4700 3800 4600
Entry Wire Line
	3700 4600 3800 4500
Entry Wire Line
	3700 4500 3800 4400
Entry Wire Line
	3700 4400 3800 4300
Entry Wire Line
	3700 4300 3800 4200
Text Label 3800 4200 0    60   ~ 0
D0
Text Label 3800 4300 0    60   ~ 0
D1
Text Label 3800 4400 0    60   ~ 0
D2
Text Label 3800 4500 0    60   ~ 0
D3
Text Label 3800 4600 0    60   ~ 0
D4
Text Label 3800 4700 0    60   ~ 0
D5
Text Label 3800 4800 0    60   ~ 0
D6
Text Label 3800 4900 0    60   ~ 0
D7
Wire Wire Line
	5350 5100 5750 5100
Text Label 5650 5100 2    60   ~ 0
~RD
$Comp
L Device:R R3
U 1 1 59D6AB70
P 5450 3950
F 0 "R3" V 5530 3950 50  0000 C CNN
F 1 "10K" V 5450 3950 50  0000 C CNN
F 2 "Resistors_THT:R_Axial_DIN0204_L3.6mm_D1.6mm_P5.08mm_Horizontal" V 5380 3950 50  0001 C CNN
F 3 "" H 5450 3950 50  0001 C CNN
	1    5450 3950
	1    0    0    -1  
$EndComp
$Comp
L Device:R R5
U 1 1 59D6AB77
P 5650 3950
F 0 "R5" V 5730 3950 50  0000 C CNN
F 1 "10K" V 5650 3950 50  0000 C CNN
F 2 "Resistors_THT:R_Axial_DIN0204_L3.6mm_D1.6mm_P5.08mm_Horizontal" V 5580 3950 50  0001 C CNN
F 3 "" H 5650 3950 50  0001 C CNN
	1    5650 3950
	1    0    0    -1  
$EndComp
$Comp
L Device:R R7
U 1 1 59D6AB7E
P 5850 3950
F 0 "R7" V 5930 3950 50  0000 C CNN
F 1 "10K" V 5850 3950 50  0000 C CNN
F 2 "Resistors_THT:R_Axial_DIN0204_L3.6mm_D1.6mm_P5.08mm_Horizontal" V 5780 3950 50  0001 C CNN
F 3 "" H 5850 3950 50  0001 C CNN
	1    5850 3950
	1    0    0    -1  
$EndComp
$Comp
L Device:R R9
U 1 1 59D6AB85
P 6050 3950
F 0 "R9" V 6130 3950 50  0000 C CNN
F 1 "10K" V 6050 3950 50  0000 C CNN
F 2 "Resistors_THT:R_Axial_DIN0204_L3.6mm_D1.6mm_P5.08mm_Horizontal" V 5980 3950 50  0001 C CNN
F 3 "" H 6050 3950 50  0001 C CNN
	1    6050 3950
	1    0    0    -1  
$EndComp
$Comp
L Device:R R11
U 1 1 59D6AB8C
P 6250 3950
F 0 "R11" V 6330 3950 50  0000 C CNN
F 1 "10K" V 6250 3950 50  0000 C CNN
F 2 "Resistors_THT:R_Axial_DIN0204_L3.6mm_D1.6mm_P5.08mm_Horizontal" V 6180 3950 50  0001 C CNN
F 3 "" H 6250 3950 50  0001 C CNN
	1    6250 3950
	1    0    0    -1  
$EndComp
Wire Wire Line
	5350 4200 5450 4200
Wire Wire Line
	5450 4200 5450 4100
Wire Wire Line
	5350 4300 5650 4300
Wire Wire Line
	5650 4300 5650 4100
Wire Wire Line
	5350 4400 5850 4400
Wire Wire Line
	5850 4400 5850 4100
Wire Wire Line
	5350 4500 6050 4500
Wire Wire Line
	6050 4500 6050 4100
Wire Wire Line
	5350 4600 6250 4600
Wire Wire Line
	6250 4600 6250 4100
Wire Wire Line
	5350 5200 5650 5200
$Comp
L power:GND #PWR028
U 1 1 59D6AB9F
P 5500 4700
F 0 "#PWR028" H 5500 4450 50  0001 C CNN
F 1 "GND" H 5500 4550 50  0000 C CNN
F 2 "" H 5500 4700 50  0001 C CNN
F 3 "" H 5500 4700 50  0001 C CNN
	1    5500 4700
	1    0    0    -1  
$EndComp
Wire Wire Line
	5350 4700 5500 4700
Wire Wire Line
	6750 4850 6500 4850
Wire Wire Line
	6500 4850 6500 4200
Connection ~ 5450 4200
Wire Wire Line
	6450 4300 6450 4650
Wire Wire Line
	6450 4650 6750 4650
Connection ~ 5650 4300
Wire Wire Line
	6750 4450 6400 4450
Wire Wire Line
	6400 4450 6400 4400
Connection ~ 5850 4400
Wire Wire Line
	6750 4250 6350 4250
Wire Wire Line
	6350 4250 6350 4500
Connection ~ 6050 4500
Wire Wire Line
	6750 4750 6300 4750
Wire Wire Line
	6300 4750 6300 4600
Connection ~ 6250 4600
Wire Wire Line
	6750 4350 6700 4350
Wire Wire Line
	6700 4350 6700 5050
Wire Wire Line
	6700 5050 7050 5050
NoConn ~ 6750 4550
NoConn ~ 6750 4150
NoConn ~ 6750 4050
$Comp
L power:VCC #PWR029
U 1 1 59D6ABBD
P 5450 3800
F 0 "#PWR029" H 5450 3650 50  0001 C CNN
F 1 "VCC" H 5450 3950 50  0000 C CNN
F 2 "" H 5450 3800 50  0001 C CNN
F 3 "" H 5450 3800 50  0001 C CNN
	1    5450 3800
	1    0    0    -1  
$EndComp
Wire Wire Line
	5450 3800 5650 3800
Connection ~ 5650 3800
Connection ~ 5850 3800
Connection ~ 6050 3800
Text HLabel 2850 5100 0    60   BiDi ~ 0
D[0..7]
Text HLabel 2850 5900 0    60   Input ~ 0
~RD
Wire Wire Line
	2850 5900 5750 5900
Text HLabel 2850 6000 0    60   Input ~ 0
~IORQ0
Text HLabel 2850 5800 0    60   Input ~ 0
~IORQ1
Wire Wire Line
	5650 5800 2850 5800
Wire Bus Line
	3700 5100 2850 5100
$Comp
L Device:C C8
U 1 1 59D817E3
P 5150 1050
F 0 "C8" H 5175 1150 50  0000 L CNN
F 1 "0.1uF" H 5175 950 50  0000 L CNN
F 2 "Capacitors_THT:C_Disc_D4.3mm_W1.9mm_P5.00mm" H 5188 900 50  0001 C CNN
F 3 "" H 5150 1050 50  0001 C CNN
	1    5150 1050
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR030
U 1 1 59D817EA
P 4900 1200
F 0 "#PWR030" H 4900 950 50  0001 C CNN
F 1 "GND" H 4900 1050 50  0000 C CNN
F 2 "" H 4900 1200 50  0001 C CNN
F 3 "" H 4900 1200 50  0001 C CNN
	1    4900 1200
	1    0    0    -1  
$EndComp
$Comp
L Device:C C9
U 1 1 59D817F0
P 5450 1050
F 0 "C9" H 5475 1150 50  0000 L CNN
F 1 "0.1uF" H 5475 950 50  0000 L CNN
F 2 "Capacitors_THT:C_Disc_D4.3mm_W1.9mm_P5.00mm" H 5488 900 50  0001 C CNN
F 3 "" H 5450 1050 50  0001 C CNN
	1    5450 1050
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR031
U 1 1 59D817F7
P 4900 900
F 0 "#PWR031" H 4900 750 50  0001 C CNN
F 1 "VCC" H 4900 1050 50  0000 C CNN
F 2 "" H 4900 900 50  0001 C CNN
F 3 "" H 4900 900 50  0001 C CNN
	1    4900 900 
	1    0    0    -1  
$EndComp
Text Notes 5100 850  0    60   ~ 0
Near\nU13
Text Notes 5400 850  0    60   ~ 0
Near\nU14
Connection ~ 5150 900 
Connection ~ 5150 1200
Wire Wire Line
	4900 1200 5150 1200
Wire Wire Line
	4900 900  5150 900 
Wire Wire Line
	6050 1750 6250 1750
Wire Wire Line
	5850 1750 6050 1750
Wire Wire Line
	5650 1750 5850 1750
Wire Wire Line
	5450 2150 6500 2150
Wire Wire Line
	5650 2250 6450 2250
Wire Wire Line
	5850 2350 6400 2350
Wire Wire Line
	6050 2450 6350 2450
Wire Wire Line
	6250 2550 6300 2550
Wire Wire Line
	5450 4200 6500 4200
Wire Wire Line
	5650 4300 6450 4300
Wire Wire Line
	5850 4400 6400 4400
Wire Wire Line
	6050 4500 6350 4500
Wire Wire Line
	6250 4600 6300 4600
Wire Wire Line
	5650 3800 5850 3800
Wire Wire Line
	5850 3800 6050 3800
Wire Wire Line
	6050 3800 6250 3800
Wire Wire Line
	5150 900  5450 900 
Wire Wire Line
	5150 1200 5450 1200
Wire Wire Line
	5350 4900 5350 4800
Wire Wire Line
	5350 4800 5350 4700
Connection ~ 5350 4800
Connection ~ 5350 4700
Wire Wire Line
	3800 2150 4350 2150
Wire Wire Line
	3800 2250 4350 2250
Wire Wire Line
	3800 2350 4350 2350
Wire Wire Line
	3800 2450 4350 2450
Wire Wire Line
	3800 2550 4350 2550
Wire Wire Line
	3800 2650 4350 2650
Wire Wire Line
	3800 2750 4350 2750
Wire Wire Line
	3800 2850 4350 2850
Wire Wire Line
	3800 4200 4350 4200
Wire Wire Line
	3800 4300 4350 4300
Wire Wire Line
	3800 4400 4350 4400
Wire Wire Line
	3800 4500 4350 4500
Wire Wire Line
	3800 4600 4350 4600
Wire Wire Line
	3800 4700 4350 4700
Wire Wire Line
	3800 4800 4350 4800
Wire Wire Line
	3800 4900 4350 4900
$Comp
L power:VCC #PWR0103
U 1 1 5C43BA0C
P 4850 1850
F 0 "#PWR0103" H 4850 1700 50  0001 C CNN
F 1 "VCC" H 4867 2023 50  0000 C CNN
F 2 "" H 4850 1850 50  0001 C CNN
F 3 "" H 4850 1850 50  0001 C CNN
	1    4850 1850
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0104
U 1 1 5C43BA65
P 4850 3900
F 0 "#PWR0104" H 4850 3750 50  0001 C CNN
F 1 "VCC" H 4867 4073 50  0000 C CNN
F 2 "" H 4850 3900 50  0001 C CNN
F 3 "" H 4850 3900 50  0001 C CNN
	1    4850 3900
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0105
U 1 1 5C43BAC5
P 4850 5500
F 0 "#PWR0105" H 4850 5250 50  0001 C CNN
F 1 "GND" H 4855 5327 50  0000 C CNN
F 2 "" H 4850 5500 50  0001 C CNN
F 3 "" H 4850 5500 50  0001 C CNN
	1    4850 5500
	1    0    0    -1  
$EndComp
Wire Wire Line
	5750 5100 5750 5900
Wire Wire Line
	5650 5200 5650 5800
Connection ~ 5450 1750
Connection ~ 7050 3000
$Comp
L power:GND #PWR0106
U 1 1 5C455062
P 4850 3450
F 0 "#PWR0106" H 4850 3200 50  0001 C CNN
F 1 "GND" H 4855 3277 50  0000 C CNN
F 2 "" H 4850 3450 50  0001 C CNN
F 3 "" H 4850 3450 50  0001 C CNN
	1    4850 3450
	1    0    0    -1  
$EndComp
Wire Wire Line
	5400 2850 5350 2850
Wire Wire Line
	2850 6000 7400 6000
Wire Wire Line
	5350 3150 5350 3550
Wire Wire Line
	5350 3550 7400 3550
Wire Wire Line
	7400 3550 7400 6000
Wire Wire Line
	5350 2750 5800 2750
Wire Wire Line
	5800 2750 5800 3450
Wire Wire Line
	5800 3450 7500 3450
Wire Wire Line
	7500 3450 7500 6100
Wire Wire Line
	7500 6100 2850 6100
Wire Wire Line
	5350 2650 5900 2650
Wire Wire Line
	5900 2650 5900 3350
Wire Wire Line
	5900 3350 7600 3350
Wire Wire Line
	7600 3350 7600 6200
Wire Wire Line
	7600 6200 2850 6200
Text HLabel 2850 6100 0    60   Input ~ 0
~SDCD
Text HLabel 2850 6200 0    60   Input ~ 0
~SDWP
Wire Bus Line
	3700 2250 3700 5100
$EndSCHEMATC