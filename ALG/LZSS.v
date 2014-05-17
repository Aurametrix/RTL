`timescale 1ns / 10 ps
`define EOF 32'HFFFF_FFFF
`define MEM_SIZE 200_000
`define NULL 0

//00 41 42 43 00 09 03 44 45 46 41 42 43

module UnCompBF ();

  reg [80*8:1] infilename;
  reg [80*8:1] outfilename;

  parameter EOF = -1;
  integer infile, outfile, mem_indx, file_char_rd;
  integer i, j, k, l;
  integer inc_i;
  reg[7:0] mem [4096:0]; // what size should i use??
  reg[7:0] out_mem [4096:0]; // what size should i use??
  reg[7:0]  get_char0, get_char1;
  reg[7:0] special_char;
  reg[15:0] length, offset;

  initial   
    begin :  uncompress_block
        //Load input binary file into memory
        infilename = "comp_out.bin";
        infile = $fopen(infilename,"r");
        //Check if input file is opened
    if (infile == `NULL)
        begin
        $display("Infile  -- file not opening");
        disable uncompress_block;
        end 

    i = $fread(mem[0], infile);
    $display("Loaded %0d entries \n", i); 
    $fclose(infile);

    //Open output file for writing
    outfilename = "out0.txt";
    outfile = $fopen(outfilename,"w");
    $display("input file loaded into mem and output file opened");

    //Initialize 
    mem_indx = 0;
    file_char_rd = 0; 
    special_char = 8'hxx;
    j = 0;
    k = 0;
    $display("initialize variables");

    //for (j=0;j<i;j=j+1)
  while (j<i)
    begin
            $display("In while loop -- j=%d -- i=%d", j, i);
            inc_i = 0;
            if (j == 0)
                begin
                    special_char = mem[j];
                    inc_i = inc_i + 1;
                    $display("first byte is marker j %d inc_i %d marker %h", j, inc_i, special_char);  
                    // else if not first char and current char is equal to value of special_char
                end 
            else if ((j != 0) && (mem[j] == special_char))
                begin
                    $display("byte is equal to marker");
                    //get next char
                    get_char0 = mem[j+1];
                    inc_i = inc_i + 2;
                    // if next char is equal to 00
                    if (get_char0[7:0] == 8'h00) // Marker is 0 hence unmatched literal
                        begin
                            // special character is actually unmatched char 
                            // write previous into output fie
                            $fdisplay(outfile, "%2h ", mem[j]);
                            // write previous into memory
                            out_mem[k] = mem[j];
                            k = k + 1;
                            $display("length is 00 meaning marker part of output");
                            $display("mem[j] %h -- k %d", mem[j], k);
                        end
                    else // get length and offset of match string // Otherwise move forward to get the lenght                                and offset
                        begin
                            // get length of match string
                            if(get_char0[7] == 1)
                                begin
                                    //get next char
                                    get_char1 = mem[j+2];
                                    inc_i = inc_i + 1;
                                    length = {1'b0,get_char0[6:0],get_char1[7:0]};  
                                end 
                            else
                                length = {8'h00,get_char0[7:0]};                                        

                                $display("length is %h -- inc_i %d", length, inc_i);    
                                // get offset of match string
                                get_char0 = mem[j+inc_i];
                                inc_i = inc_i + 1;
                            if(get_char0[7] == 1)
                                begin
                                    //get next char
                                    get_char1 = mem[j+inc_i];
                                    inc_i = inc_i + 1;
                                    offset = {1'b0,get_char0[6:0],get_char1[7:0]};      
                                end 
                            else
                                offset = {8'h00,get_char0[7:0]};                

                                $display("offset is %h -- inc_i %d", offset, inc_i);    
                        end
                            // write out the string match in file and memory    
                            for( l = 0; l < length; l = l + 1 )
                                begin
                                    out_mem[k] = out_mem[ k - offset ];
                                    // write previous into output fie
                                    $fdisplay(outfile, "%2h ",  out_mem[k]);
                                    $display("using the length/offset pair");
                                    $display("out_mem adds %h -- k %d", out_mem[k], k);
                                    k = k +  1;
                                end
                    // else write unmatched char into file and memory   
            end 

                else 
                    begin
                        // write previous into output fie
                        $fdisplay(outfile, "%2h ",  mem[j]);
                        // write previous into memory
                        out_mem[k] = mem[j];
                        inc_i = inc_i + 1;
                        $display("output unmatched char");
                        $display("out_mem adds %h -- k %d", out_mem[k], k);
                        k = k + 1;
                    end
          j = j + inc_i;
          $display("j is %d", j);
    end
    $fclose(outfile);
  end
endmodule
