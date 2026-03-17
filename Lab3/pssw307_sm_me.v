`timescale 1ns/1ps

module automat_4bits(
    input x,
    input reset,
    input clk,
    output reg y
);

reg [2:0] state;
reg [2:0] ones;

parameter S0=3'd0, S1=3'd1, S2=3'd2, S3=3'd3, S4=3'd4;

always @(posedge clk)
begin
    if(!reset)
    begin
        state <= S0;
        ones  <= 0;
        y     <= 0;
    end
    else
    begin
        y <= 0;
        case(state)
            S0: begin ones <= x;          state <= S1; end
            S1: begin ones <= ones + x;   state <= S2; end
            S2: begin ones <= ones + x;   state <= S3; end
            S3: begin ones <= ones + x;   state <= S4; end
            S4: begin
                    if(ones == 2) y <= 1;
                    state <= S0;
                    ones  <= 0;
                end
        endcase
    end
end

endmodule