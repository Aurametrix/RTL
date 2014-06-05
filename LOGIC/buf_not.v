/*

buf, not Gates implement buffers and inverters: one input, 1+ outputs

GATE (drive_strength) # (delays)
instance_name1(output_1, output_2,
..., output_n, input),
instance_name2(out1, out2, ..., outN, in);

Here, GATE stands for either buf or not

*/


not #(5) not_1 (a, c); // a = NOT c after 5 time units
buf c1 (o, p, q, r, in); // 5-output and 2-output buffers
c2 (p, f g);
