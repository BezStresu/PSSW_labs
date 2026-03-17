module alu(
  input  [7:0] A,
  input  [7:0] B,
  input  [3:0] OP,
  output reg [7:0] Y,
  output reg C,   // carry/borrow/bit wybity
  output reg Z,   // zero
  output reg P,   // parity (even)
  output reg V    // overflow (tylko dla ADD/SUB)
);
  reg [8:0] tmp;  // pomocnicze 9 bitów (na przeniesienie)

  always @* begin
    Y = 8'h00; C = 1'b0; V = 1'b0; 

    case (OP)
      4'h0: begin // ADD
        tmp = {1'b0,A} + {1'b0,B};
        Y = tmp[7:0]; C = tmp[8];
        V = (~(A[7]^B[7])) & (A[7]^Y[7]);
      end
      4'h1: begin // SUB = A-B
        tmp = {1'b0,A} + {1'b0,(~B+8'd1)};
        Y = tmp[7:0]; C = tmp[8];      // 1 = brak pożyczki
        V = (A[7]^B[7]) & (A[7]^Y[7]);
      end
      4'h2: Y = A & B;                 // AND
      4'h3: Y = A | B;                 // OR
      4'h4: Y = A ^ B;                 // XOR
      4'h5: Y = ~A;                    // NOT A
      4'h6: begin tmp={1'b0,A}+9'd1; Y=tmp[7:0]; C=tmp[8]; V=(~A[7])&Y[7]; end // INC
      4'h7: begin tmp={1'b0,A}+{9{1'b1}}; Y=tmp[7:0]; C=tmp[8]; V=A[7]&(~Y[7]); end // DEC
      4'h8: begin Y = A << 1; C = A[7]; end // SHL
      4'h9: begin Y = A >> 1; C = A[0]; end // SHR (log.)
      4'hA: begin Y = {A[6:0],A[7]}; C = A[7]; end // ROL
      4'hB: begin Y = {A[0],A[7:1]}; C = A[0]; end // ROR
      4'hC: Y = (A==B) ? 8'd1 : 8'd0; // CMPEQ
      4'hD: Y = (A<B)  ? 8'd1 : 8'd0; // CMPLT (bez znaku)
      4'hE: Y = (A<B) ? A : B;        // MIN
      4'hF: Y = (A<B) ? B : A;        // MAX
    endcase

    Z = (Y==8'h00);
    P = ~^Y; // even parity
  end
endmodule
