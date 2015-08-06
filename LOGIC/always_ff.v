always_ff @ (posedge clk or negedge rst) 
begin
  if (!rst)
    a <= '0;
end
