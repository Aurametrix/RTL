-- Typdefinition BSData_Typ s.o.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.bstypes.all;

entity Bubblesort is
    Port ( di    : in  BSData_Typ;
           do    : out BSData_Typ;
           start : in  std_logic;
           done  : out std_logic;
           clk   : in  std_logic);
end Bubblesort;

architecture Behavioral of Bubblesort is
signal busy     : boolean := FALSE;
signal din      : BSData_Typ;
signal n,i      : integer range 0 to din'length;
begin

   process 
   variable temp : integer;
   begin
      wait until rising_edge(clk);
      if (busy=FALSE) then
         if (start='1') then
            din  <= di;
            busy <= TRUE;
            n    <= 0;
            i    <= 0;
         end if;
      else
         if (n < din'length) then
            if (i<din'length-1) then
               if din(i) > din(i+1) then
                  temp     := din(i);   -- Dreieckstausch
                  din(i)   <= din(i+1);
                  din(i+1) <= temp;
               end if;
               i <= i+1;
            else
               i <= 0;
               n <= n+1;
            end if;
         else
            busy <= FALSE;       
            do   <= din;
         end if;
      end if;
   end process;
   
   done <= '1' when start='0' and busy=FALSE else '0';

end Behavioral;
