`timescale 1ps/1ps

module seven_segment_decoder_behavorial (
    input logic [2:0]sel,
    input logic[3:0]num,
    output logic seg_A,seg_B,seg_C,seg_D,seg_E,seg_F,seg_G,AN0,AN1,AN2,AN3,AN4,AN5,AN6,AN7
);
    logic x,y,z,A,B,C,D;
    logic [7:0]AN;
    logic [6:0]seg;
    //defining output signals
    assign {AN0,AN1,AN2,AN3,AN4,AN5,AN6,AN7} = AN;
    assign {seg_A, seg_B, seg_C, seg_D, seg_E, seg_F, seg_G} = seg;
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
    always_comb begin 
        case ({x,y,z})
            3'b000: AN = 8'b01111111;
            3'b001: AN = 8'b10111111;
            3'b010: AN = 8'b11011111;
            3'b011: AN = 8'b11101111;
            3'b100: AN = 8'b11110111;
            3'b101: AN = 8'b11111011;
            3'b110: AN = 8'b11111101;
            3'b111: AN = 8'b11111110;
        endcase
    end
    //seven segment code
    always_comb begin 
        case({A,B,C,D})
            4'b0000: seg = 7'b0000001;//0
            4'b0001: seg = 7'b1001111;//1
            4'b0010: seg = 7'b0010010;//2
            4'b0011: seg = 7'b0000110;//3
            4'b0100: seg = 7'b1001100;//4
            4'b0101: seg = 7'b0100100;//5
            4'b0110: seg = 7'b0100000;//6
            4'b0111: seg = 7'b0001111;//7
            4'b1000: seg = 7'b0000000;//8
            4'b1001: seg = 7'b0000100;//9
            4'b1010: seg = 7'b0001000;//A
            4'b1011: seg = 7'b1100000;//B
            4'b1100: seg = 7'b0110001;//C
            4'b1101: seg = 7'b1000010;//D
            4'b1110: seg = 7'b0110000;//E
            4'b1111: seg = 7'b0111000;//F
        endcase
    end
    
endmodule