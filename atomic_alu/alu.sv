`timescale 1ns / 1ps

//top module
module alu(
    input  logic [31:0] a, 
    input  logic [31:0] b, 
    input  logic [3:0]  op_code, 
    output logic O, C, Z, N, 
    output logic [31:0] y);
always_comb
begin
    case (op_code)
        4'b0000:begin
        y = a + b;
        C = (a[31] & b[31]) | ((a[31] | b[31]) & ~y[31]); //carry flag
        O = ~(a[31] ^ b[31]) & (y[31] ^ b[31]); //overflow flag
        end

        4'b0001:begin 
        y=a-b;
        C = (a[31] & b[31]) | ((a[31] | b[31]) & ~y[31]); //carry flag
        O = ~(a[31] ^ b[31]) & (y[31] ^ b[31]); //overflow flag
        end

        4'b0010:begin
        y=a+1;
        if Z:begin
            C = 1; //carry flag
        end
        O = ~(a[31] ^ b[31]) & (y[31] ^ b[31]); //overflow flag
        end

        4'b0011:y=0; //cas
        4'b0100:y=a&b; //bit_wise and 
        4'b0101:y=~a; //bit_wise not of a
        4'b0110:y=a^b; //bit_wise xor
        4'b0111:y=a|b; //bit_wise or 
        default: y=0; //default case
    endcase
end
always_comb begin
    Z = (y == 0); //zero flag
    N = y[31]; //negative flag
end
endmodule
