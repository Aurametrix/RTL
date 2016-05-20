module ff (output reg q, input d, input clk);
   always @(posedge clk)
      q <= d;
      
endmodule
