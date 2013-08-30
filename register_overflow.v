//-----------------------------------------------------
// test with online simulator at http://iverilog.com/
// Design Name : register_overflow
// Code showing how a 4 bit register overflows
// Function : This program will print time and register values
//-----------------------------------------------------


module main;

reg [3:0] a=0;     //define a 4 bit register

always             //loop with only one statement doesn't need begin/end.
  #1 a=a+1;        //wait one time unit then increment register.
  
initial            //monitor the value. "a" will overflow after 15 because
                   //it is only 4 bits wide.
  $monitor ("Time = %d a = %d",$time,a);

initial
  #20 $finish;     //finish after 20 time units
	
endmodule