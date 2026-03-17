`timescale 1ns/1ps

module automat_4bits_mealy_tb;

reg x, reset, clk;
wire y;

automat_4bits_mealy dut(x, reset, clk, y);

always #5 clk = ~clk;

integer i;

initial
begin
    $dumpfile("automat_4bits_mealy.vcd");
    $dumpvars(0, automat_4bits_mealy_tb);

    clk = 0;
    reset = 0;
    x = 0;
    #12 reset = 1;

    for(i=0;i<16;i=i+1)
    begin
        @(negedge clk) x = i[3];
        @(negedge clk) x = i[2];
        @(negedge clk) x = i[1];
        @(negedge clk) x = i[0];
        @(negedge clk);
    end

    #20 $finish;
end

endmodule