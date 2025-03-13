`timescale 1ps/1ps


module anode_decoder(
    input logic x,y,z,write,
    output logic AN0,AN1,AN2,AN3,AN4,AN5,AN6,AN7
);
    logic not_x,not_y,not_z;
    assign not_x=~x;
    assign not_y=~y;
    assign not_z=~z;

    assign AN0 = ~(not_x & not_y & not_z);
    assign AN1 = ~(not_x & not_y & z);
    assign AN2 = ~(not_x & y & not_z);
    assign AN3 = ~(not_x & y & z);
    assign AN4 = ~(x & not_y & not_z);
    assign AN5 = ~(x & not_y & z);
    assign AN6 = ~(x & y & not_z);
    assign AN7 = ~(x & y & z);

endmodule

module seven_segment_decoder (
    input logic A,B,C,D,
    output logic seg_A,seg_B,seg_C,seg_D,seg_E,seg_F,seg_G
);
    logic not_A,not_B,not_C,not_D;
    assign not_A=~A;
    assign not_B=~B;
    assign not_C=~C;
    assign not_D=~D;

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

module register_4bit_async (
    input  logic        clk,   // Clock input
    input  logic        rst,   // Asynchronous reset (active high)
    input  logic        en,    // Enable signal
    input  logic [3:0]  d = 4'b0000,     // 4-bit data input
    output logic [3:0]  q = 4'b0000      // 4-bit output
);
    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            q <= 4'b0000;  // Reset output to 0 when rst is high
        else if (en)
            q <= d;        // Update register when enable is high
    end
endmodule

module mux_8x1 (
    input logic [3:0] in0,[3:0] in1,[3:0] in2,[3:0] in3,[3:0] in4,[3:0] in5,[3:0] in6,[3:0] in7, // 8 inputs (each 4-bit wide)
    input logic [2:0] sel,  // 3-bit select signal
    output logic [3:0] out = 4'b0000  // 4-bit output
);
    always_comb begin
        case (sel)
            3'b000: out = in0;
            3'b001: out = in1;
            3'b010: out = in2;
            3'b011: out = in3;
            3'b100: out = in4;
            3'b101: out = in5;
            3'b110: out = in6;
            3'b111: out = in7;
            default: out=4'b0000;
        endcase
    end
endmodule

module clk_divider_800Hz (
    input  logic clk,      // 100 MHz clock input
    input  logic rst,      // Asynchronous reset
    output logic clk_out   // 800 Hz output
);

    logic [15:0] counter = 16'd0;  // 16-bit counter
    logic toggle = 1'b0;           // Toggle signal

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            counter <= 16'd0;
            toggle  <= 1'b0;
        end else begin
            if (counter == 62500) begin  // Half-period count
                counter <= 15'd0;
                toggle  <= ~toggle; // Toggle output
            end else begin
                counter <= counter + 1;
            end
        end
    end

    assign clk_out = toggle;

endmodule

module display_rapid_selector (
    input  logic clk,      // Clock input
    input  logic rst,      // Reset input
    output logic [2:0] count // 3-bit counter output
);

always_ff @(posedge clk or posedge rst) begin
    if (rst)
        count <= 3'b000;  // Reset counter to 0
    else
        count <= count + 1; // Increment counter
end

endmodule



module top_module (
    input logic top_clk,
    input logic top_rst,
    input logic top_write,
    input logic [2:0]sel,
    input logic[3:0]num=4'b0000,
    output logic seg_A,seg_B,seg_C,seg_D,seg_E,seg_F,seg_G,AN0,AN1,AN2,AN3,AN4,AN5,AN6,AN7
);
    //defining local signals
    logic x,y,z;
    logic clk,rst,write;
    assign clk = top_clk;
    assign rst = top_rst;
    assign write = top_write;
    //defining 8 4-bit registers
    logic [3:0]reg0_out;
    logic [3:0]reg1_out;
    logic [3:0]reg2_out;
    logic [3:0]reg3_out;
    logic [3:0]reg4_out;
    logic [3:0]reg5_out;
    logic [3:0]reg6_out;
    logic [3:0]reg7_out;
    logic AN0do,AN1do,AN2do,AN3do,AN4do,AN5do,AN6do,AN7do;
    logic clk_800Hz;
    logic [7:0]en;
    logic [3:0]mux_out;
    logic [2:0]clk_sel;

    //defining 800Hz clock
    clk_divider_800Hz c_d(.clk(clk),.rst(rst),.clk_out(clk_800Hz));
    //defining 3-bit counter
    display_rapid_selector d_r_s(.clk(clk_800Hz),.rst(rst),.count(clk_sel));

    assign {x, y, z} = (write) ? sel : clk_sel;
    anode_decoder a_d(.x(x),.y(y),.z(z),
    .AN0(AN0do),.AN1(AN1do),.AN2(AN2do),.AN3(AN3do),.AN4(AN4do),.AN5(AN5do),.AN6(AN6do),.AN7(AN7do));
    
    assign en[7:0]=~{AN7do,AN6do,AN5do,AN4do,AN3do,AN2do,AN1do,AN0do};
    //defining 8 4-bit registers
    register_4bit_async reg0(.clk(clk),.rst(rst),.en(en[0]&write),.d(num),.q(reg0_out)); 
    register_4bit_async reg1(.clk(clk),.rst(rst),.en(en[1]&write),.d(num),.q(reg1_out));
    register_4bit_async reg2(.clk(clk),.rst(rst),.en(en[2]&write),.d(num),.q(reg2_out));
    register_4bit_async reg3(.clk(clk),.rst(rst),.en(en[3]&write),.d(num),.q(reg3_out));
    register_4bit_async reg4(.clk(clk),.rst(rst),.en(en[4]&write),.d(num),.q(reg4_out));
    register_4bit_async reg5(.clk(clk),.rst(rst),.en(en[5]&write),.d(num),.q(reg5_out));
    register_4bit_async reg6(.clk(clk),.rst(rst),.en(en[6]&write),.d(num),.q(reg6_out));
    register_4bit_async reg7(.clk(clk),.rst(rst),.en(en[7]&write),.d(num),.q(reg7_out));
    
    //defining 8x1 mux
    mux_8x1 MUX(.in0(reg0_out),.in1(reg1_out),.in2(reg2_out),.in3(reg3_out),.in4(reg4_out),.in5(reg5_out),.in6(reg6_out),.in7(reg7_out),.sel({x,y,z}),.out(mux_out));
    //defining 7-segment decoder
    seven_segment_decoder s_s_d(.A(mux_out[3]),.B(mux_out[2]),.C(mux_out[1]),.D(mux_out[0]),
    .seg_A(seg_A),.seg_B(seg_B),.seg_C(seg_C),.seg_D(seg_D),.seg_E(seg_E),.seg_F(seg_F),.seg_G(seg_G));

    assign AN0=AN0do;
    assign AN1=AN1do;
    assign AN2=AN2do;
    assign AN3=AN3do;
    assign AN4=AN4do;
    assign AN5=AN5do;
    assign AN6=AN6do;
    assign AN7=AN7do;

endmodule