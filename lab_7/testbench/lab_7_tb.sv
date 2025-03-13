`timescale 1ps/1ps

module top_module_tb_lab_7;
    // Testbench signals
    logic clk;
    logic rst;
    logic write;
    logic [2:0] sel;
    logic [3:0] num;
    logic seg_A, seg_B, seg_C, seg_D, seg_E, seg_F, seg_G;
    logic AN0, AN1, AN2, AN3, AN4, AN5, AN6, AN7;

    // Instantiate the DUT (Device Under Test)
    top_module DUT (
        .top_clk(clk),
        .top_rst(rst),
        .top_write(write),
        .sel(sel),
        .num(num),
        .seg_A(seg_A), .seg_B(seg_B), .seg_C(seg_C), .seg_D(seg_D),
        .seg_E(seg_E), .seg_F(seg_F), .seg_G(seg_G),
        .AN0(AN0), .AN1(AN1), .AN2(AN2), .AN3(AN3),
        .AN4(AN4), .AN5(AN5), .AN6(AN6), .AN7(AN7)
    );

    // Clock generation
    always #5 clk = ~clk;  // 100 MHz Clock (10 ns period)

    // Test procedure
    initial begin
        // Initialize signals
        clk = 0;
        rst = 1;
        write = 0;
        sel = 3'b000;
        num = 4'b0000;
        
        // Apply reset
        #10 rst = 0;

        // Write values to registers
        write = 1;
        num = 4'b0001; sel = 3'b000; #10;
        num = 4'b0010; sel = 3'b001; #10;
        num = 4'b0011; sel = 3'b010; #10;
        num = 4'b0100; sel = 3'b011; #10;
        num = 4'b0101; sel = 3'b100; #10;
        num = 4'b0110; sel = 3'b101; #10;
        num = 4'b0111; sel = 3'b110; #10;
        num = 4'b1000; sel = 3'b111; #10;
        write = 0;
      #12500000
        rst = 1;#10;rst=0;#10;
      #12500000

        // Finish simulation
        $stop;
    end
endmodule
