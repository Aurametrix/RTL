`timescale 1ns/1ns // Set the units of time to be nanoseconds.
module counter; 
  reg clock; // Declare a reg data type for the clock.
  integer count; // Declare an integer data type for the count.
initial // Initialize things; this executes once at t=0.
  begin 
    clock = 0; count = 0; // Initialize signals.
    #340 $finish; // Finish after 340 time ticks.
  end 
/* An always statement to generate the clock; only one statement follows the always so we don't need a begin and an end. */
always  #10 clock = ~ clock; // Delay (10ns) is set to half the clock cycle.
/* An always statement to do the counting; this executes at the same time (concurrently) as the preceding always statement. */
always   begin    // Wait here until the clock goes from 1 to 0.
    @ (negedge clock);
    // Now handle the counting.
    if (count == 7)
      count = 0;
    else      count = count + 1;
    $display("time = ",$time," count = ", count);
  end 
endmodule
