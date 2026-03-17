`timescale 1ns/1ps

module pssw307_counter (
    input  wire       clk,
    input  wire       rst_n,   
    input  wire       we,      
    output reg  [4:0] q        
);
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            q <= 5'd0;
        end else if (we == 1'b0) begin
            if (q == 5'd30) q <= 5'd0;
            else            q <= q + 5'd1;
        end else begin
            if (q >= 5'd2)       q <= q - 5'd2;
            else if (q == 5'd1)  q <= 5'd29; 
            else                 q <= 5'd30; 
    end
endmodule
