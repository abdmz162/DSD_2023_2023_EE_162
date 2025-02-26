`timescale 1ps/1ps

module structural_selector_tb;
logic sel2,sel1,sel0;
logic anode0,anode1,anode2,anode3,anode4,anode5,anode6,anode7;

localparam period = 10;

// Instantiate the behavioral model
seven_segment_decoder_structural ssd(
    .sel({sel2,sel1,sel0}),
    .AN0(anode0),
    .AN1(anode1),
    .AN2(anode2),
    .AN3(anode3),
    .AN4(anode4),
    .AN5(anode5),
    .AN6(anode6),
    .AN7(anode7)
);

initial
begin
    sel2=0; sel1=0; sel0=0; #period;
    sel2=0; sel1=0; sel0=1; #period;
    sel2=0; sel1=1; sel0=0; #period;
    sel2=0; sel1=1; sel0=1; #period;
    sel2=1; sel1=0; sel0=0; #period;
    sel2=1; sel1=0; sel0=1; #period;
    sel2=1; sel1=1; sel0=0; #period;
    sel2=1; sel1=1; sel0=1; #period;
    $stop;
end

initial
begin
    $monitor("sel2=%b,sel1=%b,sel0=%b,anode0=%b,anode1=%b,anode2=%b,anode3=%b,anode4=%b,anode5=%b,anode6=%b,anode7=%b",
    sel2,sel1,sel0,anode0,anode1,anode2,anode3,anode4,anode5,anode6,anode7);
end
endmodule