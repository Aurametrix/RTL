//-----------------------------------------------------
// test with online simulator at http://iverilog.com/
// Design Name : hello_world
// File Name : hello_world.v
// Function : This program will print 'hello world'
//-----------------------------------------------------
module main ;

initial 
  begin
    $display ("Hello World");
    $finish;
end

endmodule // end