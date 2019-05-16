


/* touch panel interface define */
sbit TCLK	   =    P3^1;   //clock
sbit TCS        =    P3^4; //chip select
sbit TDIN       =    P3^0;	//data input
sbit DOUT      =    P3^3;	//data output
sbit PEN        =    P3^2;   //Touch screen response signal detection

 #define uchar      unsigned char
#define uint       unsigned int
#define ulong      unsigned long


#define lcd_width    	1024
#define lcd_height		600

unsigned int x[1]=0; 		//Current coordinates
unsigned int y[1]=0;	
							

/////////////////////Touch-screen calibration parameters							
	float xfac=0;					
	float yfac=0;
	short xoff=0;
	short yoff=0;	   

unsigned char touchtype=0;

				
//The default is touchtype=0
unsigned char CMD_RDX=0XD0;
unsigned char CMD_RDY=0X90;
 


 void FAST_Clear(unsigned int  colour)
 {	Select_Main_Window_16bpp();
	Main_Image_Start_Address(0);				
	Main_Image_Width(1024);							
	Main_Window_Start_XY(0,0);

	Canvas_Image_Start_address(0);//Layer 1
	Canvas_image_width(1024);//
    Active_Window_XY(0,0);
	Active_Window_WH(1024,600);

 	Foreground_color_65k(colour);
	Line_Start_XY(0,0);
	Line_End_XY(1024,600);
	Start_Square_Fill();
}


 //画点
//x,y:坐标
//POINT_COLOR:此点的颜色
void LCD_DrawPoint(unsigned int x1,unsigned int y1,unsigned int POINT_COLOR)
{
  LCD_SetCursor(x1,y1);
  LCD_WriteRAM_Prepare();
  LCD_DataWrite(POINT_COLOR);
  LCD_DataWrite(POINT_COLOR>>8);
}



void LCD_DrawLine(unsigned int x1,unsigned int x2,unsigned int y1,unsigned int y2,unsigned int POINT_COLOR)
{
	unsigned int t; 
	int xerr=0,yerr=0,delta_x,delta_y,distance; 
	int incx,incy,uRow,uCol; 

	delta_x=x2-x1; //计算坐标增量 
	delta_y=y2-y1; 
	uRow=x1; 
	uCol=y1; 
	if(delta_x>0)incx=1; //设置单步方向 
	else if(delta_x==0)incx=0;//垂直线 
	else {incx=-1;delta_x=-delta_x;} 
	if(delta_y>0)incy=1; 
	else if(delta_y==0)incy=0;//水平线 
	else{incy=-1;delta_y=-delta_y;} 
	if( delta_x>delta_y)distance=delta_x; //选取基本增量坐标轴 
	else distance=delta_y; 
	for(t=0;t<=distance+1;t++ )//画线输出 
	{  
	
	LCD_SetPoint(uRow,uCol,POINT_COLOR);
		xerr+=delta_x ; 
		yerr+=delta_y ; 
		if(xerr>distance) 
		{ 
			xerr-=distance; 
			uRow+=incx; 
		} 
		if(yerr>distance) 
		{ 
			yerr-=distance; 
			uCol+=incy; 
		} 
	}  
}






	 			    					   
// SPI write data
// Write data to the touchscreen IC 1byte
// num: data to be written
void TP_Write_Byte(unsigned char num)    
{  
	unsigned char count=0;   
	for(count=0;count<8;count++)  
	{ 	  
		if(num&0x80)TDIN=1;  
		else TDIN=0;   
		num<<=1;    
		TCLK=0; 
		_nop_();_nop_();_nop_();_nop_();
		TCLK=1;		//Rising Edge 	        
	}		 			    
} 		 
// SPI read data
// Read adc value from the touch screen IC
// CMD: Directive
// Returns: read data	   
unsigned int TP_Read_AD(unsigned char CMD)	  
{ 	 
	unsigned char count=0; 	  
	unsigned int Num=0; 
	TCLK=0;		//Pulling low the clock	 
	TDIN=0; 	//Pulling low the data line
	TCS=0; 		//Select the touchscreen IC
	_nop_();
	TP_Write_Byte(CMD);//Send command word

	_nop_();_nop_();_nop_();_nop_();_nop_();_nop_();
	TCLK=1; 
	_nop_();_nop_();_nop_();_nop_();     	    
   	   
	TCLK=0;		//To a clock, clear BUSY
	_nop_();_nop_();_nop_();_nop_();
     	     	    
	for(count=0;count<12;count++)//only the high 12
	{ 				  
		Num<<=1; 	 
		TCLK=0;	//Rising Edge  	    	    
		_nop_();_nop_();_nop_();_nop_();  
 		TCLK=1;
 		if(DOUT)Num++; 		 
	}  	
	TCS=1;		//Release chip select	 
	return(Num);   
}
// Reads a coordinate value (x or y)
// Sequential read READ_TIMES secondary data, these data in ascending order,
// Then remove the minimum and maximum number LOST_VAL, averaging
// xy: Directive (CMD_RDX / CMD_RDY)
// Returns: read data
#define READ_TIMES 10 	//Reads TIMES
#define LOST_VAL 2	  	//Discard value
unsigned int TP_Read_XOY(unsigned char xy)
{	unsigned int i, j;
	unsigned int buf[READ_TIMES];
	unsigned int sum=0;
	unsigned int temp;
	for(i=0;i<READ_TIMES;i++)buf[i]=TP_Read_AD(xy);		 		    
	for(i=0;i<READ_TIMES-1; i++)//Sequence
	{
		for(j=i+1;j<READ_TIMES;j++)
		{
			if(buf[i]>buf[j])//Ascending
			{
				temp=buf[i];
				buf[i]=buf[j];
				buf[j]=temp;
			}
		}
	}	  
	sum=0;
	for(i=LOST_VAL;i<READ_TIMES-LOST_VAL;i++)sum+=buf[i];
	temp=sum/(READ_TIMES-2*LOST_VAL);
	return temp;   
} 
// Read the x, y coordinates
// Minimum of not less than 100.
// x, y: read coordinates
// Return value: 0, failed; a successful.
unsigned char TP_Read_XY(unsigned int *x,unsigned int *y)
{
	unsigned int xtemp,ytemp;			 	 		  
	xtemp=TP_Read_XOY(CMD_RDX);
	ytemp=TP_Read_XOY(CMD_RDY);	  												   
	//if(xtemp<100||ytemp<100)return 0;//Reading failure
	*x=xtemp;
	*y=ytemp;
	return 1;//Reading success
}
// 2 consecutive reads touchscreen IC, and this deviation should not exceed twice
// ERR_RANGE, to meet the conditions, then that reading is correct, otherwise erroneous readings.
// This function can greatly improve the accuracy of
// x, y: read coordinates
// Return value: 0, failed; a successful.
#define ERR_RANGE 100 //error range
unsigned char TP_Read_XY2(unsigned int *x,unsigned int *y) 
{
	unsigned int x1,y1;
 	unsigned int x2,y2;
 	unsigned char flag;    
    flag=TP_Read_XY(&x1,&y1);   
    if(flag==0)return(0);
    flag=TP_Read_XY(&x2,&y2);	   
    if(flag==0)return(0);   
    if(((x2<=x1&&x1<x2+ERR_RANGE)||(x1<=x2&&x2<x1+ERR_RANGE))//Twice before and after sampling within + -100
    &&((y2<=y1&&y1<y2+ERR_RANGE)||(y1<=y2&&y2<y1+ERR_RANGE)))
    {
        *x=(x1+x2)/2;
        *y=(y1+y2)/2;
        return 1;
    }else return 0;	  
}  

//////////////////////////////////////////////////////////////////////////////////		  
// Function associated with the LCD section
// Draw a touch point
// Used for calibration
// x, y: coordinates
// color: color
void TP_Drow_Touch_Point(unsigned int x,unsigned int y,unsigned int color)
{
	LCD_DrawLine(x-12,x+13,y,y,color);//Horizontal line
	LCD_DrawLine(x,x,y-12,y+13,color);//vertical line
	LCD_DrawPoint(x+1,y+1,color);
	LCD_DrawPoint(x-1,y+1,color);
	LCD_DrawPoint(x+1,y-1,color);
	LCD_DrawPoint(x-1,y-1,color);
}	  
						  
//////////////////////////////////////////////////////////////////////////////////		  
// Touch button scanning
// tp: 0, screen coordinates; a physical coordinates (calibration and other special occasions with)
// Return value: The current state of the touch screen.
// 0, no-touch touch screen; a, touch screen touch
void TP_Scan(unsigned char tp)
{			   
	if(PEN==0)//Touch screen is pressed
	delay_ms(30);	
	if(PEN==0)//Touch screen is pressed
	{
		if(tp)TP_Read_XY2(&x[0],&y[0]);//Read the physical coordinates
		else if(TP_Read_XY2(&x[0],&y[0]))//Read the screen coordinates

		{
	 		x[0]=xfac*x[0]+xoff;//Converts the screen coordinates
			y[0]=yfac*y[0]+yoff;  
	 	} 
			   
	}
	else
	{


			x[0]=0;
			y[0]=0;
	    
	}

	return ;//
}	  

 /*
// prompt string
u8* const TP_REMIND_MSG_TBL="Please use the stylus click the cross on the screen.The cross will always move until the screen adjustment is completed.";
 					  
//Tip calibration results (individual parameters)
void TP_Adj_Info_Show(u16 x0,u16 y0,u16 x1,u16 y1,u16 x2,u16 y2,u16 x3,u16 y3,u16 fac)
{	  
	POINT_COLOR=RED;
	LCD_ShowString(40,160,lcddev.width,lcddev.height,16,"x1:");
 	LCD_ShowString(40+80,160,lcddev.width,lcddev.height,16,"y1:");
 	LCD_ShowString(40,180,lcddev.width,lcddev.height,16,"x2:");
 	LCD_ShowString(40+80,180,lcddev.width,lcddev.height,16,"y2:");
	LCD_ShowString(40,200,lcddev.width,lcddev.height,16,"x3:");
 	LCD_ShowString(40+80,200,lcddev.width,lcddev.height,16,"y3:");
	LCD_ShowString(40,220,lcddev.width,lcddev.height,16,"x4:");
 	LCD_ShowString(40+80,220,lcddev.width,lcddev.height,16,"y4:");  
 	LCD_ShowString(40,240,lcddev.width,lcddev.height,16,"fac is:");     
	LCD_ShowNum(40+24,160,x0,4,16);		//
	LCD_ShowNum(40+24+80,160,y0,4,16);	//
	LCD_ShowNum(40+24,180,x1,4,16);		//
	LCD_ShowNum(40+24+80,180,y1,4,16);	//
	LCD_ShowNum(40+24,200,x2,4,16);		//
	LCD_ShowNum(40+24+80,200,y2,4,16);	//
	LCD_ShowNum(40+24,220,x3,4,16);		//
	LCD_ShowNum(40+24+80,220,y3,4,16);	//
 	LCD_ShowNum(40+56,240,fac,3,16); 	//Display value which must be within the range of 80 to 120

}
*/


// The absolute value of the difference between two numbers
// x1, x2: the need to take the difference between the two numbers
// Return value: | x1-x2 |
unsigned int my_abs(unsigned int x1,unsigned int x2)
{			 
	if(x1>x2)return x1-x2;
	else return x2-x1;
} 


		 
// Touch screen calibration code
// Get four calibration parameters
uchar TP_Adjust(void)
{								 
	unsigned int pos_temp[4][2];//Coordinate cached values
	unsigned char  cnt=0;	
	unsigned int d1,d2;
	unsigned long tem1,tem2;
	double fac; 	
	unsigned int outtime=0;
 	cnt=0;				

 
	Foreground_color_65k(Black);
	Background_color_65k(White);
	CGROM_Select_Internal_CGROM();
	Font_Select_8x16_16x16();
	Goto_Text_XY(100,40);
	Show_String("TP Need readjust!");
	Goto_Text_XY(20,80);
	Show_String("Please use the stylus click the cross on the screen.");
	Goto_Text_XY(20,100);
	Show_String("The cross will always move until the screen adjustment is completed.");


	
	TP_Drow_Touch_Point(20,20,0xf800);//Draw  point 1 
	xfac=0;//	 
	while(1)
	{	TP_Scan(1);//Scan the physical coordinates
		 if(next==0)return 1;
		if(!PEN)//Touch screen is pressed
		{
			outtime=0;		

						   			   
			pos_temp[cnt][0]=x[0];
			pos_temp[cnt][1]=y[0];
			cnt++;	  
			switch(cnt)
			{			   
				case 1:	while(!PEN);					 
					TP_Drow_Touch_Point(20,20,White);				//Clear point 1 
					TP_Drow_Touch_Point(lcd_width-20,20,Red);	//Draw  point 2
					break;
				case 2:while(!PEN);
 					TP_Drow_Touch_Point(lcd_width-20,20,White);	//Clear point 2
					TP_Drow_Touch_Point(20,lcd_height-20,Red);	//Draw  point 3
					break;
				case 3:while(!PEN);
 					TP_Drow_Touch_Point(20,lcd_height-20,White);			//Clear point 3
 					TP_Drow_Touch_Point(lcd_width-20,lcd_height-20,Red);	//Draw  point 4
					break;
				case 4:	while(!PEN); 				//All four points have been
	    		    //On equal sides
					tem1=my_abs(pos_temp[0][0],pos_temp[1][0]);//x1-x2
					tem2=my_abs(pos_temp[0][1],pos_temp[1][1]);//y1-y2
					tem1*=tem1;
					tem2*=tem2;
					d1=sqrt(tem1+tem2);//Get the distance 1, 2

					
					tem1=my_abs(pos_temp[2][0],pos_temp[3][0]);//x3-x4
					tem2=my_abs(pos_temp[2][1],pos_temp[3][1]);//y3-y4
					tem1*=tem1;
					tem2*=tem2;
					d2=sqrt(tem1+tem2);//Get 3,4 distance
					fac=(float)d1/d2;
					if(fac<0.8||fac>1.2||d1==0||d2==0)//unqualified

					{
						cnt=0;
 				    	TP_Drow_Touch_Point(lcd_width-20,lcd_height-20,White);	//Clear point 4
   	 					TP_Drow_Touch_Point(20,20,Red);								//Draw a calibration point
// 						TP_Adj_Info_Show(pos_temp[0][0],pos_temp[0][1],pos_temp[1][0],pos_temp[1][1],pos_temp[2][0],pos_temp[2][1],pos_temp[3][0],pos_temp[3][1],fac*100);//Display the data    
 						continue;
					}
					tem1=my_abs(pos_temp[0][0],pos_temp[2][0]);//x1-x3
					tem2=my_abs(pos_temp[0][1],pos_temp[2][1]);//y1-y3
					tem1*=tem1;
					tem2*=tem2;
					d1=sqrt(tem1+tem2);//Get 1,3 distance
					
					tem1=my_abs(pos_temp[1][0],pos_temp[3][0]);//x2-x4
					tem2=my_abs(pos_temp[1][1],pos_temp[3][1]);//y2-y4
					tem1*=tem1;
					tem2*=tem2;
					d2=sqrt(tem1+tem2);//Get 2,4 distance
					fac=(float)d1/d2;
					if(fac<0.8||fac>1.2)//unqualified

					{
						cnt=0;
 				    	TP_Drow_Touch_Point(lcd_width-20,lcd_height-20,White);	//Clear point 4
   	 					TP_Drow_Touch_Point(20,20,Red);								//Draw a calibration point
// 						TP_Adj_Info_Show(pos_temp[0][0],pos_temp[0][1],pos_temp[1][0],pos_temp[1][1],pos_temp[2][0],pos_temp[2][1],pos_temp[3][0],pos_temp[3][1],fac*100);//Display the data     
						continue;
					}
								   
					//Diagonal equal
					tem1=my_abs(pos_temp[1][0],pos_temp[2][0]);//x1-x3
					tem2=my_abs(pos_temp[1][1],pos_temp[2][1]);//y1-y3
					tem1*=tem1;
					tem2*=tem2;
					d1=sqrt(tem1+tem2);//Get 1,4 distance
	
					tem1=my_abs(pos_temp[0][0],pos_temp[3][0]);//x2-x4
					tem2=my_abs(pos_temp[0][1],pos_temp[3][1]);//y2-y4
					tem1*=tem1;
					tem2*=tem2;
					d2=sqrt(tem1+tem2);//Get 2,3 distance
					fac=(float)d1/d2;
					if(fac<0.8||fac>1.2)//unqualified

					{
						cnt=0;
 				    	TP_Drow_Touch_Point(lcd_width-20,lcd_height-20,White);	//Clear point 4
   	 					TP_Drow_Touch_Point(20,20,Red);								//Draw a calibration point
// 						TP_Adj_Info_Show(pos_temp[0][0],pos_temp[0][1],pos_temp[1][0],pos_temp[1][1],pos_temp[2][0],pos_temp[2][1],pos_temp[3][0],pos_temp[3][1],fac*100);//Display the data  
						continue;
					}

					//The calculation results					
					if((pos_temp[1][0]>pos_temp[0][0]))
					xfac=(float)(lcd_width-40)/(pos_temp[1][0]-pos_temp[0][0]);//xfac
		 		    else	xfac=(float)(lcd_width-40)/(pos_temp[0][0]-pos_temp[1][0]);//xfac

					xoff=(lcd_width-xfac*(pos_temp[1][0]+pos_temp[0][0]))/2;//xoff

					if((pos_temp[2][1]>pos_temp[0][1]))						  
					yfac=(float)(lcd_height-40)/(pos_temp[2][1]-pos_temp[0][1]);//yfac
		 		    else 	yfac=(float)(lcd_height-40)/(pos_temp[0][1]-pos_temp[2][1]);//yfac	
					yoff=(lcd_height-yfac*(pos_temp[2][1]+pos_temp[0][1]))/2;//yoff 
 
					if(abs(xfac)>2||abs(yfac)>2)//Touch screen and the default instead
					{
						cnt=0;
 				    	TP_Drow_Touch_Point(lcd_width-20,lcd_height-20,White);	//Clear point 4
   	 					TP_Drow_Touch_Point(20,20,Red);								//Draw a calibration point

						Foreground_color_65k(Black);
						Background_color_65k(White);
						CGROM_Select_Internal_CGROM();
						Font_Select_8x16_16x16();
						Goto_Text_XY(40,26);
						Show_String("TP Need readjust!");


						touchtype=!touchtype;//Modify the touch screen type.
						if(touchtype)//X, Y direction contrary to the screen

						{
							CMD_RDX=0X90;
							CMD_RDY=0XD0;	 
						}else				   //X, Y direction is the same as the screen
						{
							CMD_RDX=0XD0;
							CMD_RDY=0X90;	 
						}			    
						continue;
					}		

						Foreground_color_65k(Black);
						Background_color_65k(White);
						CGROM_Select_Internal_CGROM();
						Font_Select_8x16_16x16();
						Goto_Text_XY(20,150);
						Show_String("Touch Screen Adjust succeed!");
											 						 

					delay_ms(2000);
   					FAST_Clear(White);
					return 0;//Correction to complete			 
			}
		}
		delay_ms(10);
	 	 
 	}
}	 



void Load_Drow_Dialog(void)
{
	FAST_Clear(White);//Clear the screen  
	
	
	Foreground_color_65k(Black);
	Background_color_65k(White);
	CGROM_Select_Internal_CGROM();
	Font_Select_8x16_16x16();
	Goto_Text_XY(0,4);
	Show_String("EXIT");
	Goto_Text_XY(0,20);
	Show_String("EXIT");
	Goto_Text_XY(984,4);
	Show_String("CLEAR");
	Goto_Text_XY(984,20);
	Show_String("CLEAR");		 


}


void TPTEST(void)
{  uchar exit=0;
	unsigned char ss[6];	

	FAST_Clear(White);//Clear the screen

	if(xfac==0)TP_Adjust();  	//The screen calibration
	exit= TP_Adjust(); 
	if(exit==1)	return;

	Foreground_color_65k(Black);
	Background_color_65k(White);
	CGROM_Select_Internal_CGROM();
	Font_Select_8x16_16x16();
	Goto_Text_XY(24,50);
	Show_String("Drawing line");
 	Goto_Text_XY(0,4);
	Show_String("EXIT");
	Goto_Text_XY(0,20);
	Show_String("EXIT");
	Goto_Text_XY(984,4);
	Show_String("CLEAR");
	Goto_Text_XY(984,20);
	Show_String("CLEAR");


  
	while(1)
	{	

			 
		if(PEN==0 )			//Touch screen is pressed

		{	TP_Scan(0); //The scanning screen coordinates	
		 	if(x[0]<lcd_width&&y[0]<lcd_height)
			{	
				if(x[0]>(lcd_width-40)&&y[0]<16)Load_Drow_Dialog();//Clear the screen

				if(x[0]<40&&x[0]>0&&y[0]<16&&y[0]>0)return;//exit touch test

					
				LCD_DrawPoint((x[0]-1),y[0],Red);		//Draw a dot	 
 				LCD_DrawPoint((x[0]),y[0],Red);		//Draw a dot	
				LCD_DrawPoint((x[0]+1),y[0],Red);		//Draw a dot		
				LCD_DrawPoint((x[0]),y[0]-1,Red);		//Draw a dot	
				LCD_DrawPoint((x[0]),y[0]+1,Red);		//Draw a dot
	
		
				ss[0]=x[0]/10000+48;
				ss[1]=(x[0]/1000)-((x[0]/10000)*10)+48;
				ss[2]=(x[0]/100)-((x[0]/1000)*10)+48;
				ss[3]=(x[0]/10)-((x[0]/100)*10)+48;
				ss[4]=x[0]-((x[0]/10)*10)+48;
				ss[5]=0;
	
				Foreground_color_65k(Black);
				Background_color_65k(White);
				CGROM_Select_Internal_CGROM();
				Font_Select_8x16_16x16();
				Goto_Text_XY(10,305);
				Show_String("X:");
 				Goto_Text_XY(28,305);
				Show_String(ss);

	
				ss[0]=y[0]/10000+48;
				ss[1]=(y[0]/1000)-((y[0]/10000)*10)+48;
				ss[2]=(y[0]/100)-((y[0]/1000)*10)+48;
				ss[3]=(y[0]/10)-((y[0]/100)*10)+48;
				ss[4]=y[0]-((y[0]/10)*10)+48;
				ss[5]=0;

				Foreground_color_65k(Black);
				Background_color_65k(White);
				CGROM_Select_Internal_CGROM();
				Font_Select_8x16_16x16();
				Goto_Text_XY(120,305);
				Show_String("Y:");
 				Goto_Text_XY(138,305);
				Show_String(ss);

			}
		}
		else delay_ms(10);	//NO Touch	    
	
	}



}















