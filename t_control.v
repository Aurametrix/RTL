`timescale 100ns/100ps
module oopt(clk,rst,tc,row,col,integ,sample,dr,f_sync);
 
input  clk;
input  rst;
input  tc;                                                      
  
output [319:0] col; 
output [239:0] row;
output integ;
output sample;
output dr;
output f_sync; 


 
reg [319:0]col;
reg [239:0]row;
reg [239:0] row_reg;								 
reg [319:0] col_reg;	 
reg integ,sample,dr,f_sync;	 
reg [8:0]cnt;									
reg [8:0]period;								
reg [8:0]idle;									
reg [8:0]cycle;									
reg [1:0]flag; 
						 
always@(negedge clk)
begin
  if(rst)
  begin
  col<=320'b0;
	row<=240'b0;
	col_reg<=320'b0;
	row_reg<=240'b0;
	integ<=0;
	sample<=0;
	dr<=0;
	f_sync<=0;
	
	cnt<=0;
	period<=0;
	idle<=0;
	flag<=0;
	cycle<=0;
  end 
else
     begin
if(flag==2'b00&&tc==1)
       begin
      flag<=2'b1;
      integ<=1;
      cnt<=0;
  if(cycle!=0)
      begin 
     row_reg<=row_reg<<1;
     row<=row_reg<<1;       
      end
    end
else if(flag==2'b00&&tc==0)
     begin    
   if(cycle!=0)
     begin
       cnt<=cnt+2;
       row_reg<=row_reg<<1;
        row<=row_reg<<1;
   if(cnt==38)
		   begin         
          col_reg<=col_reg<<1; 
		      col<=col_reg<<1; 
       end   
     end 
   end     
else if(flag==2'b01&&tc==1)
    begin
      cnt<=cnt+2;
    if(cycle!=0)
        begin
       row_reg<=row_reg<<1;
        row<=row_reg<<1;
      if(row_reg[239]==1) 
         begin
	       row<=240'b0;
	       row_reg<=240'b0;
	       dr<=0;
	       f_sync<=0;
	       end
      else if(cnt==period-78)
          begin
          sample<=1;
           end
     else if(cnt==period-42)
           begin
          sample<=0;
          end
       end
    end
else if(flag==2'b01&&tc==0			
