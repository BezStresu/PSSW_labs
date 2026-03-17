`timescale 1ns/1ps
module alu_tb;
  reg  [7:0] A, B;
  reg  [3:0] OP;
  wire [7:0] Y;
  wire C, Z, P, V;

  alu DUT(.A(A), .B(B), .OP(OP), .Y(Y), .C(C), .Z(Z), .P(P), .V(V));

  task show; begin
    #1 $display("t=%0t OP=%h  A=%h B=%h  | Y=%h  C=%b Z=%b P=%b V=%b",
                $time, OP, A, B, Y, C, Z, P, V);
  end endtask

  // awaryjne odcięcie po 100 µs, gdyby coś poszło nie tak
  initial begin
    #100_000 $display("WATCHDOG STOP"); $finish;
  end

  initial begin
  $dumpfile("dump.vcd");
  $dumpvars(2, alu_tb);
  $dumpvars(0, alu_tb.A, alu_tb.B, alu_tb.OP, alu_tb.Y, alu_tb.C, alu_tb.Z, alu_tb.P, alu_tb.V);


    A=8'd15; B=8'd7;

    OP=4'h0; show(); // ADD
    OP=4'h1; show(); // SUB
    OP=4'h2; show(); // AND
    OP=4'h3; show(); // OR
    OP=4'h4; show(); // XOR
    OP=4'h5; show(); // NOT A
    OP=4'h6; show(); // INC
    OP=4'h7; show(); // DEC
    OP=4'h8; show(); // SHL
    OP=4'h9; show(); // SHR
    OP=4'hA; show(); // ROL
    OP=4'hB; show(); // ROR
    OP=4'hC; show(); // CMPEQ
    OP=4'hD; show(); // CMPLT
    OP=4'hE; show(); // MIN
    OP=4'hF; show(); // MAX

    // dodatkowe kilka przypadków
    A=8'd200; B=8'd100; OP=4'h0; show(); // ADD (carry/overflow)
    OP=4'h1; show();                     // SUB
    A=8'd50;  B=8'd50;  OP=4'h1; show(); // SUB -> Z=1
    A=8'b1000_0001; B=0; OP=4'h8; show();// SHL
    OP=4'h9; show();                     // SHR

    $display("ALL DONE");
    #1 $finish; 
  end
endmodule
