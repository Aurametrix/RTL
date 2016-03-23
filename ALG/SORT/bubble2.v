library IEEE;
use IEEE.STD_LOGIC_1164.all;

package BSTypes is
  type BSData_Typ is array (0 to 9) of integer range 0 to 127;
end BSTypes;

package body BSTypes is
end BSTypes;




library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.bstypes.all;

entity Bubblesort is
    Port ( di  : in  BSData_Typ;
           do  : out BSData_Typ );
end Bubblesort;

architecture Behavioral of Bubblesort is
begin

   process (di) 
   variable din  : BSData_Typ;
   variable temp : integer;
   variable n    : integer;
   variable oncemore : boolean;
   begin
      din      := di;
      n        := din'length;
      oncemore := TRUE;
      while oncemore = TRUE and n > 1 loop
         oncemore := FALSE;
         for i in 0 to din'length-2 loop
            if din(i) > din(i+1) then 
               temp     := din(i);   -- Dreieckstausch
               din(i)   := din(i+1);
               din(i+1) := temp;
               oncemore := TRUE;
            end if;
         end loop;
         n := n-1;
      end loop;
      do <= din;
   end process;
   
end Behavioral;
