//-----------------------------------------------------
// test with online simulator at http://iverilog.com/
// Design Name : hello_world
// File Name : helloworld.v
// Function : This program will print 'hello world'
// module can be named hello ( ) 
//-----------------------------------------------------
module main ;

initial 
  begin
    $display ("Hello World");
    $finish;
end

endmodule // end
