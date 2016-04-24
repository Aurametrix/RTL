------------------------VHDL Code for Main Program---------------------
-
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
------------------------------------------------------------------------------------
-
ENTITY sort IS
PORT
(in1, in2, in3, in4: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
out1,out2,out3,out4: OUT STD_LOGIC_VECTOR(7 DOWNTO
0));
END sort;
------------------------------------------------------------------------------------
-
ARCHITECTURE merge OF sort IS
COMPONENT merge1 is
PORT
(in1_1,in1_2: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
out1_1, out1_2: OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
END COMPONENT;
COMPONENT merge2 is
PORT
(in2_1,in2_2,in2_3,in2_4: IN STD_LOGIC_VECTOR(7 DOWNTO
0);
out2_1,out2_2, out2_3, out2_4: OUT STD_LOGIC_VECTOR(7
DOWNTO 0);
END COMPONENT;
SIGNAL a,b,c,d: STD_LOGIC_VECTOR (7 DOWNTO 0);
BEGIN
lev1_1: merge1 PORT MAP (in1, in2, a, b);
lev1_2: merge1 PORT MAP (in3, in4, c, d);
lev2_1: merge2 PORT MAP (a, b, c, d, out1, out2, out3, out4);

END merge;
----------------------------------END-------------------------------------------
--
The port mapped comparator VHDL program for level-1 and level- 2
is as follows.
---------------------------VHDL Code for LEVEL-1------------------------
-
ENTITY merge1 is
PORT
(in1_1,in2_1: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
out1_1,out2_1: OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
END merge1;
ARCHITECTURE level1 OF merge1 is
BEGIN
PROCESS(in1_1, in1_2) IS
BEGIN
IF (in1_1 <= in1_2) THEN
 out1_1<= in1_1;
 out1_2<= in1_2;
ELSE
 out1_1<= in1_2;
 out1_2<= in1_1;
END IF;
END PROCESS;
END level1;
----------------------------------END------------------------------------
--------------------------VHDL Code for LEVEL- 2-------------------------
ENTITY merge2 IS
PORT (in2_1,in2_2,in2_3,in2_4: IN STD_LOGIC_VECTOR (7
DOWNTO 0);
out2_1, out2_2, out2_3, out2_4: OUT STD_LOGIC_VECTOR (7
DOWNTO 0);
END merge2;
ARCHITECTURE level2 OF merge2 IS
SIGNAL flag: std_logic;
BEGIN
PROCESS (in2_1, in2_2, in2_3, in2_4) IS
BEGIN
IF (in2_1 <= in2_3) THEN
 out2_1 <= in2_1;
ELSIF (in2_1 > in2_3) THEN
 out2_1 <= in2_3;
 flag <= ' 1 ';
end if;
IF (in2_2<=in2_3 and flag<='0') THEN
 out2_2<= in2_2;
 out2_3<= in2_3;
 out2_4<= in2_4;
ELSIF (in2_2<=in2_4 and flag<='0') THEN
 out2_2<= in2_3;
 out2_3<= in2_2;
 out2_4<= in2_4;
ELSIF (flag<='0') THEN
 out2_2<= in2_3;
 out2_3<= in2_4;
 out2_4<= in2_2;
END IF;

IF (in2_4<=in2_1 and flag<='1') THEN
 out2_2<= in2_4;
 out2_3<= in2_1;
 out2_4<= in2_2;
ELSIF (in2_4>=in2_2 and flag<='1') THEN
 out2_2<= in2_1;
 out2_3<= in2_2;
 out2_4<= in2_4;
ELSIF (flag<='1') THEN
 out2_2<= in2_1;
 out2_3<= in2_4;
 out2_4<= in2_2;
END IF;
END PROCESS;
END level2;
---------------------------------END---------------
