//-----------------------------------------------------
// test with online simulator at http://iverilog.com/
// Structural model of AND gate from two NANDS 
// Function : This program will print X, Y and X&Y
//-----------------------------------------------------

module and_from_nand();

reg X, Y;
wire F, W;
// Two instantiations of the module NAND
nand U1(W,X, Y);
nand U2(F, W, W);

// Testbench Code
initial begin
  $monitor ("X = %b Y = %b F = %b", X, Y, F);
  X = 0;
  Y = 0;
  #1 X = 1;
  #1 Y = 1;
  #1 X = 0; 
  #1 $finish;
end

endmodule

