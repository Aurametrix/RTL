// flip-flop with a negative-edge clock
// and asynchronous clear

module flop (clk, d, clr, q);
input  clk, d, clr;
output q;
reg    q;
always @(negedge clk or posedge clr) 
begin
   if (clr)
      q <= 1’b0;
   else
      q <= d;
end
endmodule
