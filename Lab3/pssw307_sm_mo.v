`timescale 1ns/1ps

module automat_4bits_mealy(
    input x,
    input reset,
    input clk,
    output reg y
);

reg [1:0] pos;
reg [2:0] ones;

always @(posedge clk)
begin
    if(!reset)
    begin
        pos  <= 0;
        ones <= 0;
        y    <= 0;
    end
    else
    begin
        y <= 0;
        if(pos == 2'd3)
        begin
            if(ones + x == 2) y <= 1;
            pos  <= 0;
            ones <= 0;
        end
        else
        begin
            pos  <= pos + 1;
            ones <= ones + x;
        end
    end
end

endmodule