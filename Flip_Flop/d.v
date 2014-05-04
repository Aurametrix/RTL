 module d_ff(
            input d,
            input clk,
            input reset,
            input we,
            output q
    );

// q <= q may increase area and power consumption
    always @(posedge clk) begin
            if (~reset) begin
                    q <= 1'b0;
            end
            else if (we) begin
                    q <= d;
            end
            else begin
                    q <= q;
            end
    end

// whenn 3 muxes plus extra routing needed

//always @(posedge CLK or negedge RESET)
//  if(~RESET)
//    COUNT <= 0;
//  else if(INC)
//    COUNT <= COUNT + 1;
//  else
//    COUNT <= COUNT;


// using a single clock gate for akk DFFs
//always @(posedge CLK or negedge RESET)
//  if(~RESET)
//    COUNT <= 0;
//  else if(INC)
//    COUNT <= COUNT + 1;


    endmodule
