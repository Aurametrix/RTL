ff_proc: process (clk)
begin
   if (clk = '1' and clk'event) then
      q <= d;
  end if;
end process ff_proc;
