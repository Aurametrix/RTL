/ * Syntax
GATE (drive_strength) # (delays)
instance_name1(output, input_1,
input_2,..., input_N),
instance_name2(outp,in1, in2,..., inN);
Delays is
#(rise, fall) or
# rise_and_fall or
#(rise_and_fall)

in this gate instantiation syntax GATE stands for one of the keywords; 
and, nand, or, nor, xor, xnor

*/

and c1 (o, a, b, c, d); // 4-input AND called c1 and
c2 (p, f g); // a 2-input AND called c2.
or #(4, 3) ig (o, a, b); /* or gate called ig (instance name);
rise time = 4, fall time = 3 */
xor #(5) xor1 (a, b, c); // a = b XOR c after 5 time units
xor (pull1,strong0) #5 (a,b,c); /* Identical gate with pull-up
strength pull1 and pull-down strength strong0. */
