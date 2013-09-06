RTL
===

operations, register communication and timing of processes

One line comments start with // and end at the end of the line
Multi-line comments start with /* and end with */  -- C-style

Variable names have to start with an alphabetic character or underscore followed by 
alphanumeric or underscore characters. System tasks and functions start with a $ sign. 

Integer Literals and logic values can be sized and unsized, be single literals or have
underscores embedded in them for improved readability. For example

'0 : Set all bits to 0
'1: Set all bits to 1
'X or `x : Set all bits to x
2'b1Z //binary literal
24_000  //decimal literal

Data Types:
wire and_gate_output; // "and_gate_output" is a wire that only outputs
reg d_flip_flop_output; // "d_flip_flop_output" is a register; it stores and outputs a value
reg [7:0] address_bus; // "address_bus" is a little-endian 8-bit register

‘~’ operator negates the input . 
‘&’ operator ANDs two inputs , 
‘|’ operator ORs two inputs, while ‘^’ operator performs a logical XOR on two inputs. 
