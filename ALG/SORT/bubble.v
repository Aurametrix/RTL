module question3(clock,start,q_a,q_b,wren,state);

input clock;	 //declare clock
input start;	 //start button
output [7:0] q_a,q_b;

parameter [2:0] IDLE=3'b000, ADDRESSES=3'b001, READ=3'b010, COMPARE=3'b011, WRITE=3'b100;

reg [7:0] next_j=8'd0, j=8'd0, data_a=8'd0, data_b=8'd0, next_max=8'd18, max=8'd18, next_counter=8'd0,counter=8'd0;
output reg [2:0] state=IDLE;
output reg wren=1'b0;
reg [2:0] next_state;



always @(posedge clock or start)
begin
if (!start)
begin
next_state<=IDLE;
end
else
begin
j<=next_j;
counter<=next_counter;
max<=next_max;
state<=next_state;
end

end

ram_2port ram1(j,j+8'd1,clock,data_a,data_b,wren,wren,q_a,q_ b);	 //instantiate RAM

always @(state or j or max or counter or q_a or q_b or data_a or data_b)
begin
case (state)


IDLE:	 begin
j=8'd0;
max=8'd18;
counter=8'd0;
next_state=READ;
end



ADDRESSES:	if (j==max)
begin
next_max=max-8'd1;
j=8'd0;
counter=8'd0;
next_state=READ;
end
else
begin
next_j=j+8'd1;
next_state=READ;
end

READ:	begin
wren=1'b0;
next_state=COMPARE;	
end


COMPARE:	if (q_a > q_b)
begin
next_state=WRITE;
end
else
begin
if (counter==max)
begin
next_state=IDLE;
end
next_counter=counter+8'd1;
next_state=ADDRESSES;
end

WRITE:	begin
data_a=q_b;
data_b=q_a;
counter=8'd0;
wren=1'b1;
next_state=ADDRESSES;
end

endcase

end	

endmodule
