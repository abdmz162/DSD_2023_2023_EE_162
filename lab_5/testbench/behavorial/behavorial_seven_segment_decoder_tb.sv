`timescale 1ps/1ps

module behavorial_seven_segment_decoder_tb;
logic num3,num2,num1,num0;
logic seg_A,seg_B,seg_C,seg_D,seg_E,seg_F,seg_G;

localparam period = 10;

// Instantiate the behavioral model
seven_segment_decoder_behavorial ssd(
    .num({num3,num2,num1,num0}),
    .seg_A(seg_A),
    .seg_B(seg_B),
    .seg_C(seg_C),
    .seg_D(seg_D),
    .seg_E(seg_E),
    .seg_F(seg_F),
    .seg_G(seg_G)
);

initial
begin
    num3=0; num2=0; num1=0; num0=0; #period;
    num3=0; num2=0; num1=0; num0=1; #period;
    num3=0; num2=0; num1=1; num0=0; #period;
    num3=0; num2=0; num1=1; num0=1; #period;
    num3=0; num2=1; num1=0; num0=0; #period;
    num3=0; num2=1; num1=0; num0=1; #period;
    num3=0; num2=1; num1=1; num0=0; #period;
    num3=0; num2=1; num1=1; num0=1; #period;
    num3=1; num2=0; num1=0; num0=0; #period;
    num3=1; num2=0; num1=0; num0=1; #period;
    num3=1; num2=0; num1=1; num0=0; #period;
    num3=1; num2=0; num1=1; num0=1; #period;
    num3=1; num2=1; num1=0; num0=0; #period;
    num3=1; num2=1; num1=0; num0=1; #period;
    num3=1; num2=1; num1=1; num0=0; #period;
    num3=1; num2=1; num1=1; num0=1; #period;
    $stop;
end

initial
begin
    $monitor("num3=%b,num2=%b,num1=%b,num0=%b,seg_A=%b,seg_B=%b,seg_C=%b,seg_D=%b,seg_E=%b,seg_F=%b,seg_G=%b",
    num3,num2,num1,num0,seg_A,seg_B,seg_C,seg_D,seg_E,seg_F,seg_G);
end
endmodule