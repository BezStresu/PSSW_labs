`timescale 1ns/1ps

module tb_pssw307_counter;
  reg        clk;
  reg        rst_n;   
  reg        we;      
  wire [4:0] q;

  pssw307_counter dut (.clk(clk), .rst_n(rst_n), .we(we), .q(q));

  initial clk = 1'b0;
  always #5 clk = ~clk;

  initial begin
 
    $dumpfile("pssw307.vcd");
    $dumpvars(0, tb_pssw307_counter);
    $display(" we  q(dec) q(bin)");
    $monitor("  %0d    %2d     %05b", we, q, q);


    rst_n = 0; we = 0;
    #17; rst_n = 1;                 

    repeat (35) @(posedge clk);

    @(negedge clk) we = 1;
    repeat (10) @(posedge clk);

    rst_n = 0; #6; rst_n = 1;
    we = 0;                        
    repeat (12) @(posedge clk);

    @(negedge clk) we = 1;
    repeat (8) @(posedge clk);

    @(negedge clk) we = 0;
    repeat (10) @(posedge clk);

    rst_n = 0; #4; rst_n = 1;
    we = 0;
    repeat (10) @(posedge clk);

    $finish;
  end
endmodule
