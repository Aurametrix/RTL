module flop (clk, d, q);
input  clk, d;
output q;
reg    q;
        
always @(posedge clk)
begin
   q <= d;
end
endmodule
