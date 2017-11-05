EESchema Schematic File Version 2
LIBS:power
LIBS:device
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:valves
LIBS:Zilog
LIBS:Oscillators
LIBS:switches
LIBS:headquarters
LIBS:z80-cache
EELAYER 25 0
EELAYER END
$Descr USLetter 11000 8500
encoding utf-8
Sheet 6 7
Title "CTC, Baud Rate Generation"
Date "2017-10-24"
Rev "5"
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Z84C30 U17
U 1 1 59D9201C
P 3500 3150
F 0 "U17" H 3000 4241 50  0000 L TNN
F 1 "Z84C30" H 4000 4250 50  0000 R TNN
F 2 "" H 4000 4250 60  0001 C CNN
F 3 "" H 4000 4250 60  0001 C CNN
	1    3500 3150
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR063
U 1 1 59D9205A
P 3500 1950
F 0 "#PWR063" H 3500 1800 50  0001 C CNN
F 1 "VCC" H 3500 2100 50  0000 C CNN
F 2 "" H 3500 1950 50  0001 C CNN
F 3 "" H 3500 1950 50  0001 C CNN
	1    3500 1950
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR064
U 1 1 59D92070
P 3500 4950
F 0 "#PWR064" H 3500 4700 50  0001 C CNN
F 1 "GND" H 3500 4800 50  0000 C CNN
F 2 "" H 3500 4950 50  0001 C CNN
F 3 "" H 3500 4950 50  0001 C CNN
	1    3500 4950
	1    0    0    -1  
$EndComp
Wire Wire Line
	2800 2250 2650 2250
Wire Wire Line
	2800 2350 2650 2350
Wire Wire Line
	2800 2450 2650 2450
Wire Wire Line
	2800 2550 2650 2550
Wire Wire Line
	2800 2650 2650 2650
Wire Wire Line
	2800 2750 2650 2750
Wire Wire Line
	2800 2850 2650 2850
Wire Wire Line
	2800 2950 2650 2950
Text Label 2650 2250 0    60   ~ 0
D0
Text Label 2650 2350 0    60   ~ 0
D1
Text Label 2650 2450 0    60   ~ 0
D2
Text Label 2650 2550 0    60   ~ 0
D3
Text Label 2650 2650 0    60   ~ 0
D4
Text Label 2650 2750 0    60   ~ 0
D5
Text Label 2650 2850 0    60   ~ 0
D6
Text Label 2650 2950 0    60   ~ 0
D7
Entry Wire Line
	2550 2150 2650 2250
Entry Wire Line
	2550 2250 2650 2350
Entry Wire Line
	2550 2350 2650 2450
Entry Wire Line
	2550 2450 2650 2550
Entry Wire Line
	2550 2550 2650 2650
Entry Wire Line
	2550 2650 2650 2750
Entry Wire Line
	2550 2750 2650 2850
Entry Wire Line
	2550 2850 2650 2950
Text HLabel 1100 2000 0    60   BiDi ~ 0
D[0..7]
Wire Bus Line
	2550 2850 2550 2000
Wire Bus Line
	2550 2000 1100 2000
Text HLabel 1100 3150 0    60   Input ~ 0
~CE
Text HLabel 1100 3250 0    60   Input ~ 0
~RESET
Text HLabel 1100 3350 0    60   Input ~ 0
~M1
Text HLabel 1100 3450 0    60   Input ~ 0
~IORQ
Text HLabel 1100 3550 0    60   Input ~ 0
~RD
Text HLabel 1100 3750 0    60   Input ~ 0
CS0
Text HLabel 1100 3850 0    60   Input ~ 0
CS1
Text HLabel 1100 4050 0    60   Output ~ 0
~INT
Text HLabel 1100 4150 0    60   Input ~ 0
IEI
Text HLabel 1100 4250 0    60   Output ~ 0
IEO
Text HLabel 1100 4450 0    60   Input ~ 0
CLK
Wire Wire Line
	1100 3150 2800 3150
Wire Wire Line
	1100 3250 2800 3250
Wire Wire Line
	1100 3350 2800 3350
Wire Wire Line
	1100 3450 2800 3450
Wire Wire Line
	1100 3550 2800 3550
Wire Wire Line
	1100 3750 2800 3750
Wire Wire Line
	1100 3850 2800 3850
Wire Wire Line
	1100 4050 2800 4050
Wire Wire Line
	1100 4150 2800 4150
Wire Wire Line
	1100 4250 2800 4250
Wire Wire Line
	1100 4450 2800 4450
$Comp
L C C27
U 1 1 59D92B9B
P 4800 6750
F 0 "C27" H 4825 6850 50  0000 L CNN
F 1 "0.1uF" H 4825 6650 50  0000 L CNN
F 2 "" H 4838 6600 50  0001 C CNN
F 3 "" H 4800 6750 50  0001 C CNN
	1    4800 6750
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR065
U 1 1 59D92BA2
P 4550 6900
F 0 "#PWR065" H 4550 6650 50  0001 C CNN
F 1 "GND" H 4550 6750 50  0000 C CNN
F 2 "" H 4550 6900 50  0001 C CNN
F 3 "" H 4550 6900 50  0001 C CNN
	1    4550 6900
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR066
U 1 1 59D92BAF
P 4550 6600
F 0 "#PWR066" H 4550 6450 50  0001 C CNN
F 1 "VCC" H 4550 6750 50  0000 C CNN
F 2 "" H 4550 6600 50  0001 C CNN
F 3 "" H 4550 6600 50  0001 C CNN
	1    4550 6600
	1    0    0    -1  
$EndComp
Text Notes 4750 6550 0    60   ~ 0
Near\nU17
Connection ~ 4800 6600
Connection ~ 4800 6900
Wire Wire Line
	4550 6600 4800 6600
Wire Wire Line
	4550 6900 4800 6900
Wire Wire Line
	4200 2850 4200 3000
Wire Wire Line
	4300 2750 4200 2750
Wire Wire Line
	4300 2500 4200 2500
Wire Wire Line
	4200 2250 5200 2250
Connection ~ 4300 2500
$Comp
L CXO_DIP8 X2
U 1 1 59DCF0C2
P 5500 2250
F 0 "X2" H 5300 2500 50  0000 L CNN
F 1 "1.8432MHz" H 5550 2000 50  0000 L CNN
F 2 "Oscillators:Oscillator_DIP-8" H 5950 1900 50  0001 C CNN
F 3 "http://www.abracon.com/Oscillators/ACH.pdf" H 5400 2250 50  0001 C CNN
	1    5500 2250
	-1   0    0    -1  
$EndComp
$Comp
L GND #PWR067
U 1 1 59DCF0C9
P 5500 2550
F 0 "#PWR067" H 5500 2300 50  0001 C CNN
F 1 "GND" H 5500 2400 50  0000 C CNN
F 2 "" H 5500 2550 50  0001 C CNN
F 3 "" H 5500 2550 50  0001 C CNN
	1    5500 2550
	-1   0    0    -1  
$EndComp
$Comp
L VCC #PWR068
U 1 1 59DCF0CF
P 5500 1950
F 0 "#PWR068" H 5500 1800 50  0001 C CNN
F 1 "VCC" H 5500 2100 50  0000 C CNN
F 2 "" H 5500 1950 50  0001 C CNN
F 3 "" H 5500 1950 50  0001 C CNN
	1    5500 1950
	-1   0    0    -1  
$EndComp
Wire Wire Line
	5500 1950 5800 1950
Wire Wire Line
	5800 1950 5800 2250
Wire Wire Line
	4300 2250 4300 2750
Connection ~ 4300 2250
Text HLabel 6300 3000 2    60   Output ~ 0
CCLK0
Text HLabel 6300 3100 2    60   Output ~ 0
CCLK1
Wire Wire Line
	4200 2350 4500 2350
Wire Wire Line
	4500 2350 4500 3000
Wire Wire Line
	4500 3000 6300 3000
Wire Wire Line
	4200 2600 4400 2600
Wire Wire Line
	4400 2600 4400 3100
Wire Wire Line
	4400 3100 6300 3100
$EndSCHEMATC
