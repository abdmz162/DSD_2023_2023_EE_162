`timescale 1ps/1ps

module color_chip (
    input logic [1:0]a,
    input logic[1:0]b,
    output logic R,G,B
);
    logic a1,b1,a0,b0,not_a1,not_b1,not_a0,not_b0;
    
    assign a1=a[1];
    assign b1=b[1];
    assign a0=a[0];
    assign b0=b[0];

    assign not_a1=~a1;
    assign not_b1=~b1;
    assign not_a0=~a0;
    assign not_b0=~b0;
    
    assign R=a1&a0 | not_b0&not_b1 | a1&not_b0 | a0&not_b1 | a1&not_b1;
    assign G=b1&b0 | not_a0&not_a1 | not_a1&b1 | not_a0&b1 | not_a1&b0;
    assign B=not_a0&b0 | a0&not_b0 | a1&not_b1 | not_a1&b1;
endmodule