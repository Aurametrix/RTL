// A simple 8-bit accumulator
// reset=0 -> set acc to 0
// reset=1 -> add "in" to acc
//
//
// Johannes Grad
// gradjoh@iit.edu
//

//
// The core 
//

module accu(in, acc, clk, reset);
input [7:0] in;
input clk, reset;
output [7:0] acc;
reg [7:0] acc;

always @(posedge clk)
begin
	if (reset) acc<=0; 
	else acc<=acc+in;
end

endmodule
