// D flip-flop Code
//-----------------------------------------------------
// test with online simulator at http://iverilog.com/
// Design Name : register_overflow
// Code showing how a 4 bit register overflows
// Function : This program will print time and register values
//-----------------------------------------------------


module d_ff ( d, clk, q, q_bar);
input d ,clk;
output q, q_bar;
wire d ,clk;
reg q, q_bar;
  	 
always @ (posedge clk)
begin
  q <= d;
  q_bar <= !d;
end

endmodule
