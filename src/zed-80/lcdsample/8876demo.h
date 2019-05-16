
   #define layer1_start_addr 0 		 
  #define layer2_start_addr 1228800   //1024*600*2 
  #define layer3_start_addr 2457600   //1024*600*2*2
  #define layer4_start_addr 3686400   //1024*600*2*3
  #define layer5_start_addr 4915200   //1024*600*2*4
  #define layer6_start_addr 6144000   //1024*600*2*5



void BTE_Compare(void)
{
   unsigned int i,temp;
	unsigned long im=1;


  	Select_Main_Window_16bpp();
	Main_Image_Start_Address(0);				
	Main_Image_Width(1024);							
	Main_Window_Start_XY(0,0);

	Canvas_Image_Start_address(0);//Layer 1
	Canvas_image_width(1024);//
    Active_Window_XY(0,0);
	Active_Window_WH(1024,600);

 	Foreground_color_65k(White);
	Line_Start_XY(0,0);
	Line_End_XY(1023,575);
	Start_Square_Fill();

	Foreground_color_65k(Blue2);
	Line_Start_XY(0,576);
	Line_End_XY(1023,599);
	Start_Square_Fill();

	//Foreground_color_65k(White);
	//Background_color_65k(Blue2);
	//Goto_Text_XY(300,576);
	//Show_String("Demo DMA");



	Foreground_color_65k(White);
	Background_color_65k(Blue2);
	CGROM_Select_Internal_CGROM();
	Font_Select_12x24_24x24();
	Goto_Text_XY(0,Line24);
	Show_String("    	             Demo BTE Compare");
	Foreground_color_65k(Black);
	Background_color_65k(White);
	Font_Select_12x24_24x24();
	Goto_Text_XY(0,Line23);
	Show_String("Execute Logic 'OR' 0xf000");


    //DMA initial setting
	Enable_SFlash_SPI();
    Select_SFI_1();
    Select_SFI_DMA_Mode();
    Select_SFI_24bit_Address();

    //Select_SFI_Waveform_Mode_0();
    Select_SFI_Waveform_Mode_3();

    //Select_SFI_0_DummyRead();	//normal read mode
    Select_SFI_8_DummyRead(); //1byte dummy cycle
    //Select_SFI_16_DummyRead();
   //Select_SFI_24_DummyRead();

    Select_SFI_Single_Mode();
    //Select_SFI_Dual_Mode0();
   // Select_SFI_Dual_Mode1();

    SPI_Clock_Period(0);


	SFI_DMA_Destination_Upper_Left_Corner(50,40);
    SFI_DMA_Transfer_Width_Height(200,200);
    SFI_DMA_Source_Width(1024);//

	SFI_DMA_Source_Start_Address(2457600);//
	Start_SFI_DMA();
    Check_Busy_SFI_DMA();

	SFI_DMA_Destination_Upper_Left_Corner(50+200+50,40);
    SFI_DMA_Transfer_Width_Height(200,200);
    SFI_DMA_Source_Width(1024);//

	SFI_DMA_Source_Start_Address(2457600);//
	Start_SFI_DMA();
    Check_Busy_SFI_DMA();

	SFI_DMA_Destination_Upper_Left_Corner(50+200+50+200+50,40);
    SFI_DMA_Transfer_Width_Height(200,200);
    SFI_DMA_Source_Width(1024);//

	SFI_DMA_Source_Start_Address(im*1024*600*2*2);//
	Start_SFI_DMA();
    Check_Busy_SFI_DMA();


 	Foreground_color_65k(Black);
	Background_color_65k(White);
	CGROM_Select_Internal_CGROM();
	Font_Select_12x24_24x24();
	Goto_Text_XY(50,40+200+40 );
	Show_String("Without BTE");
 	Goto_Text_XY(50+200+50,40+200+40 );
	Show_String("With BTE Write");
  	Goto_Text_XY(50+200+50,40+200+40+24 );
	Show_String("ROP");
  	Goto_Text_XY(50+200+50+200+50,40+200+40 );
	Show_String("With BTE Move");
  	Goto_Text_XY(50+200+50+200+50,40+200+40+24 );
	Show_String("ROP");

	delay_ms(1000);
	 //first block, MCU read and 'OR'0xff00 then write back
   //while(1)
   //{

	   Active_Window_XY(50,40);
	   Active_Window_WH(200,200);
	 
	    Goto_Pixel_XY(50,40);
	    LCD_CmdWrite(0x04);
	    temp = LCD_DataRead();
		 Check_Mem_RD_FIFO_not_Empty();  //dummy

	    for(i=0; i<200*200;i++)
		  {				
		   temp = LCD_DataRead();
		   
		   temp=temp|(LCD_DataRead()<<8);
		   Check_Mem_RD_FIFO_not_Empty();
		   temp |= 0xf000; 
		   LCD_DataWrite(temp);
		   LCD_DataWrite(temp>>8);
		   Check_Mem_WR_FIFO_not_Full();
		   }

	// }
		Active_Window_XY(0,0);
	    Active_Window_WH(1024,600);

	  //spent 51.12ms
	
	 	Foreground_color_65k(Black);
		Background_color_65k(White);
		CGROM_Select_Internal_CGROM();
		Font_Select_12x24_24x24();
		Goto_Text_XY(50,40+200+40+72 );
		Show_String("Spent 51.12ms");

	   delay_ms(1000);

	  //second block, MCU write with BTE ROP 

	  //while(1)
      //{
	

	   BTE_S0_Color_16bpp();

       BTE_S1_Color_16bpp();
       BTE_S1_Memory_Start_Address(0);
       BTE_S1_Image_Width(1024);
       BTE_S1_Window_Start_XY(50+200+50,40);

       BTE_Destination_Color_16bpp();  
       BTE_Destination_Memory_Start_Address(0);
       BTE_Destination_Image_Width(1024);
       BTE_Destination_Window_Start_XY(50+200+50,40);  
       BTE_Window_Size(200,200);

	   BTE_ROP_Code(14);
       BTE_Operation_Code(0); //BTE write
       BTE_Enable();

       LCD_CmdWrite(0x04);
       	for(i=0; i<200*200;i++)
		  {				
		   LCD_DataWrite(0xf000);
		   LCD_DataWrite(0xf000>>8);
		   Check_Mem_WR_FIFO_not_Full();
		   }
       Check_Mem_WR_FIFO_Empty();//寫完後檢查
       Check_BTE_Busy();

	
	   //}
	   //spent 25.56ms

 	 	Foreground_color_65k(Black);
		Background_color_65k(White);
		CGROM_Select_Internal_CGROM();
		Font_Select_12x24_24x24();
		Goto_Text_XY(50+200+50,40+200+40+72 );
		Show_String("Spent 25.56ms");
	   delay_ms(1000);
	   
	   
	  //third block, BTE MOVE with ROP
	  //while(1)
      //{
	  // GPIO_SetBits(GPIOC, GPIO_Pin_1);	
	   	Canvas_Image_Start_address(layer2_start_addr);//
	    Canvas_image_width(1024);//
        Active_Window_XY(0,0);
	    Active_Window_WH(1024,600);

 	    Foreground_color_65k(0xf000);
	    Line_Start_XY(0,0);
	    Line_End_XY(200,200);
	    Start_Square_Fill();
		//Main_Image_Start_Address(layer2_start_addr);

		BTE_S0_Color_16bpp();
		BTE_S0_Memory_Start_Address(layer2_start_addr);
		BTE_S0_Image_Width(1024);
	    BTE_S0_Window_Start_XY(0,0);

        BTE_S1_Color_16bpp();
        BTE_S1_Memory_Start_Address(layer1_start_addr);
        BTE_S1_Image_Width(1024);
        BTE_S1_Window_Start_XY(50+200+50+200+50,40);

        BTE_Destination_Color_16bpp();  
        BTE_Destination_Memory_Start_Address(layer1_start_addr);
        BTE_Destination_Image_Width(1024);
        BTE_Destination_Window_Start_XY(50+200+50+200+50,40);  
        BTE_Window_Size(200,200);

	    BTE_ROP_Code(14);
        BTE_Operation_Code(2); //BTE write
        BTE_Enable();
		Check_BTE_Busy();

		//GPIO_ResetBits(GPIOC, GPIO_Pin_1);		
	   //}
	    //spent 6.4ms
		Canvas_Image_Start_address(layer1_start_addr);//
 	 	Foreground_color_65k(Black);
		Background_color_65k(White);
		CGROM_Select_Internal_CGROM();
		Font_Select_12x24_24x24();
		Goto_Text_XY(50+200+50+200+50,40+200+40+72 );
		Show_String("SSpent 6.4ms");
			delay_ms(1000);
			NextStep();

}


void BTE_Color_Expansion(void)
{    unsigned int i,j;
    unsigned long im=1;

 	Select_Main_Window_16bpp();
	Main_Image_Start_Address(0);				
	Main_Image_Width(1024);							
	Main_Window_Start_XY(0,0);

	Canvas_Image_Start_address(layer1_start_addr);//Layer 1
	Canvas_image_width(1024);//
    Active_Window_XY(0,0);
	Active_Window_WH(1024,600);

 	Foreground_color_65k(Black);
	Line_Start_XY(0,0);
	Line_End_XY(1023,575);
	Start_Square_Fill();

	Foreground_color_65k(Blue2);
	Line_Start_XY(0,576);
	Line_End_XY(1023,599);
	Start_Square_Fill();



	Foreground_color_65k(White);
	Background_color_65k(Blue2);
	CGROM_Select_Internal_CGROM();
	Font_Select_12x24_24x24();
	Goto_Text_XY(0,Line24);
	Show_String("            Demo BTE Color Expansion");


    //DMA initial setting
	Enable_SFlash_SPI();
    Select_SFI_1();
    Select_SFI_DMA_Mode();
    Select_SFI_24bit_Address();

    //Select_SFI_Waveform_Mode_0();
    Select_SFI_Waveform_Mode_3();

    //Select_SFI_0_DummyRead();	//normal read mode
    Select_SFI_8_DummyRead(); //1byte dummy cycle
    //Select_SFI_16_DummyRead();
    //Select_SFI_24_DummyRead();

    Select_SFI_Single_Mode();
    //Select_SFI_Dual_Mode0();
    //Select_SFI_Dual_Mode1();

    SPI_Clock_Period(0);


	SFI_DMA_Destination_Upper_Left_Corner(80,40);
    SFI_DMA_Transfer_Width_Height(640,480);
    SFI_DMA_Source_Width(1024);//

	SFI_DMA_Source_Start_Address(im*1024*600*2*3);//
	Start_SFI_DMA();
    Check_Busy_SFI_DMA();



	//color expansion and bte memory copy(move) 

  j=0;
 do
 {
   for(i=0;i<3;i++)
   {
	 //switch to layer2 update screen, and execute color expansion and copy to layer1
	 Canvas_Image_Start_address(layer2_start_addr);//
 	 Foreground_color_65k(Black);
	 Line_Start_XY(0,0);
	 Line_End_XY(1023,575);
	 Start_Square_Fill();
	 //SFI_DMA_Source_Start_Address(640*480*2*i);//
	 Start_SFI_DMA();
     Check_Busy_SFI_DMA();

	 BTE_S0_Color_16bpp();
 
     BTE_S1_Color_16bpp();

     BTE_Destination_Color_16bpp();  
     BTE_Destination_Memory_Start_Address(layer2_start_addr);
     BTE_Destination_Image_Width(1024);
     BTE_Destination_Window_Start_XY(80+70,40+70);  
     BTE_Window_Size(160,160);
	 Foreground_color_65k(color65k_blue);
     Background_color_65k(color65k_red);
	 BTE_ROP_Code(15);
     BTE_Operation_Code(8); //BTE color expansion

	 BTE_Enable();
	 LCD_CmdWrite(0x04);

	 switch(i)
	 {
	  case 0 :	          	 
			  Show_picture1(10*160,f1); 
			  Check_Mem_WR_FIFO_Empty();  	  
	          Check_BTE_Busy();
			  break;
	  case 1 :
			  Show_picture1(10*160,f2); 
			  Check_Mem_WR_FIFO_Empty();  	  
	          Check_BTE_Busy();
			  break;
	  case 2 :
			  Show_picture1(10*160,f3); 
			  Check_Mem_WR_FIFO_Empty();  	  
	          Check_BTE_Busy();
			  break;
	   default:
			  break;
	 }

	
		Foreground_color_65k(Black);
	Background_color_65k(White);
	CGROM_Select_Internal_CGROM();
	Font_Select_12x24_24x24();
	Goto_Text_XY(80+70,40+70+160+20);
	Show_String("Color Expansion");



	 Foreground_color_65k(color65k_blue);
     Background_color_65k(color65k_red);

	 BTE_Operation_Code(9); //BTE color expansion with chroma key
	 BTE_Destination_Window_Start_XY(80+320+70,40+70);  
	 BTE_Enable();
	 LCD_CmdWrite(0x04);

	 switch(i)
	 {
	  case 0 :	          	
			  Show_picture1(10*160,f1); 
			  Check_Mem_WR_FIFO_Empty();  	  
	          Check_BTE_Busy();
			  break;
	  case 1 :
			  Show_picture1(10*160,f2); 
			  Check_Mem_WR_FIFO_Empty();  	  
	          Check_BTE_Busy();
			  break;
	  case 2 :
			  Show_picture1(10*160,f3); 
			  Check_Mem_WR_FIFO_Empty();  	  
	          Check_BTE_Busy();
			  break;
	   default:
			  break;
	 }
	 

	Foreground_color_65k(Black);
	Background_color_65k(White);
	CGROM_Select_Internal_CGROM();
	Font_Select_12x24_24x24();
	Goto_Text_XY(80+320+70,40+70+160+20);
	Show_String("Color Expansion");
	Goto_Text_XY(80+320+70,40+70+160+20+24);
	Show_String("Color With chroma key");

  	 Foreground_color_65k(color65k_blue);
     Background_color_65k(color65k_red);

	   //BTE memory(move) layer2 to layer1
	   //BTE_S0_Color_16bpp();
       BTE_S0_Memory_Start_Address(layer2_start_addr);
       BTE_S0_Image_Width(1024);
       BTE_S0_Window_Start_XY(0,0);

       //BTE_Destination_Color_16bpp();  
       BTE_Destination_Memory_Start_Address(layer1_start_addr);
       BTE_Destination_Image_Width(1024);
       BTE_Destination_Window_Start_XY(0,0);  
       BTE_Window_Size(1024,575);

       BTE_ROP_Code(12); 
       BTE_Operation_Code(2); //BTE move
       BTE_Enable();		  //memory copy s0(layer2) to layer1  
       Check_BTE_Busy();

	 
	  j++;
	}

   }while(j<12);

 			NextStep();

}



void BTE_Pattern_Fill(void)
{	    unsigned long im=1;

 	Select_Main_Window_16bpp();
	Main_Image_Start_Address(0);				
	Main_Image_Width(1024);							
	Main_Window_Start_XY(0,0);

	Canvas_Image_Start_address(0);//Layer 1
	Canvas_image_width(1024);//
    Active_Window_XY(0,0);
	Active_Window_WH(1024,600);

 	Foreground_color_65k(Black);
	Line_Start_XY(0,0);
	Line_End_XY(1023,575);
	Start_Square_Fill();

	Foreground_color_65k(Blue2);
	Line_Start_XY(0,576);
	Line_End_XY(1023,599);
	Start_Square_Fill();


	Foreground_color_65k(White);
	Background_color_65k(Blue2);
	CGROM_Select_Internal_CGROM();
	Font_Select_12x24_24x24();
	Goto_Text_XY(0,Line24);
	Show_String("              Demo BTE Pattern Fill");

    //DMA initial setting
	Enable_SFlash_SPI();
    Select_SFI_1();
    Select_SFI_DMA_Mode();
    Select_SFI_24bit_Address();

    //Select_SFI_Waveform_Mode_0();
    Select_SFI_Waveform_Mode_3();

    //Select_SFI_0_DummyRead();	//normal read mode
    Select_SFI_8_DummyRead(); //1byte dummy cycle
    //Select_SFI_16_DummyRead();
    //Select_SFI_24_DummyRead();

    Select_SFI_Single_Mode();
    //Select_SFI_Dual_Mode0();
    //Select_SFI_Dual_Mode1();

    SPI_Clock_Period(0);


	SFI_DMA_Destination_Upper_Left_Corner(80,40);
    SFI_DMA_Transfer_Width_Height(640,480);
    SFI_DMA_Source_Width(1024);//

	SFI_DMA_Source_Start_Address(im*1024*600*2*1);//
	Start_SFI_DMA();
    Check_Busy_SFI_DMA();


	//write 16x16 pattern to sdram
	Pattern_Format_16X16();	
	Canvas_Image_Start_address(layer6_start_addr);//any layer 
    Canvas_image_width(16);
    Active_Window_XY(0,0);
    Active_Window_WH(16,16);
    Goto_Pixel_XY(0,0);
    Show_picture(16*16,pattern16x16_16bpp); 

	Canvas_Image_Start_address(layer1_start_addr);//
    Canvas_image_width(1024);
    Active_Window_XY(0,0);
    Active_Window_WH(1024,600);

    
	BTE_S0_Color_16bpp();
    BTE_S0_Memory_Start_Address(layer6_start_addr);
    BTE_S0_Image_Width(16);
 
    BTE_S1_Color_16bpp();
    BTE_S1_Memory_Start_Address(0);
    BTE_S1_Image_Width(1024);

    BTE_Destination_Color_16bpp();  
    BTE_Destination_Memory_Start_Address(layer1_start_addr);
    BTE_Destination_Image_Width(1024);

    BTE_ROP_Code(0xc);
    BTE_Operation_Code(0x06);//pattern fill	

	BTE_S1_Window_Start_XY(0,0);      
    BTE_Destination_Window_Start_XY(80,40);
    BTE_Window_Size(300,300);

    BTE_Enable();   
    Check_BTE_Busy();
	
	Foreground_color_65k(Black);
	Background_color_65k(White);
	CGROM_Select_Internal_CGROM();
	Font_Select_12x24_24x24();
	Goto_Text_XY(80,350);
	Show_String("Pattern Fill");
			 
	Background_color_65k(color65k_red);
	BTE_S1_Window_Start_XY(0,0);      
    BTE_Destination_Window_Start_XY(80+300+40,40);
    BTE_Window_Size(300,300);
	BTE_Operation_Code(0x07);//pattern fill with chroma key

	BTE_Enable();   
    Check_BTE_Busy();

	Foreground_color_65k(Black);
	Background_color_65k(White);
	CGROM_Select_Internal_CGROM();
	Font_Select_12x24_24x24();
	Goto_Text_XY(80+300+40,350);
	Show_String("Pattern Fill With");

	Foreground_color_65k(Black);
	Background_color_65k(White);
	CGROM_Select_Internal_CGROM();
	Font_Select_12x24_24x24();
	Goto_Text_XY(80+300+40,374);
	Show_String("Chroma Key");
    delay_ms(1000);
  	NextStep();
}


void PIP_Demo(void)
{   unsigned long i;	 
 	 unsigned long im=1;

	Select_Main_Window_16bpp();
	Main_Image_Start_Address(0);				
	Main_Image_Width(1024);							
	Main_Window_Start_XY(0,0);

	Canvas_Image_Start_address(0);//Layer 1
	Canvas_image_width(1024);//
    Active_Window_XY(0,0);
	Active_Window_WH(1024,600);

 	Foreground_color_65k(White);
	Line_Start_XY(0,0);
	Line_End_XY(1023,575);
	Start_Square_Fill();

	Foreground_color_65k(Blue2);
	Line_Start_XY(0,576);
	Line_End_XY(1023,599);
	Start_Square_Fill();

	Foreground_color_65k(White);
	Background_color_65k(Blue2);
	CGROM_Select_Internal_CGROM();
	Font_Select_12x24_24x24();
	Goto_Text_XY(0,Line24);
	Show_String("                    Demo PIP");

     //寫入PIP1圖
	 Memory_16bpp_Mode();
	 delay_ms(20);
	 Canvas_Image_Start_address(layer2_start_addr);//Layer 2
	 Canvas_image_width(1024);//
     Active_Window_XY(0,0);
	 Active_Window_WH(320,240);
     Goto_Pixel_XY(0,0);
	 LCD_CmdWrite(0x04);
	 for(i=0;i<76800;i++)
	 {
	  LCD_DataWrite(color65k_blue);
	  LCD_DataWrite(color65k_blue>>8);
	  //Check_Mem_WR_FIFO_not_Full();
 	 }
	  Check_Mem_WR_FIFO_Empty();


	Foreground_color_65k(White);
	Background_color_65k(color65k_blue);
	CGROM_Select_Internal_CGROM();
	Font_Select_12x24_24x24();
	Goto_Text_XY(120,120);
	Show_String("PIP1");



	//寫入PIP2圖
	Canvas_Image_Start_address(layer3_start_addr);//Layer 3
	Canvas_image_width(1024);//
    Active_Window_XY(0,0);
	Active_Window_WH(320,240);
    Goto_Pixel_XY(0,0);
	LCD_CmdWrite(0x04);
	for(i=0;i<76800;i++)
	{
	 LCD_DataWrite(color65k_red);
 	 LCD_DataWrite(color65k_red>>8);
	 //Check_Mem_WR_FIFO_not_Full();
 	}
	Check_Mem_WR_FIFO_Empty();

	Foreground_color_65k(White);
	Background_color_65k(color65k_red);
	CGROM_Select_Internal_CGROM();
	Font_Select_12x24_24x24();
	Goto_Text_XY(120,120);
	Show_String("PIP2");


 	//PIP1
 	Select_PIP1_Window_16bpp();//	
	Select_PIP1_Parameter();
	PIP_Image_Start_Address(layer2_start_addr);
	PIP_Image_Width(1024);
	PIP_Window_Width_Height(320,240);
	PIP_Window_Image_Start_XY(0,0);
	PIP_Display_Start_XY(80,40);
	Enable_PIP1();
	delay_ms(50);

	//PIP2
    Select_PIP2_Window_16bpp(); //注意			
	Select_PIP2_Parameter();
	PIP_Image_Start_Address(layer3_start_addr);
	PIP_Image_Width(1024);
	PIP_Window_Width_Height(320,240);
	PIP_Window_Image_Start_XY(0,0);
	PIP_Display_Start_XY(80+320,40+240);
	Enable_PIP2();
	delay_ms(50);


     for(i=0;i<160;i++)
	 {
	  Select_PIP1_Parameter();
	  PIP_Display_Start_XY(80+i,40+i);
	  // PIP_Display_Start_XY(80,40+i);
	  delay_ms(1);
	  Select_PIP2_Parameter();
	  PIP_Display_Start_XY(80+320-i,40+240-i);
	  //PIP_Display_Start_XY(80+320,40+240-i);
	  delay_ms(10);
	 }

	 for(i=0;i<160;i++)
	 {
	  Select_PIP1_Parameter();
	  PIP_Display_Start_XY(80+159-i,40+159-i);
	  //PIP_Display_Start_XY(80+159,40+159-i);
	  delay_ms(1);
	  Select_PIP2_Parameter();
	  PIP_Display_Start_XY(80+320-159+i,40+240-159+i);
	   //PIP_Display_Start_XY(80+320-159,40+240-159+i);
	  delay_ms(10);
	  }
  
	  delay_ms(2000);


	//DMA initial setting
	Enable_SFlash_SPI();
    Select_SFI_1();
    Select_SFI_DMA_Mode();
    Select_SFI_24bit_Address();

    //Select_SFI_Waveform_Mode_0();
    Select_SFI_Waveform_Mode_3();

    //Select_SFI_0_DummyRead();	//normal read mode
    Select_SFI_8_DummyRead(); //1byte dummy cycle
    //Select_SFI_16_DummyRead();
    //Select_SFI_24_DummyRead();

    Select_SFI_Single_Mode();
    //Select_SFI_Dual_Mode0();
    //Select_SFI_Dual_Mode1();

    SPI_Clock_Period(0);

	Canvas_Image_Start_address(layer2_start_addr);//Layer 2
	Canvas_image_width(1024);//

	SFI_DMA_Destination_Upper_Left_Corner(0,0);
    SFI_DMA_Transfer_Width_Height(320,240);
    SFI_DMA_Source_Width(1024);//
	SFI_DMA_Source_Start_Address(0);//
	Start_SFI_DMA();
    Check_Busy_SFI_DMA();

    Canvas_Image_Start_address(layer3_start_addr);//Layer 3
	Canvas_image_width(1024);//

	SFI_DMA_Destination_Upper_Left_Corner(0,0);
    SFI_DMA_Transfer_Width_Height(320,240);
    SFI_DMA_Source_Width(1024);//
	SFI_DMA_Source_Start_Address(im*1024*600*2*2);//
	Start_SFI_DMA();
    Check_Busy_SFI_DMA();

 
	 for(i=0;i<160;i++)
	 {
	  Select_PIP1_Parameter();
	  PIP_Display_Start_XY(80+i,40+i);
	  //PIP_Display_Start_XY(80+i,40);
	  delay_ms(1);
	  Select_PIP2_Parameter();
	  PIP_Display_Start_XY(80+320-i,40+240-i);
	  //PIP_Display_Start_XY(80+320-i,40+240);
	  delay_ms(10);
	 }

	 for(i=0;i<160;i++)
	 {
	  Select_PIP1_Parameter();
	  PIP_Display_Start_XY(80+159-i,40+159-i);
	  //PIP_Display_Start_XY(80+159-i,40+159);
	  delay_ms(1);
	  Select_PIP2_Parameter();
	  PIP_Display_Start_XY(80+320-159+i,40+240-159+i);
	  //PIP_Display_Start_XY(80+320-159+i,40+240-159);
	  delay_ms(10);
	  }
	
	  delay_ms(1000);
		NextStep();

	  Disable_PIP1();
	  Disable_PIP2();

}


void App_Demo_Waveform(void)
{
    unsigned int i,h;

	unsigned int point1y,point2y;
	unsigned int point21y,point22y;
	unsigned int point31y,point32y;
	point2y = 0; //initial value
	point22y = 0; //initial value
	point32y = 0; //initial value

  #define grid_width 601
  #define grid_high  401
  #define grid_gap 50
    
	Select_Main_Window_16bpp();
	Main_Image_Start_Address(0);				
	Main_Image_Width(1024);							
	Main_Window_Start_XY(0,0);

 	Canvas_Image_Start_address(0);//Layer 1
	Canvas_image_width(1024);//
    Active_Window_XY(0,0);
	Active_Window_WH(1024,600);

 	Foreground_color_65k(Blue);
	Line_Start_XY(0,0);
	Line_End_XY(1023,575);
	Start_Square_Fill();

	Foreground_color_65k(Blue2);
	Line_Start_XY(0,576);
	Line_End_XY(1023,599);
	Start_Square_Fill();


 	Foreground_color_65k(White);
	Background_color_65k(Blue2);
	CGROM_Select_Internal_CGROM();
	Font_Select_12x24_24x24();
	Goto_Text_XY(0,Line24);
	Show_String("           Application Demo Waveform");


 	Foreground_color_65k(White);
	Background_color_65k(Blue);
	CGROM_Select_Internal_CGROM();
	Font_Select_12x24_24x24();
	Goto_Text_XY(0,Line22);
	Show_String("BTE memory copy + Geometric draw demo waveform");
	//creat grid 500*400 to layer2 used geometric draw 

	Canvas_Image_Start_address(layer2_start_addr);//Layer 2



    Foreground_color_65k(Black);  //clear layer2 to color black
	Line_Start_XY(0,0);
	Line_End_XY(1023,599);
	Start_Square_Fill();

    for(i=0;i<=grid_width;i+=grid_gap)
	{
	 Foreground_color_65k(color65k_grayscale12);
	 Line_Start_XY(i,0);
     Line_End_XY(i,grid_high-1);
	 Start_Line();
	}

	 for(i=0;i<=grid_high;i+=grid_gap)
	{
	 Foreground_color_65k(color65k_grayscale12);
	 Line_Start_XY(0,i);
     Line_End_XY(grid_width-1,i);
	 Start_Line();
	}

	//BTE memory(move) grid to layer1
	   BTE_S0_Color_16bpp();
       BTE_S0_Memory_Start_Address(layer2_start_addr);
       BTE_S0_Image_Width(1024);
       BTE_S0_Window_Start_XY(0,0);

//       BTE_S1_Color_16bpp();
//       BTE_S1_Memory_Start_Address(800*600*2*2);
//       BTE_S1_Image_Width(800);
//       BTE_S1_Window_Start_XY(0,0);

       BTE_Destination_Color_16bpp();  
       BTE_Destination_Memory_Start_Address(0);
       BTE_Destination_Image_Width(1024);
       BTE_Destination_Window_Start_XY(100,40);  
       BTE_Window_Size(601,401);

	   //move with ROP 0 
       BTE_ROP_Code(12); //memory copy s0(layer2)grid to layer1  
       BTE_Operation_Code(2); //BTE move
       BTE_Enable();
       Check_BTE_Busy();


	   Canvas_Image_Start_address(0);//Layer 1
       
	 h=0;
	do{
	    for(i=0;i<600;i+=2)
	   {
		// copy layer2 grid column to layer1
		 BTE_S0_Window_Start_XY(i,0);

		 BTE_Destination_Window_Start_XY(100+i,40);  
         BTE_Window_Size(2,401);
		 BTE_Enable();
         Check_BTE_Busy();

	
		 point1y = point2y;
         point2y = rand()%90;//
		
		 point21y = point22y;
         point22y = rand()%99;//
//		
		 point31y = point32y;
         point32y = rand()%67;//
		 
		 Foreground_color_65k(color65k_yellow);//
		 Line_Start_XY(i+100,point1y+80);
		 Line_End_XY(i+1+100,point2y+80);
	     Start_Line();

		 Foreground_color_65k(color65k_purple);//
		 Line_Start_XY(i+100,point21y+200);
		 Line_End_XY(i+1+100,point22y+200);
	     Start_Line();
//
		 Foreground_color_65k(color65k_green);//
		 Line_Start_XY(i+100,point31y+300);
		 Line_End_XY(i+1+100,point32y+300);
	     Start_Line();

		 //delay_ms(1000);	
	    }
	   
	   h++;
	  }
	 while(h<10);  

 		NextStep();

}


void App_Demo_Scrolling_Text(void)
{
    unsigned int i; 

 

 	Select_Main_Window_16bpp();
	Main_Image_Start_Address(0);				
	Main_Image_Width(1024);							
	Main_Window_Start_XY(0,0);

	Canvas_Image_Start_address(layer2_start_addr);
	Canvas_image_width(1024);//
    Active_Window_XY(0,0);
	Active_Window_WH(1024,600);

 	Foreground_color_65k(Black);
	Line_Start_XY(0,0);
	Line_End_XY(1023,575);
	Start_Square_Fill();

	Foreground_color_65k(Blue2);
	Line_Start_XY(0,576);
	Line_End_XY(1023,599);
	Start_Square_Fill();




	Foreground_color_65k(White);
	Background_color_65k(Blue2);
	CGROM_Select_Internal_CGROM();
	Font_Select_12x24_24x24();
	Goto_Text_XY(0,Line24);
	Show_String("               Demo Scrolling Text");
	Foreground_color_65k(White);
	Background_color_65k(Black);
	Font_Select_12x24_24x24();
	Goto_Text_XY(0,Line23);
	Show_String("Used Move BTE with Chroma Key ");



    //DMA initial setting
	Enable_SFlash_SPI();
    Select_SFI_1();
    Select_SFI_DMA_Mode();
    Select_SFI_24bit_Address();

    //Select_SFI_Waveform_Mode_0();
    Select_SFI_Waveform_Mode_3();

    //Select_SFI_0_DummyRead();	//normal read mode
    Select_SFI_8_DummyRead(); //1byte dummy cycle
    //Select_SFI_16_DummyRead();
    //Select_SFI_24_DummyRead();

    Select_SFI_Single_Mode();
    //Select_SFI_Dual_Mode0();
    //Select_SFI_Dual_Mode1();

    SPI_Clock_Period(0);


	SFI_DMA_Destination_Upper_Left_Corner(0,40);
    SFI_DMA_Transfer_Width_Height(1024,480);
    SFI_DMA_Source_Width(1024);//
	SFI_DMA_Source_Start_Address(0);//
	Start_SFI_DMA();
    Check_Busy_SFI_DMA();


	//BTE memory(move) layer2 to layer1
	   BTE_S0_Color_16bpp();
       BTE_S0_Memory_Start_Address(layer2_start_addr);
       BTE_S0_Image_Width(1024);
       BTE_S0_Window_Start_XY(0,0);

//       BTE_S1_Color_16bpp();
//       BTE_S1_Memory_Start_Address(800*600*2*2);
//       BTE_S1_Image_Width(800);
//       BTE_S1_Window_Start_XY(0,0);

       BTE_Destination_Color_16bpp();  
       BTE_Destination_Memory_Start_Address(layer1_start_addr);
       BTE_Destination_Image_Width(1024);
       BTE_Destination_Window_Start_XY(0,0);  
       BTE_Window_Size(1024,600);

       BTE_ROP_Code(12); 
       BTE_Operation_Code(2); //BTE move
       BTE_Enable();		  //memory copy s0(layer3) to layer1  
       Check_BTE_Busy();


	  //write text to layer3
	  Canvas_Image_Start_address(layer3_start_addr);
	  Canvas_image_width(1024);//
      Active_Window_XY(0,0);
	  Active_Window_WH(1024,600);

	  Foreground_color_65k(Red);
	  Line_Start_XY(0,0);
	  Line_End_XY(1023,599);
	  Start_Square_Fill();

	Foreground_color_65k(Green);
	Background_color_65k(Red);
	CGROM_Select_Internal_CGROM();
	Font_Select_12x24_24x24();
	Goto_Text_XY(0,Line0);
	Show_String("Demo Scrolling Text");

	Foreground_color_65k(Yellow);
	Background_color_65k(Red);
	Goto_Text_XY(0,Line1);
	Show_String("Demo Scrolling Text");
	Foreground_color_65k(Magenta);
	Background_color_65k(Red);
	Goto_Text_XY(0,Line2);
	Show_String("Demo Scrolling Text");
	Foreground_color_65k(Grey);
	Background_color_65k(Red);
	Goto_Text_XY(0,Line3);
	Show_String("Demo Scrolling Text");



	  //Move BTE with chroma key layer3 to layer2 then move layer2 to layer1 to display

	  for(i=0;i<200;i+=8)
	  {    	 
	   	Canvas_Image_Start_address(layer2_start_addr);
	    Canvas_image_width(1024);//
        Active_Window_XY(0,0);
	    Active_Window_WH(1024,600);

 	     Foreground_color_65k(Black);
	     Line_Start_XY(0,0);
	     Line_End_XY(1023,520);
	     Start_Square_Fill();

		 SFI_DMA_Destination_Upper_Left_Corner(0,40);
         SFI_DMA_Transfer_Width_Height(1024,480);
         SFI_DMA_Source_Width(1024);//
	     SFI_DMA_Source_Start_Address(0);//
	     Start_SFI_DMA();
         Check_Busy_SFI_DMA();

	  //BTE memory(move) layer3 to layer2
	   //BTE_S0_Color_16bpp();
       BTE_S0_Memory_Start_Address(layer3_start_addr);
       BTE_S0_Image_Width(1024);
       BTE_S0_Window_Start_XY(0,0);

//     BTE_S1_Color_16bpp();
//     BTE_S1_Memory_Start_Address(800*600*2*2);
//     BTE_S1_Image_Width(800);
//     BTE_S1_Window_Start_XY(0,0);

       //BTE_Destination_Color_16bpp();  
       BTE_Destination_Memory_Start_Address(layer2_start_addr);
       BTE_Destination_Image_Width(1024);
       BTE_Destination_Window_Start_XY(1015-i,72);  
       BTE_Window_Size(0+i,24*4);

	   Background_color_65k(Red);//

       BTE_ROP_Code(12); 
       BTE_Operation_Code(5); //BTE move with chroma key
       BTE_Enable();		  //memory copy s0(layer3) to layer1  
       Check_BTE_Busy();

//	   Main_Image_Width(800);							
//       Main_Window_Start_XY(0,0);
//	   Main_Image_Start_Address(layer2_start_addr);//switch display windows to 			
//	   delay_ms(20);


   	  //BTE memory(move) layer2 to layer1
	   //BTE_S0_Color_16bpp();
       BTE_S0_Memory_Start_Address(layer2_start_addr);
       BTE_S0_Image_Width(1024);
       BTE_S0_Window_Start_XY(0,0);

       //BTE_Destination_Color_16bpp();  
       BTE_Destination_Memory_Start_Address(layer1_start_addr);
       BTE_Destination_Image_Width(1024);
       BTE_Destination_Window_Start_XY(0,0);  
       BTE_Window_Size(1024,600);

       BTE_ROP_Code(12); 
       BTE_Operation_Code(2); //BTE move
       BTE_Enable();		  //memory copy s0(layer2) to layer1  
       Check_BTE_Busy();
	  }
      
	  for(i=0;i<100;i+=8)
	  {    	 
	   	Canvas_Image_Start_address(layer2_start_addr);
	    Canvas_image_width(1024);//
        Active_Window_XY(0,0);
	    Active_Window_WH(1024,600);

 	     Foreground_color_65k(Black);
	     Line_Start_XY(0,0);
	     Line_End_XY(1023,520);
	     Start_Square_Fill();

		 SFI_DMA_Destination_Upper_Left_Corner(0,40);
         SFI_DMA_Transfer_Width_Height(1024,480);
         SFI_DMA_Source_Width(1024);//
	     SFI_DMA_Source_Start_Address(1228800);//
	     Start_SFI_DMA();
         Check_Busy_SFI_DMA();

	  //BTE memory(move) layer3 to layer2
	   //BTE_S0_Color_16bpp();
       BTE_S0_Memory_Start_Address(layer3_start_addr);
       BTE_S0_Image_Width(1024);
       BTE_S0_Window_Start_XY(i,0);

//     BTE_S1_Color_16bpp();
//     BTE_S1_Memory_Start_Address(800*600*2*2);
//     BTE_S1_Image_Width(800);
//     BTE_S1_Window_Start_XY(0,0);

       //BTE_Destination_Color_16bpp();  
       BTE_Destination_Memory_Start_Address(layer2_start_addr);
       BTE_Destination_Image_Width(1024);
       BTE_Destination_Window_Start_XY(0,72);  
       BTE_Window_Size(1023-i,24*4);

	   Background_color_65k(Red);//

       BTE_ROP_Code(12); 
       BTE_Operation_Code(5); //BTE move with chroma key
       BTE_Enable();		  //memory copy s0(layer3) to layer1  
       Check_BTE_Busy();

//	   Main_Image_Width(800);							
//       Main_Window_Start_XY(0,0);
//	   Main_Image_Start_Address(layer2_start_addr);//switch display windows to 			
//	   delay_ms(20);


   	  //BTE memory(move) layer2 to layer1
	   //BTE_S0_Color_16bpp();
       BTE_S0_Memory_Start_Address(layer2_start_addr);
       BTE_S0_Image_Width(1024);
       BTE_S0_Window_Start_XY(0,0);

       //BTE_Destination_Color_16bpp();  
       BTE_Destination_Memory_Start_Address(layer1_start_addr);
       BTE_Destination_Image_Width(1024);
       BTE_Destination_Window_Start_XY(0,0);  
       BTE_Window_Size(1024,600);

       BTE_ROP_Code(12); 
       BTE_Operation_Code(2); //BTE move
       BTE_Enable();		  //memory copy s0(layer2) to layer1  
       Check_BTE_Busy();
	  }

	 		NextStep();

}



void App_Demo_multi_frame_buffer(void)
{    unsigned int i,j;
      unsigned long im=1;
    Select_Main_Window_16bpp();
	Main_Image_Start_Address(0);				
	Main_Image_Width(1024);							
	Main_Window_Start_XY(0,0);

      //DMA initial setting
	Enable_SFlash_SPI();
    Select_SFI_1();
    Select_SFI_DMA_Mode();
    Select_SFI_24bit_Address();

    //Select_SFI_Waveform_Mode_0();
    Select_SFI_Waveform_Mode_3();

    //Select_SFI_0_DummyRead();	//normal read mode
    Select_SFI_8_DummyRead(); //1byte dummy cycle
    //Select_SFI_16_DummyRead();
    //Select_SFI_24_DummyRead();

    Select_SFI_Single_Mode();
    //Select_SFI_Dual_Mode0();
    //Select_SFI_Dual_Mode1();

    SPI_Clock_Period(0);

	SFI_DMA_Destination_Upper_Left_Corner(180,40);
    SFI_DMA_Transfer_Width_Height(640,480);
    SFI_DMA_Source_Width(1024);//


 for(i=0;i<6;i++)
  {

	Canvas_Image_Start_address(im*1024*600*2*i);//Layer1~6
	Canvas_image_width(1024);//
    Active_Window_XY(0,0);
	Active_Window_WH(1024,600);

 	Foreground_color_65k(Black);
	Line_Start_XY(0,0);
	Line_End_XY(1024,575);
	Start_Square_Fill();

	Foreground_color_65k(Blue2);
	Line_Start_XY(0,576);
	Line_End_XY(1023,599);
	Start_Square_Fill();


	Foreground_color_65k(White);
	Background_color_65k(Blue2);
	CGROM_Select_Internal_CGROM();
	Font_Select_12x24_24x24();
	Goto_Text_XY(0,Line24);
	Show_String("             Demo Multi Frame Buffer");





	  SFI_DMA_Source_Start_Address(im*640*480*2*i);//
	  Start_SFI_DMA();
      Check_Busy_SFI_DMA();
	  //delay_ms(500);
	  delay_ms(50);
	  Main_Image_Width(1024);							
      Main_Window_Start_XY(0,0);
	  Main_Image_Start_Address(im*1024*600*2*i);//switch display windows to 
	 }
	//delay_ms(2000);
//	Color_Bar_ON();
    
	//set canvas to 8188 
    Select_Main_Window_16bpp();
	Main_Image_Start_Address(0);				
	Main_Image_Width(8188);							
	Main_Window_Start_XY(0,0);	
	Canvas_Image_Start_address(0);
	Canvas_image_width(8188);//
	Active_Window_XY(0,0);
	Active_Window_WH(8188,600);
	
	for(im=0;im<6;im++)
    {
	Canvas_Image_Start_address(0);//Layer1~6

 	Foreground_color_65k(Black);
	Line_Start_XY(0+im*1024,0);
	Line_End_XY(1023+im*1024,575);
	Start_Square_Fill();

	Foreground_color_65k(Blue2);
	Line_Start_XY(0+im*1024,576);
	Line_End_XY(1023+im*1024,599);
	Start_Square_Fill();


    SFI_DMA_Destination_Upper_Left_Corner(80+im*1024,40);
	SFI_DMA_Source_Start_Address(im*640*480*2);//
	Start_SFI_DMA();
    Check_Busy_SFI_DMA();


	Foreground_color_65k(White);
	Background_color_65k(Blue2);
	CGROM_Select_Internal_CGROM();
	Font_Select_12x24_24x24();
	Goto_Text_XY(i*1024,Line24);
	Show_String("             Demo Mulit Frame Buffer");

	}
//	Color_Bar_OFF();

   for(j=0;j<5;j++)
   {
	for(i=0;i<1024;i++)
	{
	 Main_Window_Start_XY(i+j*1024,0);
	 delay_ms(1);
	}
    delay_ms(300);	
   }

   for(j=5;j>0;j--)
   {
	for(i=0;i<1024;i++)
	{
	 Main_Window_Start_XY(j*1024-i,0);
	 delay_ms(5);
	}

   }

   delay_ms(500);

    		NextStep();
}



void App_Demo_slide_frame_buffer(void)
{		unsigned long im=1;
     unsigned int i,j;
    
    Select_Main_Window_16bpp();
	Main_Image_Start_Address(0);				
	Main_Image_Width(1024);							
	Main_Window_Start_XY(0,0);

      //DMA initial setting
	Enable_SFlash_SPI();
    Select_SFI_1();
    Select_SFI_DMA_Mode();
    Select_SFI_24bit_Address();

    //Select_SFI_Waveform_Mode_0();
    Select_SFI_Waveform_Mode_3();

    //Select_SFI_0_DummyRead();	//normal read mode
    Select_SFI_8_DummyRead(); //1byte dummy cycle
    //Select_SFI_16_DummyRead();
    //Select_SFI_24_DummyRead();

    Select_SFI_Single_Mode();
    //Select_SFI_Dual_Mode0();
    //Select_SFI_Dual_Mode1();

    SPI_Clock_Period(0);

	SFI_DMA_Destination_Upper_Left_Corner(0,0);
    SFI_DMA_Transfer_Width_Height(1024,600);
    SFI_DMA_Source_Width(1024);//


	//Color_Bar_ON();
    
	//set canvas to 1600
    Select_Main_Window_16bpp();
	Main_Image_Start_Address(0);				
	Main_Image_Width(2048);							
	Main_Window_Start_XY(0,0);	
	Canvas_Image_Start_address(0);
	Canvas_image_width(2048);//
	Active_Window_XY(0,0);
	Active_Window_WH(2048,1200);
	
	Canvas_Image_Start_address(0);//

 	Foreground_color_65k(Black);
	Line_Start_XY(0,0);
	Line_End_XY(2047,1199);
	Start_Square_Fill();

    SFI_DMA_Destination_Upper_Left_Corner(0,0);
	SFI_DMA_Source_Start_Address(0);//
	Start_SFI_DMA();
    Check_Busy_SFI_DMA();
 
    SFI_DMA_Destination_Upper_Left_Corner(1024,0);
	SFI_DMA_Source_Start_Address(im*1024*600*2);//
	Start_SFI_DMA();
    Check_Busy_SFI_DMA();

	SFI_DMA_Destination_Upper_Left_Corner(0,600);
	SFI_DMA_Source_Start_Address(im*1024*600*4);//
	Start_SFI_DMA();
    Check_Busy_SFI_DMA();

	SFI_DMA_Destination_Upper_Left_Corner(1024,600);
	SFI_DMA_Source_Start_Address(im*1024*600*6);//
	Start_SFI_DMA();
    Check_Busy_SFI_DMA();


	Foreground_color_65k(White);
	Background_color_65k(Blue2);
	CGROM_Select_Internal_CGROM();
	Font_Select_12x24_24x24();
	Goto_Text_XY(0*1024,Line24);
	Show_String("             Demo slide Buffer");
	
	//Color_Bar_OFF();


	for(i=0;i<2048-1024+1;i++)
	{
	 Main_Window_Start_XY(i,0);
	 delay_ms(5);
	}
    delay_ms(1);	
 
	for(j=0;j<1200-600+1;j++)
	{
	 Main_Window_Start_XY(1024,j);
	 delay_ms(5);
	}	
	delay_ms(1);


	for(i=2048-1024;i>0;i--)
	{
	 Main_Window_Start_XY(i,600);
	 delay_ms(5);
	}
	Main_Window_Start_XY(0,600);
	delay_ms(1);
    delay_ms(5);	
 
	for(j=1200-600;j>0;j--)
	{
	 Main_Window_Start_XY(0,j);
	 delay_ms(5);
	}
	Main_Window_Start_XY(0,0);
	delay_ms(5);	
	delay_ms(1);

 		NextStep();
}


void App_Demo_Alpha_Blending(void)
{		 unsigned long im=1;
	    unsigned int i,j;

    Select_Main_Window_16bpp();
	Main_Image_Start_Address(layer1_start_addr);				
	Main_Image_Width(1024);							
	Main_Window_Start_XY(0,0);

	Canvas_Image_Start_address(layer1_start_addr);//
	Canvas_image_width(1024);//
    Active_Window_XY(0,0);
	Active_Window_WH(1024,600);

 	Foreground_color_65k(Black);
	Line_Start_XY(0,0);
	Line_End_XY(1023,575);
	Start_Square_Fill();

	Foreground_color_65k(Blue2);
	Line_Start_XY(0,576);
	Line_End_XY(1023,599);
	Start_Square_Fill();


	Foreground_color_65k(White);
	Background_color_65k(Blue2);
	CGROM_Select_Internal_CGROM();
	Font_Select_12x24_24x24();
	Goto_Text_XY(0,Line24);
	Show_String("               Demo Alpha Blending");
	Foreground_color_65k(White);
	Background_color_65k(Black);
	Font_Select_12x24_24x24();
	Goto_Text_XY(0,Line23);
	Show_String("Fade in and fade out");

	//DMA initial setting
	Enable_SFlash_SPI();
    Select_SFI_1();
    Select_SFI_DMA_Mode();
    Select_SFI_24bit_Address();

    //Select_SFI_Waveform_Mode_0();
    Select_SFI_Waveform_Mode_3();

    //Select_SFI_0_DummyRead();	//normal read mode
    Select_SFI_8_DummyRead(); //1byte dummy cycle
    //Select_SFI_16_DummyRead();
    //Select_SFI_24_DummyRead();

    Select_SFI_Single_Mode();
    //Select_SFI_Dual_Mode0();
    //Select_SFI_Dual_Mode1();
	
	SPI_Clock_Period(0);


	//Clear layer2 to color black
	Canvas_Image_Start_address(layer2_start_addr);//
    Foreground_color_65k(Black);
	Line_Start_XY(0,0);
	Line_End_XY(1023,599);
	Start_Square_Fill();

    //DMA picture to layer2
	SFI_DMA_Destination_Upper_Left_Corner(80,40);
    SFI_DMA_Transfer_Width_Height(640,480);
    SFI_DMA_Source_Width(1024);//
	SFI_DMA_Source_Start_Address(0);//
	Start_SFI_DMA();
    Check_Busy_SFI_DMA();


	//Clear layer3 to color black
	Canvas_Image_Start_address(layer3_start_addr);//
    Foreground_color_65k(Black);
	Line_Start_XY(0,0);
	Line_End_XY(1023,599);
	Start_Square_Fill();

    //DMA picture to layer3
	SFI_DMA_Destination_Upper_Left_Corner(80,40);
    SFI_DMA_Transfer_Width_Height(640,480);
    SFI_DMA_Source_Width(1024);//
	SFI_DMA_Source_Start_Address(im*1024*600*2);//
	Start_SFI_DMA();
    Check_Busy_SFI_DMA();

	//BTE move alpha blending by picture 
	 BTE_Destination_Color_16bpp();  
     BTE_Destination_Memory_Start_Address(layer1_start_addr);
     BTE_Destination_Image_Width(1024);
     BTE_Destination_Window_Start_XY(0,0);  
     BTE_Window_Size(1024,520);

     BTE_S0_Color_16bpp();
     BTE_S0_Memory_Start_Address(layer2_start_addr);
     BTE_S0_Image_Width(1024);
     BTE_S0_Window_Start_XY(0,0);

     BTE_S1_Color_16bpp();
     BTE_S1_Memory_Start_Address(layer3_start_addr);
     BTE_S1_Image_Width(1024);
     BTE_S1_Window_Start_XY(0,0);


	BTE_ROP_Code(15);
    BTE_Operation_Code(10); //BTE move  

  for(j=0;j<6;j+=2)
  {
	//DMA picture to layer2
	Canvas_Image_Start_address(layer2_start_addr);//
    SFI_DMA_Destination_Upper_Left_Corner(80,40);
    SFI_DMA_Transfer_Width_Height(640,480);
    SFI_DMA_Source_Width(1024);//
	SFI_DMA_Source_Start_Address(im*j*640*480*2);//
	Start_SFI_DMA();
    Check_Busy_SFI_DMA();
	//DMA picture to layer3
	Canvas_Image_Start_address(layer3_start_addr);//
	SFI_DMA_Source_Start_Address(im*(j+1)*640*480*2);//
	Start_SFI_DMA();
    Check_Busy_SFI_DMA();

    for(i=0;i<32;i++)
    {
	 BTE_Alpha_Blending_Effect(i);
	 BTE_Enable();
	 delay_ms(200);
    }

    for(i=32;i>0;i--)
    {
	 BTE_Alpha_Blending_Effect(i);
	 BTE_Enable();
	 delay_ms(200);
    }
   }

 	NextStep();

} 

void mono_Demo(void)
{

	Select_Main_Window_16bpp();
	Main_Image_Start_Address(0);				
	Main_Image_Width(1024);							
	Main_Window_Start_XY(0,0);	

    Canvas_Image_Start_address(0);//Layer 1
	Canvas_image_width(1024);//
    Active_Window_XY(0,0);
	Active_Window_WH(1024,600);

 // 	Color_Bar_ON();
 // 	NextStep();
  //	Color_Bar_OFF();


	Foreground_color_65k(Red);
	Line_Start_XY(0,0);
	Line_End_XY(1023,599);
	Start_Square_Fill();
	NextStep();
	Foreground_color_65k(Green);
	Line_Start_XY(0,0);
	Line_End_XY(1023,599);
	Start_Square_Fill();
	NextStep();
 	Foreground_color_65k(Blue);
	Line_Start_XY(0,0);
	Line_End_XY(1023,599);
	Start_Square_Fill();
	NextStep();
	Foreground_color_65k(Cyan);
	Line_Start_XY(0,0);
	Line_End_XY(1023,599);
	Start_Square_Fill();
	NextStep();
	Foreground_color_65k(Yellow);
	Line_Start_XY(0,0);
	Line_End_XY(1023,599);
	Start_Square_Fill();
	NextStep();
  	Foreground_color_65k(Magenta);
	Line_Start_XY(0,0);
	Line_End_XY(1023,599);
	Start_Square_Fill();
	NextStep();
 	Foreground_color_65k(White);
	Line_Start_XY(0,0);
	Line_End_XY(1023,599);
	Start_Square_Fill();
	NextStep();
  	Foreground_color_65k(Black);
	Line_Start_XY(0,0);
	Line_End_XY(1023,599);
	Start_Square_Fill();
	NextStep();
}


void Text_Demo(void)
{
    unsigned int i,j;
	Select_Main_Window_16bpp();
	Main_Image_Start_Address(0);				
	Main_Image_Width(1024);							
	Main_Window_Start_XY(0,0);	

    Canvas_Image_Start_address(0);//Layer 1
	Canvas_image_width(1024);//
    Active_Window_XY(0,0);
	Active_Window_WH(1024,600);

 // 	Color_Bar_ON();
 // 	NextStep();
  //	Color_Bar_OFF();



 	Foreground_color_65k(White);
	Line_Start_XY(0,0);
	Line_End_XY(1023,575);
	Start_Square_Fill();

	Foreground_color_65k(Blue2);
	Line_Start_XY(0,576);
	Line_End_XY(1023,599);
	Start_Square_Fill();

  /////////////////////////////////////////////////////////////////////////////	   
	LCD_DisplayString(0,Line1 ,"EastRising Technology",Blue2,White);
	Foreground_color_65k(White);
	Background_color_65k(Blue2);
	CGROM_Select_Internal_CGROM();
	Font_Select_12x24_24x24();
 	Goto_Text_XY(0,Line3);
	Show_String("www.buydisplay.ocm");
	Foreground_color_65k(Blue2);
	Background_color_65k(White);
	Goto_Text_XY(0,Line5);
	Show_String("10.1 inch TFT Module  1024*600 Dots");

	NextStep();

  
 	Foreground_color_65k(White);
	Line_Start_XY(0,0);
	Line_End_XY(1023,599);
	Start_Square_Fill();


	Foreground_color_65k(Black);
	Background_color_65k(White);
	CGROM_Select_Internal_CGROM();
	Font_Select_8x16_16x16();
	Goto_Text_XY(0,10);
	Show_String("Embedded 8x16 ASCII Character");

	Font_Select_12x24_24x24();
	Goto_Text_XY(0,26);
	Show_String("Embedded 12x24 ASCII Character");

	Font_Select_16x32_32x32();
	Goto_Text_XY(0,50);
	Show_String("Embedded 16x32 ASCII Character");

   	/*
	Font_Width_X2();
	Goto_Text_XY(0,16);
	Show_String("Character Width Enlarge x2");
	Font_Width_X1();
	Font_Height_X2();
	Goto_Text_XY(0,32);
	Show_String("Character High Enlarge x2");
	Font_Width_X2();
	Font_Height_X2();
	Goto_Text_XY(0,64);
	Show_String("Character Width & High Enlarge x2");
	*/

	Font_Select_8x16_16x16();
	Font_Width_X1();
	Font_Height_X1();
	Goto_Text_XY(0,100);
	Show_String("Supporting Genitop Inc. UNICODE/BIG5/GB etc. Serial Character ROM with 16x16/24x24/32X32 dots Font.");
	Goto_Text_XY(0,116);
	Show_String("The supporting product numbers are GT21L16TW/GT21H16T1W, GT23L16U2W, GT23L24T3Y/GT23H24T3Y, GT23L24M1Z, and GT23L32S4W/GT23H32S4W, GT23L24F6Y, GT23L24S1W.");
	


	  //Foreground_color_65k(color65k_yellow);
      //Background_color_65k(color65k_purple);

	   //Font_Select_UserDefine_Mode();
       //CGROM_Select_Internal_CGROM();
        CGROM_Select_Genitop_FontROM();

	 //GTFont_Select_GT21L16TW_GT21H16T1W();
     //GTFont_Select_GT23L16U2W();
     GTFont_Select_GT23L24T3Y_GT23H24T3Y();
     //GTFont_Select_GT23L24M1Z();
     //GTFont_Select_GT23L32S4W_GT23H32S4W();
     //GTFont_Select_GT20L24F6Y();
     //GTFont_Select_GT21L24S1W();
     //GTFont_Select_GT22L16A1Y();

	 
	  
	  Font_Width_X1();
      Font_Height_X1();
	  CGROM_Select_Genitop_FontROM();
      Font_Select_12x24_24x24();
	  Select_SFI_0();
      Select_SFI_Font_Mode();
      Select_SFI_24bit_Address();
      Select_SFI_Waveform_Mode_0();
      Select_SFI_0_DummyRead();
      Select_SFI_Single_Mode();
      SPI_Clock_Period(4);	 // Freq must setting <=20MHZ
	 
	  Enable_SFlash_SPI();

	  Foreground_color_65k(color65k_green);
	  Background_color_65k(color65k_blue);

	  Set_GTFont_Decoder(0x11);  //BIG5  

	  Goto_Text_XY(0,160);
   	  Show_String("Demo GT23L24T3Y BIG5:");
	  Font_Select_8x16_16x16();
	  Goto_Text_XY(0,190);
   	  Show_String("集通中文繁體16x16:RA8876 TFT 圖形控制器");
	  Font_Select_12x24_24x24();
	  Goto_Text_XY(0,214);
   	  Show_String("集通中文繁體24x24:RA8876 TFT 圖形控制器");


	  Foreground_color_65k(color65k_purple);
	  Background_color_65k(color65k_yellow);
	  Set_GTFont_Decoder(0x01);  //GB2312  
	  Goto_Text_XY(0,246);
   	  Show_String("Demo GT23L24T3Y GB2312:");
	  Font_Select_8x16_16x16();
	  Goto_Text_XY(0,276);
   	  Show_String("摩籵笢恅潠极16x16:RA8876 TFT 芞倛諷秶ん");
	  Font_Select_12x24_24x24();
	  Goto_Text_XY(0,300);
   	  Show_String("摩籵笢恅潠极16x16:RA8876 TFT 芞倛諷秶ん");

	  Set_GTFont_Decoder(0x11);  //BIG5


	  Foreground_color_65k(color65k_black); 
	  Font_Background_select_Transparency();//設定背景透明色
	  

	  Active_Window_XY(0,330);
	  Active_Window_WH(80,80);
	  Goto_Pixel_XY(0,330);
	  Show_picture(80*80,pic_80x80); 
	  Active_Window_XY(0,0);
	  Active_Window_WH(1024,600);

	  Goto_Text_XY(0,330);
   	  Show_String("Demo text transparent write");
	  Goto_Text_XY(0,354);
   	  Show_String("背景透明字寫入");



	  Font_Background_select_Color();  //設定背景使用設定顏色
	  Foreground_color_65k(color65k_black); 
	  Background_color_65k(color65k_white);

	  Goto_Text_XY(0,430);
   	  Show_String("Demo text cursor:");
	  	 
	  Goto_Text_XY(0,454);
	  Show_String("0123456789");
	  Text_cursor_initial();
	 delay_ms(1000);

	  for(i=0;i<14;i++)
	  {
	   delay_ms(100);
	   Text_Cursor_H_V(1+i,15-i);	   
	  }
	  	 delay_ms(2000);

	  Disable_Text_Cursor();

	  CGROM_Select_Internal_CGROM();
	  Font_Select_8x16_16x16();

	  Foreground_color_65k(color65k_blue); 
	  Goto_Text_XY(0,484);
   	  Show_String("Demo graphic cursor:");

	  Set_Graphic_Cursor_Color_1(0xff);
      Set_Graphic_Cursor_Color_2(0x00);

	  Graphic_cursor_initial();
	  Graphic_Cursor_XY(0,508);
	  Select_Graphic_Cursor_1();  
	  	 delay_ms(2000);
	  Select_Graphic_Cursor_2();
	  delay_ms(2000);
	  Select_Graphic_Cursor_3();
	  delay_ms(2000);
	  Select_Graphic_Cursor_4();
	  delay_ms(2000);
	  Select_Graphic_Cursor_2(); 

	  for(j=0;j<2;j++)
	  {
	   for(i=0;i<1024;i++)
	   {
	    Graphic_Cursor_XY(i,508+j*20);	
		delay_ms(2);   
	   }
	  }
	   Graphic_Cursor_XY(0,508);	

	 delay_ms(2000);
	 Disable_Graphic_Cursor();

	NextStep();


 }


 void DMA_Demo(void)
{
		unsigned long i;

 ///////////////////////////////////////////////////////////////

 	Select_Main_Window_16bpp();
	Main_Image_Start_Address(0);				
	Main_Image_Width(1024);							
	Main_Window_Start_XY(0,0);

	Canvas_Image_Start_address(0);//Layer 1
	Canvas_image_width(1024);//
    Active_Window_XY(0,0);
	Active_Window_WH(1024,600);

 	Foreground_color_65k(White);
	Line_Start_XY(0,0);
	Line_End_XY(1023,575);
	Start_Square_Fill();

	Foreground_color_65k(Blue2);
	Line_Start_XY(0,576);
	Line_End_XY(1023,599);
	Start_Square_Fill();

	//Foreground_color_65k(White);
	//Background_color_65k(Blue2);
	//Goto_Text_XY(300,576);
	//Show_String("Demo DMA");


 	Foreground_color_65k(White);
	Background_color_65k(Blue2);
	CGROM_Select_Internal_CGROM();
	Font_Select_12x24_24x24();
	Goto_Text_XY(0,Line24);
	Show_String("                    Demo DMA");
	Foreground_color_65k(Black);
	Background_color_65k(White);
	Font_Select_12x24_24x24();
	Goto_Text_XY(0,Line23);
	Show_String("  Demo direct access serial FLASH to show picture");

    //DMA initial setting
	Enable_SFlash_SPI();
    Select_SFI_1();
    Select_SFI_DMA_Mode();
    Select_SFI_24bit_Address();

    //Select_SFI_Waveform_Mode_0();
    Select_SFI_Waveform_Mode_3();

    //Select_SFI_0_DummyRead();	//normal read mode
    Select_SFI_8_DummyRead(); //1byte dummy cycle
    //Select_SFI_16_DummyRead();
   //Select_SFI_24_DummyRead();

    Select_SFI_Single_Mode();
    //Select_SFI_Dual_Mode0();
   // Select_SFI_Dual_Mode1();

    SPI_Clock_Period(0);



//DMA initail normally command setting
//	LCD_CmdWrite(0x01);
//	LCD_DataWrite(0x83);	
//	LCD_CmdWrite(0xB7);
//	LCD_DataWrite(0xd4);
//	LCD_CmdWrite(0xBB);
//  LCD_DataWrite(0x00);

   /*
   //if used 32bit address Flash ex.256Mbit,512Mbit
   //must be executed following in 24bit address mode to switch to 32bit address mode

   //Select_nSS_drive_on_xnsfcs0();
   Select_nSS_drive_on_xnsfcs1();

   Reset_CPOL();
   //Set_CPOL();
   Reset_CPHA();
   //Set_CPHA();

  //Enter 4-byte mode  
   nSS_Active();
   SPI_Master_FIFO_Data_Put(0xB7);  //switch to 32bit address mode
   delay_us(10); 
   nSS_Inactive();

   Select_SFI_32bit_Address();
   */


	SFI_DMA_Destination_Upper_Left_Corner(0,0);
    SFI_DMA_Transfer_Width_Height(1024,600);
    SFI_DMA_Source_Width(1024);//

	//execute DMA to show 1024x600 picture
	 for(i=0;i<4;i++)
	 {
	  SFI_DMA_Source_Start_Address(i*1024*600*2);//
	  Start_SFI_DMA();
      Check_Busy_SFI_DMA();
	  delay_ms(30);
 	NextStep();
	 }
}

 void Geometric(void)
{unsigned int i;
 	Select_Main_Window_16bpp();
	Main_Image_Start_Address(0);				
	Main_Image_Width(1024);							
	Main_Window_Start_XY(0,0);

	Canvas_Image_Start_address(0);//Layer 1
	Canvas_image_width(1024);//
    Active_Window_XY(0,0);
	Active_Window_WH(1024,600);



///////////////////////////Square

   	Foreground_color_65k(Black);
	Line_Start_XY(0,0);
	Line_End_XY(1023,599);
	Start_Square_Fill();

   for(i=0;i<=280;i+=8)
	{Foreground_color_65k(Red);
	Line_Start_XY(0+i,0+i);
	Line_End_XY(1023-i,599-i);
	Start_Square();
	delay_ms(30);
	}

    for(i=0;i<=280;i+=8)
	{Foreground_color_65k(Black);
	Line_Start_XY(0+i,0+i);
	Line_End_XY(1023-i,599-i);
	Start_Square();
	delay_ms(30);
	}
   	delay_ms(500);
///////////////////////////Square Of Circle
   	Foreground_color_65k(Black);
	Line_Start_XY(0,0);
	Line_End_XY(1023,599);
	Start_Square_Fill();

   for(i=0;i<=280;i+=8)
	{Foreground_color_65k(Green);
	Line_Start_XY(0+i,0+i);
	Line_End_XY(1023-i,599-i);
	Circle_Square_Radius_RxRy(10,10);
	Start_Circle_Square();
	delay_ms(30);
	}

    for(i=0;i<=280;i+=8)
	{Foreground_color_65k(Black);
	Line_Start_XY(0+i,0+i);
	Line_End_XY(1023-i,599-i);
	Circle_Square_Radius_RxRy(10,10);
	Start_Circle_Square();
	delay_ms(30);
	}
   	delay_ms(500);

///////////////////////////Circle
  	Foreground_color_65k(Black);
	Line_Start_XY(0,0);
	Line_End_XY(1023,599);
	Start_Square_Fill();

   for(i=0;i<=300;i+=8)
	{Foreground_color_65k(Blue);
	Circle_Center_XY(1024/2,600/2);
	Circle_Radius_R(i);
	Start_Circle_or_Ellipse();
	delay_ms(30);
	}

    for(i=0;i<=300;i+=8)
	{Foreground_color_65k(Black);
	Circle_Center_XY(1024/2,600/2);
	Circle_Radius_R(i);
	Start_Circle_or_Ellipse();
	delay_ms(30);
	}
   	delay_ms(500);

///////////////////////////Ellipse
  	Foreground_color_65k(Black);
	Line_Start_XY(0,0);
	Line_End_XY(1023,599);
	Start_Square_Fill();

   for(i=0;i<=300;i+=8)
	{Foreground_color_65k(White);
	Circle_Center_XY(1024/2,600/2);
	Ellipse_Radius_RxRy(i+100,i);
	Start_Circle_or_Ellipse();
	delay_ms(30);
	}

    for(i=0;i<=300;i+=8)
	{Foreground_color_65k(Black);
	Circle_Center_XY(1024/2,600/2);
	Ellipse_Radius_RxRy(i+100,i);
	Start_Circle_or_Ellipse();
	delay_ms(30);
	}
   	delay_ms(500);

 ////////////////////////////Triangle
   	Foreground_color_65k(Black);
	Line_Start_XY(0,0);
	Line_End_XY(1023,599);
	Start_Square_Fill();

    for(i=0;i<=300;i+=8)
	{Foreground_color_65k(Yellow);
	Triangle_Point1_XY(1024/2,i);
	Triangle_Point2_XY(i,599-i);
	Triangle_Point3_XY(1023-i,599-i);
	Start_Triangle();
	delay_ms(30);
	}

    for(i=0;i<=300;i+=8)
	{Foreground_color_65k(Black);
	Triangle_Point1_XY(1024/2,i);
	Triangle_Point2_XY(i,599-i);
	Triangle_Point3_XY(1023-i,599-i);
	Start_Triangle();
	delay_ms(30);
	}
   	delay_ms(500);


 ////////////////////////////line
   	Foreground_color_65k(Black);
	Line_Start_XY(0,0);
	Line_End_XY(1023,599);
	Start_Square_Fill();

    for(i=0;i<=1024;i+=8)
	{Foreground_color_65k(Cyan);
	Line_Start_XY(i,0);
	Line_End_XY(1023-i,599);
	Start_Line();
	delay_ms(10);
	}
     for(i=0;i<=600;i+=8)
	{Foreground_color_65k(Cyan);
	Line_Start_XY(0,599-i);
	Line_End_XY(1023,i);
	Start_Line();
	delay_ms(10);
	}


    for(i=0;i<=1024;i+=8)
	{Foreground_color_65k(Black);
	Line_Start_XY(i,0);
	Line_End_XY(1023-i,599);
	Start_Line();
	delay_ms(5);
	}
	for(i=0;i<=600;i+=8)
	{Foreground_color_65k(Black);
	Line_Start_XY(0,599-i);
	Line_End_XY(1023,i);
	Start_Line();
	delay_ms(5);
	}

   	delay_ms(500);


}

void gray(void)
{ int i,col,line;
 	Select_Main_Window_16bpp();
	Main_Image_Start_Address(0);				
	Main_Image_Width(1024);							
	Main_Window_Start_XY(0,0);

	Canvas_Image_Start_address(0);//Layer 1
	Canvas_image_width(1024);//
    Active_Window_XY(0,0);
	Active_Window_WH(1024,600);


	 col=0;line=0;
	for(i=0;i<32;i++)
   	{	Foreground_color_65k(i<<11);
		Line_Start_XY(col,line);
		Line_End_XY(col+32,line+100);
		Start_Square_Fill();
		col+=32;
	}
	   col=0;line=100;
 	for(i=31;i>=0;i--)
   	{	Foreground_color_65k(i<<11);
		Line_Start_XY(col,line);
		Line_End_XY(col+32,line+100);
		Start_Square_Fill();
		col+=32;
	}

	 col=0;line=200;
	for(i=0;i<64;i++)
   	{	Foreground_color_65k(i<<5);
		Line_Start_XY(col,line);
		Line_End_XY(col+16,line+100);
		Start_Square_Fill();
		col+=16;
	}
	   col=0;line=300;
 	for(i=63;i>=0;i--)
   	{	Foreground_color_65k(i<<5);
		Line_Start_XY(col,line);
		Line_End_XY(col+16,line+100);
		Start_Square_Fill();
		col+=16;
	}


	 col=0;line=400;
	for(i=0;i<32;i++)
   	{	Foreground_color_65k(i);
		Line_Start_XY(col,line);
		Line_End_XY(col+32,line+100);
		Start_Square_Fill();
		col+=32;
	}
	   col=0;line=500;
 	for(i=31;i>=0;i--)
   	{	Foreground_color_65k(i);
		Line_Start_XY(col,line);
		Line_End_XY(col+32,line+100);
		Start_Square_Fill();
		col+=32;
	}


	  delay_ms(1000);
 	NextStep();
}

