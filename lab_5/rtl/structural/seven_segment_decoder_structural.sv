`timescale 1ps/1ps

module seven_segment_decoder_structural (
    input logic [2:0]sel,
    input logic[3:0]num,
    output logic seg_A,seg_B,seg_C,seg_D,seg_E,seg_F,seg_G,AN0,AN1,AN2,AN3,AN4,AN5,AN6,AN7
);
    logic x,y,z,A,B,C,D;
    //defining local signals
    assign x=sel[2];
    assign y=sel[1];
    assign z=sel[0];
    
    assign not_x=~x;
    assign not_y=~y;
    assign not_z=~z;

    assign A=num[3];
    assign B=num[2];
    assign C=num[1];
    assign D=num[0];

    assign not_A=~A;
    assign not_B=~B;
    assign not_C=~C;   
    assign not_D=~D;
    
    //defining output signals
    //anode code
    assign AN0 = ~(not_x & not_y & not_z);
    assign AN1 = ~(not_x & not_y & z);
    assign AN2 = ~(not_x & y & not_z);
    assign AN3 = ~(not_x & y & z);
    assign AN4 = ~(x & not_y & not_z);
    assign AN5 = ~(x & not_y & z);
    assign AN6 = ~(x & y & not_z);
    assign AN7 = ~(x & y & z);
        

    //seven segment code
    assign seg_A = (not_A & not_B & not_C & D) |
                   (not_A & B & not_C & not_D) |
                   (A & not_B & C & D) |
                   (A & B & not_C & D);

    assign seg_B = (B & C & not_D) |
                   (A & B & not_D) |
                   (A & C & D) |
                   (not_A & B & not_C & D);

    assign seg_C = (A & B & not_D) |
                   (A & B & C) |
                   (not_A & not_B & C & not_D);

    assign seg_D = (B & C & D) |
                   (not_A & not_B & not_C & D) |
                   (not_A & B & not_C & not_D) |
                   (A & not_B & C & not_D);

    assign seg_E = (not_A & D) |
                   (not_B & not_C & D) |
                   (not_A & B & not_C);

    assign seg_F = (not_A & not_B & D) |
                   (not_A & not_B & C) |
                   (not_A & C & D) |
                   (A & B & not_C & D);

    assign seg_G = (not_A & not_B & not_C) |
                   (A & B & not_C & not_D) |
                   (not_A & B & C & D);
    
endmodule