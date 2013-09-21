/-----------------------------------------------------
// test with online simulator at http://iverilog.com/
// Function : This program will print time and register values
// inverting them every second
//-----------------------------------------------------

module main;  //module definition - no inputs or outputs

reg a=0;           //define a 1 bit register.
                   //initialize to zero, otherwise would be "x"--unknown.

always             //always block has code that runs continuously.
                   //if only one statement in block, does not need begin/end.
  #1 a=~a;         //wait one time unit then invert a.
  
initial            //can have multiple initial blocks.
  $monitor ("Time = %d a = %d",$time,a);

initial
  #20 $finish;     //finish after 20 time units
	
endmodule
