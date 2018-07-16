//----------------------------------------------------------------------
//EASTRISING TECHNOLOGY CO,.LTD.//
// Module    : ER-TFTM101-1  10.1 INCH TFT LCD  1024*600
// Lanuage   : C51 Code
// Create    : JAVEN LIU
// Date      : 2015-08-01
// Drive IC  : RA8876     FLASH:W25Q128FV  128M BIT   FONT CHIP: 30L24T3Y   TP:XPT2046
// INTERFACE : 8 BIT 8080   
// MCU 		 : STC12LE5C60S2     1T MCU
// MCU VDD	 : 3.3V
// MODULE VDD : 5V OR 3.3V 
//----------------------------------------------------------------------

//===========================================================
#include <STC12C5A.H>
#include <math.h>
#include <stdio.h>
#include<stdlib.h>
#include <intrins.h>
#include"RA8876.h" 
#include"8876demo.h" 
#include"SD.h"  
#include"TP.h"   


//=============================================================


#define uchar      unsigned char
#define uint       unsigned int
#define ulong      unsigned long



/////////////////////main////////////////////
void main(void)
{ 

	P0=0xff;
	P1=0xff;
	P2=0xff;
	P3=0xff;	   
//	BL_ON=0;  //Backlight on when external signal control


  	delay_ms(100);//delay for RA8876 power on
    RA8876_HW_Reset();
   	delay_ms(100);
	 while(LCD_StatusRead()&0x02);	 //Initial_Display_test	and  set SW2 pin2 = 1

  	RA8876_initial();
	 Display_ON();
	 delay_ms(20);


   	Foreground_color_65k(White);
	Line_Start_XY(0,0);
	Line_End_XY(1023,599);
	Start_Square_Fill();

 while(1) 
 	{
 ///////////////////////////////////////////////// BackLight  Brightness control test  whit RA8876's PWM0
  	Enable_PWM0_Interrupt();
	Clear_PWM0_Interrupt_Flag();
 	Mask_PWM0_Interrupt_Flag();
	Select_PWM0_Clock_Divided_By_2();
 	Select_PWM0();
 	Enable_PWM0_Dead_Zone();
	Auto_Reload_PWM0();
	 Start_PWM0();
 	Set_Timer0_Compare_Buffer(0xffff);
 	 delay_ms(2000);

  	Set_Timer0_Compare_Buffer(0x0000);
 	 delay_ms(2000);
 	Set_Timer0_Compare_Buffer(0x0ff0);
 	 delay_ms(2000);
	  	Set_Timer0_Compare_Buffer(0xffff);
 	 delay_ms(2000);

 ///////////////////////////////////////////////////////////
 ///////////////////////////////////////////////////////////	
	 

  	Geometric();
	Text_Demo();
 	mono_Demo();	   
	gray();
	TPTEST();
	delay_ms(3000);
	Display_JPG_SDCARD();
	delay_ms(3000);
	DMA_Demo();
	BTE_Compare();
	BTE_Pattern_Fill();
  	BTE_Color_Expansion();

 	 PIP_Demo();
	 App_Demo_Waveform();
	 App_Demo_Scrolling_Text();
	 //App_Demo_Icon_Effect(); //need SD card for picture source
	 App_Demo_slide_frame_buffer();
	 App_Demo_multi_frame_buffer();
	 App_Demo_Alpha_Blending();
	}
}




	
