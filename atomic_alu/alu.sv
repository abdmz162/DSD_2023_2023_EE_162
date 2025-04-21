`timescale 1ns / 1ps

//top module
module alu(
    input  logic [31:0] a, 
    input  logic [31:0] b, 
    input  logic [3:0]  op_code, 
    output logic        O, C, Z, N, 
    output logic [31:0] y);
always_comb
begin
    case (op_code)
        4'b0000:y=a+b; //add
        4'b0001:y=a-b; //sub
        4'b0010:y=a+1; //increment
        4'b0011:y=0; //cas
        4'b0100:y=a&b; //bit_wise and 
        4'b0101:y=~a; //bit_wise not of a
        4'b0110:y=a^b; //bit_wise xor
        4'b0111:y=a|b; //bit_wise or 
        default: y=0; //default case
    endcase
end
always_comb begin
    O = 0; //overflow flag
    C = 0; //carry flag
    Z = (y == 0); //zero flag
    N = y[31]; //negative flag
end
endmodule