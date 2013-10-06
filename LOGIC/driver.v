//-----------------------------------------------------
// Structural model of Driver 
// Low-to-High Transition: Current Enters the Driver Through the
// Power Pin and Exits the Driver Via the Signal Pin
// High-to-Low Transition: In all Cases, Current Enters the Driver Through the
// Signal Pin and Exits the Driver Via the Ground Pin
//-----------------------------------------------------
// ieee.std_logic_1164.all library
----------------------------------------

entity Driver is
port(	x: in std_logic;
	F: out std_logic
);
end Driver;  


// architecture behv1 of Driver:
begin

    process(x)
    begin
        -- compare to truth table
        if (x='1') then
            F <= '1';
        else
            F <= '0';
        end if;
    end process;

end behv1;

// architecture behv2 of Driver:
begin 

    F <= x; 

end behv2; 
