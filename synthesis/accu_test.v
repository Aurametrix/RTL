module stimulus;

   reg clk, reset;
   reg [7:0] in;
   
   wire [7:0] out;
   
   accu accu1(in, out, clk, reset);
   
   initial 
     begin	
	clk = 1'b0;
	forever begin #5 clk = ~clk;
		$display("At Time: %d  Accumulator Output=%d",$time,out); end
     end

   initial
     begin
	$shm_open("shm.db",1); // Opens a waveform database
	$shm_probe("AS");    // Saves all signals to database
	#50 $finish;		
	#100 $shm_close();   // Closes the waveform database
     end


   // Stimulate the Input Signals
   initial
     begin
	#0  reset<=1;
	    in<=1;
	#5  reset<=0;
     end

endmodule // stimulus


