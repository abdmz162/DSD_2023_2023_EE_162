`timescale 1ns / 1ps

module lab2_task(
        input logic a,b,c,output logic x,y
    );
    logic not_c,a_or_b,a_nand_b,xor_1;
    assign not_c=~c;
    assign a_or_b=a|b;
    assign a_nand_b=~(a&b);
    assign xor_1=a_nand_b^a_or_b;
    assign x=not_c^a_or_b;
    assign y=a_or_b&xor_1;
endmodule
