EESchema Schematic File Version 4
EELAYER 29 0
EELAYER END
$Descr USLetter 11000 8500
encoding utf-8
Sheet 7 11
Title "Power, reset, and spares"
Date "2019-04-03"
Rev "1"
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L power:GND #PWR072
U 1 1 59EFCC3B
P 800 2350
F 0 "#PWR072" H 800 2100 50  0001 C CNN
F 1 "GND" H 800 2200 50  0000 C CNN
F 2 "" H 800 2350 50  0001 C CNN
F 3 "" H 800 2350 50  0001 C CNN
	1    800  2350
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS08 U16
U 2 1 59EFCC41
P 1100 950
F 0 "U16" H 1100 1000 50  0000 C CNN
F 1 "74AHC08" H 1100 900 50  0000 C CNN
F 2 "Housings_DIP:DIP-14_W7.62mm" H 1100 950 50  0001 C CNN
F 3 "" H 1100 950 50  0001 C CNN
	2    1100 950 
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS08 U16
U 3 1 59EFCC48
P 1100 1400
F 0 "U16" H 1100 1450 50  0000 C CNN
F 1 "74AHC08" H 1100 1350 50  0000 C CNN
F 2 "Housings_DIP:DIP-14_W7.62mm" H 1100 1400 50  0001 C CNN
F 3 "" H 1100 1400 50  0001 C CNN
	3    1100 1400
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS08 U16
U 4 1 59EFCC4F
P 1100 1900
F 0 "U16" H 1100 1950 50  0000 C CNN
F 1 "74AHC08" H 1100 1850 50  0000 C CNN
F 2 "Housings_DIP:DIP-14_W7.62mm" H 1100 1900 50  0001 C CNN
F 3 "" H 1100 1900 50  0001 C CNN
	4    1100 1900
	1    0    0    -1  
$EndComp
NoConn ~ 1400 1900
NoConn ~ 1400 1400
NoConn ~ 1400 950 
$Comp
L 74xx:74HC02 U9
U 4 1 59EFDB83
P 1900 950
AR Path="/59EFDB83" Ref="U9"  Part="4" 
AR Path="/59EFC926/59EFDB83" Ref="U9"  Part="4" 
F 0 "U9" H 1900 1000 50  0000 C CNN
F 1 "74AHC02" H 1950 900 50  0000 C CNN
F 2 "Housings_DIP:DIP-14_W7.62mm" H 1900 950 50  0001 C CNN
F 3 "" H 1900 950 50  0001 C CNN
	4    1900 950 
	1    0    0    -1  
$EndComp
NoConn ~ 2200 950 
$Comp
L power:GND #PWR074
U 1 1 59EFDC50
P 1600 1350
F 0 "#PWR074" H 1600 1100 50  0001 C CNN
F 1 "GND" H 1600 1200 50  0000 C CNN
F 2 "" H 1600 1350 50  0001 C CNN
F 3 "" H 1600 1350 50  0001 C CNN
	1    1600 1350
	1    0    0    -1  
$EndComp
Wire Wire Line
	1600 1050 1600 1350
Wire Wire Line
	1600 850  1600 1050
Connection ~ 1600 1050
Wire Wire Line
	800  1050 800  1300
Wire Wire Line
	800  1500 800  1800
Wire Wire Line
	800  2000 800  2350
Wire Wire Line
	800  850  800  1050
Connection ~ 800  1050
Wire Wire Line
	800  1300 800  1500
Connection ~ 800  1300
Connection ~ 800  1500
Wire Wire Line
	800  1800 800  2000
Connection ~ 800  1800
Connection ~ 800  2000
$Comp
L Device:LED_Small_ALT D?
U 1 1 5CB1CF93
P 6550 1150
AR Path="/5CB1CF93" Ref="D?"  Part="1" 
AR Path="/59EFC926/5CB1CF93" Ref="D1"  Part="1" 
F 0 "D1" H 6500 1275 50  0000 L CNN
F 1 "Green" H 6550 1052 50  0000 C CNN
F 2 "LEDs:LED_D5.0mm" V 6550 1150 50  0001 C CNN
F 3 "" V 6550 1150 50  0001 C CNN
	1    6550 1150
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5CB1CF9A
P 6550 1550
AR Path="/5CB1CF9A" Ref="#PWR?"  Part="1" 
AR Path="/59EFC926/5CB1CF9A" Ref="#PWR023"  Part="1" 
F 0 "#PWR023" H 6550 1300 50  0001 C CNN
F 1 "GND" H 6550 1400 50  0000 C CNN
F 2 "" H 6550 1550 50  0001 C CNN
F 3 "" H 6550 1550 50  0001 C CNN
	1    6550 1550
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 5CB1CFA0
P 6550 950
AR Path="/5CB1CFA0" Ref="#PWR?"  Part="1" 
AR Path="/59EFC926/5CB1CFA0" Ref="#PWR022"  Part="1" 
F 0 "#PWR022" H 6550 800 50  0001 C CNN
F 1 "VCC" H 6550 1100 50  0000 C CNN
F 2 "" H 6550 950 50  0001 C CNN
F 3 "" H 6550 950 50  0001 C CNN
	1    6550 950 
	1    0    0    -1  
$EndComp
$Comp
L Device:R R?
U 1 1 5CB1CFA6
P 6550 1400
AR Path="/5CB1CFA6" Ref="R?"  Part="1" 
AR Path="/59EFC926/5CB1CFA6" Ref="R18"  Part="1" 
F 0 "R18" V 6630 1400 50  0000 C CNN
F 1 "10K" V 6550 1400 50  0000 C CNN
F 2 "Resistors_SMD:R_0805_HandSoldering" V 6480 1400 50  0001 C CNN
F 3 "" H 6550 1400 50  0001 C CNN
	1    6550 1400
	1    0    0    -1  
$EndComp
NoConn ~ 6300 1150
NoConn ~ 6300 1250
$Comp
L Connector_Generic:Conn_01x02 J?
U 1 1 5CB1CFAF
P 7300 1300
AR Path="/5CB1CFAF" Ref="J?"  Part="1" 
AR Path="/59EFC926/5CB1CFAF" Ref="J6"  Part="1" 
F 0 "J6" H 7300 1400 50  0000 C CNN
F 1 "PWR" H 7300 1100 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_2x01_Pitch2.54mm" H 7300 1300 50  0001 C CNN
F 3 "" H 7300 1300 50  0001 C CNN
	1    7300 1300
	1    0    0    1   
$EndComp
$Comp
L Connector:USB_B J?
U 1 1 5CB1CFBD
P 6000 1150
AR Path="/5CB1CFBD" Ref="J?"  Part="1" 
AR Path="/59EFC926/5CB1CFBD" Ref="J5"  Part="1" 
F 0 "J5" H 5800 1600 50  0000 L CNN
F 1 "USB_B" H 5800 1500 50  0000 L CNN
F 2 "z80_footprints:USB_B_E8144-B02022-L" H 6150 1100 50  0001 C CNN
F 3 "" H 6150 1100 50  0001 C CNN
	1    6000 1150
	1    0    0    -1  
$EndComp
$Comp
L power:+3V3 #PWR?
U 1 1 5CB1CFCB
P 8750 950
AR Path="/5CB1CFCB" Ref="#PWR?"  Part="1" 
AR Path="/59EFC926/5CB1CFCB" Ref="#PWR096"  Part="1" 
F 0 "#PWR096" H 8750 800 50  0001 C CNN
F 1 "+3V3" H 8750 1090 50  0000 C CNN
F 2 "" H 8750 950 50  0001 C CNN
F 3 "" H 8750 950 50  0001 C CNN
	1    8750 950 
	1    0    0    -1  
$EndComp
$Comp
L Device:C C?
U 1 1 5CB1CFD1
P 8950 1200
AR Path="/5CB1CFD1" Ref="C?"  Part="1" 
AR Path="/59EFC926/5CB1CFD1" Ref="C30"  Part="1" 
F 0 "C30" H 8975 1300 50  0000 L CNN
F 1 "4.7uF" H 8975 1100 50  0000 L CNN
F 2 "Capacitors_SMD:C_0805_HandSoldering" H 8988 1050 50  0001 C CNN
F 3 "" H 8950 1200 50  0001 C CNN
	1    8950 1200
	1    0    0    -1  
$EndComp
Wire Wire Line
	5900 1550 6000 1550
Connection ~ 6000 1550
Wire Wire Line
	6300 950  6550 950 
Connection ~ 6550 1550
Wire Wire Line
	6550 950  6550 1050
Wire Wire Line
	7100 950  7100 1200
Connection ~ 6550 950 
Wire Wire Line
	7100 1550 7100 1300
Connection ~ 7100 950 
Wire Wire Line
	8950 950  8950 1050
Connection ~ 8750 950 
Wire Wire Line
	8950 1550 8950 1350
Connection ~ 8150 1550
Wire Wire Line
	6000 1550 6550 1550
Wire Wire Line
	8750 950  8950 950 
Wire Wire Line
	8150 1550 8950 1550
$Comp
L Switch:SW_Push SW?
U 1 1 5CB6E60F
P 6100 2850
AR Path="/5CB6E60F" Ref="SW?"  Part="1" 
AR Path="/59EFC926/5CB6E60F" Ref="SW1"  Part="1" 
F 0 "SW1" H 6150 2950 50  0000 L CNN
F 1 "KS01Q" H 6100 2790 50  0000 C CNN
F 2 "z80_footprints:KS-01Q-02" H 6100 3050 50  0001 C CNN
F 3 "" H 6100 3050 50  0001 C CNN
	1    6100 2850
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HC14 U?
U 1 1 5CB6E616
P 6900 2850
AR Path="/5CB6E616" Ref="U?"  Part="1" 
AR Path="/59EFC926/5CB6E616" Ref="U2"  Part="1" 
F 0 "U2" H 7050 2950 50  0000 C CNN
F 1 "74AHC14" H 7100 2750 50  0000 C CNN
F 2 "Housings_DIP:DIP-14_W7.62mm" H 6900 2850 50  0001 C CNN
F 3 "http://www.ti.com/lit/ds/symlink/sn74ahc14.pdf" H 6900 2850 50  0001 C CNN
	1    6900 2850
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5CB6E61D
P 5900 3400
AR Path="/5CB6E61D" Ref="#PWR?"  Part="1" 
AR Path="/59EFC926/5CB6E61D" Ref="#PWR02"  Part="1" 
F 0 "#PWR02" H 5900 3150 50  0001 C CNN
F 1 "GND" H 5900 3250 50  0000 C CNN
F 2 "" H 5900 3400 50  0001 C CNN
F 3 "" H 5900 3400 50  0001 C CNN
	1    5900 3400
	1    0    0    -1  
$EndComp
$Comp
L Device:C C?
U 1 1 5CB6E623
P 6450 3150
AR Path="/5CB6E623" Ref="C?"  Part="1" 
AR Path="/59EFC926/5CB6E623" Ref="C1"  Part="1" 
F 0 "C1" H 6475 3250 50  0000 L CNN
F 1 "0.1uF" H 6475 3050 50  0000 L CNN
F 2 "Capacitors_THT:C_Disc_D4.3mm_W1.9mm_P5.00mm" H 6488 3000 50  0001 C CNN
F 3 "" H 6450 3150 50  0001 C CNN
	1    6450 3150
	1    0    0    -1  
$EndComp
$Comp
L Device:R R?
U 1 1 5CB6E62A
P 6450 2550
AR Path="/5CB6E62A" Ref="R?"  Part="1" 
AR Path="/59EFC926/5CB6E62A" Ref="R1"  Part="1" 
F 0 "R1" V 6530 2550 50  0000 C CNN
F 1 "1M" V 6450 2550 50  0000 C CNN
F 2 "Resistors_THT:R_Axial_DIN0204_L3.6mm_D1.6mm_P5.08mm_Horizontal" V 6380 2550 50  0001 C CNN
F 3 "" H 6450 2550 50  0001 C CNN
	1    6450 2550
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 5CB6E631
P 6450 2400
AR Path="/5CB6E631" Ref="#PWR?"  Part="1" 
AR Path="/59EFC926/5CB6E631" Ref="#PWR07"  Part="1" 
F 0 "#PWR07" H 6450 2250 50  0001 C CNN
F 1 "VCC" H 6450 2550 50  0000 C CNN
F 2 "" H 6450 2400 50  0001 C CNN
F 3 "" H 6450 2400 50  0001 C CNN
	1    6450 2400
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HC14 U?
U 2 1 5CB6E637
P 7900 2850
AR Path="/5CB6E637" Ref="U?"  Part="2" 
AR Path="/59EFC926/5CB6E637" Ref="U2"  Part="2" 
F 0 "U2" H 8050 2950 50  0000 C CNN
F 1 "74AHC14" H 8100 2750 50  0000 C CNN
F 2 "Housings_DIP:DIP-14_W7.62mm" H 7900 2850 50  0001 C CNN
F 3 "" H 7900 2850 50  0001 C CNN
	2    7900 2850
	1    0    0    -1  
$EndComp
Wire Wire Line
	6300 2850 6450 2850
Connection ~ 6450 2850
Wire Wire Line
	6450 2700 6450 2850
Wire Wire Line
	5900 2850 5900 3300
Wire Wire Line
	5900 3300 6450 3300
Connection ~ 5900 3300
Wire Wire Line
	6450 2850 6450 3000
Wire Wire Line
	5900 3300 5900 3400
Wire Wire Line
	6450 2850 6600 2850
Wire Wire Line
	7200 2850 7600 2850
Wire Wire Line
	8200 2850 8350 2850
Text HLabel 8350 2850 2    60   Output ~ 0
~RESET
$Comp
L 74xx:74LS32 U4
U 4 1 5CDB7434
P 3750 950
AR Path="/59EFC926/5CDB7434" Ref="U4"  Part="4" 
AR Path="/5CC65FE6/5CDB7434" Ref="U?"  Part="4" 
F 0 "U4" H 3750 1000 50  0000 C CNN
F 1 "74AHC32" H 3750 900 50  0000 C CNN
F 2 "Housings_DIP:DIP-14_W7.62mm" H 3750 950 50  0001 C CNN
F 3 "" H 3750 950 50  0001 C CNN
	4    3750 950 
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HC14 U2
U 4 1 5CDB743B
P 2800 950
AR Path="/59EFC926/5CDB743B" Ref="U2"  Part="4" 
AR Path="/5CC65FE6/5CDB743B" Ref="U?"  Part="4" 
F 0 "U2" H 2950 1050 50  0000 C CNN
F 1 "74AHC14" H 3000 850 50  0000 C CNN
F 2 "Housings_DIP:DIP-14_W7.62mm" H 2800 950 50  0001 C CNN
F 3 "" H 2800 950 50  0001 C CNN
	4    2800 950 
	1    0    0    -1  
$EndComp
NoConn ~ 3100 950 
NoConn ~ 4050 950 
$Comp
L power:GND #PWR075
U 1 1 5CDB8C4E
P 2500 1350
F 0 "#PWR075" H 2500 1100 50  0001 C CNN
F 1 "GND" H 2505 1177 50  0000 C CNN
F 2 "" H 2500 1350 50  0001 C CNN
F 3 "" H 2500 1350 50  0001 C CNN
	1    2500 1350
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0101
U 1 1 5CDB8EC9
P 3450 1350
F 0 "#PWR0101" H 3450 1100 50  0001 C CNN
F 1 "GND" H 3455 1177 50  0000 C CNN
F 2 "" H 3450 1350 50  0001 C CNN
F 3 "" H 3450 1350 50  0001 C CNN
	1    3450 1350
	1    0    0    -1  
$EndComp
Wire Wire Line
	2500 950  2500 1350
Wire Wire Line
	3450 850  3450 1050
Connection ~ 3450 1050
Wire Wire Line
	3450 1050 3450 1350
$Comp
L Oscillator:CXO_DIP8 X?
U 1 1 5CA34C8B
P 6050 4500
AR Path="/5CA34C8B" Ref="X?"  Part="1" 
AR Path="/59EFC926/5CA34C8B" Ref="X1"  Part="1" 
F 0 "X1" H 5850 4750 50  0000 L CNN
F 1 "ACH20MHZ" H 6100 4250 50  0000 L CNN
F 2 "Oscillators:Oscillator_DIP-8" H 6500 4150 50  0001 C CNN
F 3 "http://www.abracon.com/Oscillators/ACH.pdf" H 5950 4500 50  0001 C CNN
	1    6050 4500
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5CA34C91
P 6050 4800
AR Path="/5CA34C91" Ref="#PWR?"  Part="1" 
AR Path="/59EFC926/5CA34C91" Ref="#PWR06"  Part="1" 
F 0 "#PWR06" H 6050 4550 50  0001 C CNN
F 1 "GND" H 6050 4650 50  0000 C CNN
F 2 "" H 6050 4800 50  0001 C CNN
F 3 "" H 6050 4800 50  0001 C CNN
	1    6050 4800
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 5CA34C97
P 6050 4200
AR Path="/5CA34C97" Ref="#PWR?"  Part="1" 
AR Path="/59EFC926/5CA34C97" Ref="#PWR03"  Part="1" 
F 0 "#PWR03" H 6050 4050 50  0001 C CNN
F 1 "VCC" H 6050 4350 50  0000 C CNN
F 2 "" H 6050 4200 50  0001 C CNN
F 3 "" H 6050 4200 50  0001 C CNN
	1    6050 4200
	1    0    0    -1  
$EndComp
Wire Wire Line
	6050 4200 5750 4200
Wire Wire Line
	5750 4200 5750 4500
Connection ~ 6050 4200
$Comp
L 74xx:74LS390 U28
U 1 1 5CA35A3F
P 7500 3950
F 0 "U28" H 7500 4200 50  0000 C CNN
F 1 "74HC390" H 7500 3600 50  0000 C CNN
F 2 "Housings_SSOP:TSSOP-16_4.4x5mm_Pitch0.65mm" H 7500 3950 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS390" H 7500 3950 50  0001 C CNN
	1    7500 3950
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS390 U28
U 2 1 5CA3A042
P 7500 4900
F 0 "U28" H 7500 5150 50  0000 C CNN
F 1 "74HC390" H 7500 4550 50  0000 C CNN
F 2 "Housings_SSOP:TSSOP-16_4.4x5mm_Pitch0.65mm" H 7500 4900 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS390" H 7500 4900 50  0001 C CNN
	2    7500 4900
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS390 U28
U 3 1 5CA3A8D7
P 6050 5800
F 0 "U28" H 6100 6150 50  0000 L CNN
F 1 "74HC390" H 6100 5450 50  0000 L CNN
F 2 "Housings_SSOP:TSSOP-16_4.4x5mm_Pitch0.65mm" H 6050 5800 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS390" H 6050 5800 50  0001 C CNN
	3    6050 5800
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0126
U 1 1 5CA3F4B4
P 6050 5300
F 0 "#PWR0126" H 6050 5150 50  0001 C CNN
F 1 "VCC" H 6067 5473 50  0000 C CNN
F 2 "" H 6050 5300 50  0001 C CNN
F 3 "" H 6050 5300 50  0001 C CNN
	1    6050 5300
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0127
U 1 1 5CA3FB27
P 6050 6300
F 0 "#PWR0127" H 6050 6050 50  0001 C CNN
F 1 "GND" H 6055 6127 50  0000 C CNN
F 2 "" H 6050 6300 50  0001 C CNN
F 3 "" H 6050 6300 50  0001 C CNN
	1    6050 6300
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0128
U 1 1 5CA407E1
P 7000 4150
F 0 "#PWR0128" H 7000 3900 50  0001 C CNN
F 1 "GND" H 7005 3977 50  0000 C CNN
F 2 "" H 7000 4150 50  0001 C CNN
F 3 "" H 7000 4150 50  0001 C CNN
	1    7000 4150
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0129
U 1 1 5CA40E15
P 7000 5100
F 0 "#PWR0129" H 7000 4850 50  0001 C CNN
F 1 "GND" H 7005 4927 50  0000 C CNN
F 2 "" H 7000 5100 50  0001 C CNN
F 3 "" H 7000 5100 50  0001 C CNN
	1    7000 5100
	1    0    0    -1  
$EndComp
Wire Wire Line
	6350 4500 6350 3850
Wire Wire Line
	6350 3850 7000 3850
Text HLabel 8350 3850 2    60   Output ~ 0
CLK10M
Wire Wire Line
	8000 3850 8350 3850
NoConn ~ 8000 3950
NoConn ~ 8000 4050
NoConn ~ 8000 4150
Wire Wire Line
	7000 3950 7000 4150
Connection ~ 7000 4150
Wire Wire Line
	7000 4900 6600 4900
Wire Wire Line
	6600 4900 6600 4500
Wire Wire Line
	6600 4500 6350 4500
Connection ~ 6350 4500
Wire Wire Line
	8000 5100 8150 5100
Wire Wire Line
	8150 5100 8150 4550
Wire Wire Line
	8150 4550 7000 4550
Wire Wire Line
	7000 4550 7000 4800
NoConn ~ 8000 4900
NoConn ~ 8000 5000
Text HLabel 8350 4800 2    60   Output ~ 0
CLK2M
Wire Wire Line
	8000 4800 8350 4800
$Comp
L Device:C C41
U 1 1 5CA593DD
P 5550 5750
F 0 "C41" H 5600 5850 50  0000 L CNN
F 1 "0.1uF" H 5600 5650 50  0000 L CNN
F 2 "Capacitors_THT:C_Disc_D4.3mm_W1.9mm_P5.00mm" H 5588 5600 50  0001 C CNN
F 3 "~" H 5550 5750 50  0001 C CNN
	1    5550 5750
	1    0    0    -1  
$EndComp
Wire Wire Line
	6050 5300 5550 5300
Wire Wire Line
	5550 5300 5550 5600
Wire Wire Line
	5550 5900 5550 6300
Wire Wire Line
	5550 6300 6050 6300
Connection ~ 6050 5300
Connection ~ 6050 6300
Text Notes 5300 5700 0    60   ~ 0
Near\nU28
$Comp
L Regulator_Linear:AP7361C-33E U20
U 1 1 5CDAFB55
P 8150 950
F 0 "U20" H 8000 1100 50  0000 C CNN
F 1 "AP2114HA-33" H 8450 700 50  0000 C CNN
F 2 "TO_SOT_Packages_SMD:SOT-223-3_TabPin2" H 8150 1175 50  0001 C CIN
F 3 "" H 8150 900 50  0001 C CNN
	1    8150 950 
	1    0    0    -1  
$EndComp
Wire Wire Line
	8150 1250 8150 1550
Wire Wire Line
	8450 950  8750 950 
$Comp
L Device:C C?
U 1 1 5CDBB06C
P 7650 1200
AR Path="/5CDBB06C" Ref="C?"  Part="1" 
AR Path="/59EFC926/5CDBB06C" Ref="C45"  Part="1" 
F 0 "C45" H 7675 1300 50  0000 L CNN
F 1 "4.7uF" H 7675 1100 50  0000 L CNN
F 2 "Capacitors_SMD:C_0805_HandSoldering" H 7688 1050 50  0001 C CNN
F 3 "" H 7650 1200 50  0001 C CNN
	1    7650 1200
	1    0    0    -1  
$EndComp
Wire Wire Line
	7100 950  7650 950 
Wire Wire Line
	7100 1550 7650 1550
Connection ~ 7100 1550
Wire Wire Line
	7650 1350 7650 1550
Connection ~ 7650 1550
Wire Wire Line
	7650 1550 8150 1550
Wire Wire Line
	7650 1050 7650 950 
Connection ~ 7650 950 
Wire Wire Line
	7650 950  7850 950 
Wire Wire Line
	6550 1550 7100 1550
Wire Wire Line
	6550 950  7100 950 
$EndSCHEMATC
