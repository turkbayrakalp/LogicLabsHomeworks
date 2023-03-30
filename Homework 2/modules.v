module sr_latch(
    input S,
    input R,
    inout Q,
    inout Q_NOT
    );
    wire Q_int, Q_NOT_int;
    nor_gate nor_1(S, Q_NOT_int, Q_NOT_int1);
    nor_gate nor_2(R, Q_int, Q_int1);
    assign #1 Q_int = Q_NOT_int1;
    assign #1 Q_NOT_int = Q_int1;
    assign Q_NOT = Q_NOT_int;
    assign Q = Q_int;
    
endmodule

module sre_latch(
    input S,
    input R,
    input E,
    output Q,
    output Q_NOT
    );
    nand_gate nand_S(S, E , SE);
    nand_gate nand_R(R, E , RE);
    nand_gate nand_1(SE, Q, Q_NOT);
    nand_gate nand_2(RE, Q_NOT, Q);
    
endmodule

module d_latch(
    input D,
    input E,
    inout Q,
    inout Q_NOT
    );
    
    sre_latch sr1(D,~D, E, Q, Q_NOT);
endmodule

module d_flip_flop(
    input D,
    input clk,
    inout Q,
    inout Q_NOT
    );
    d_latch d1(D, ~clk, Q_1, Q_NOT_1);
    d_latch d2(Q_1, clk, Q, Q_NOT);
endmodule

module jk_flip_flop(
  input  J,
  input  K,
  input  clk,
  output reg Q,
  output reg Q_NOT
  );
  always @(posedge clk) 
  begin
    
    if(J==1'b1 & K==1'b1) 
    begin
      Q <= ~Q;
      Q_NOT <= Q;
    end
    else if (J==1'b1 & K==1'b0)
    begin
        Q<= 1;
        Q_NOT <= 0;
    end
    else if (J==1'b0 & K==1'b1)
    begin
        Q<= 0;
        Q_NOT <= 1;
    end
  end
endmodule

module part5(
    input clk,
    output [3:0] Q
    );
    jk_flip_flop jk_ff1(1,1,clk,Q[0]);
    jk_flip_flop jk_ff2(1,1,clk,Q[1]);
    jk_flip_flop jk_ff3(1,1,clk,Q[2]);
    jk_flip_flop jk_ff4(1,1,clk,Q[3]);
endmodule

module part6(
    input clk,
    output [3:0] Q
    );
    jk_flip_flop jk_ff1(1,1,clk,Q[0]);
    jk_flip_flop jk_ff2(Q[0],Q[0],clk,Q[1]);
    jk_flip_flop jk_ff3(Q[0] & Q[1],Q[0] & Q[1],clk,Q[2]);
    jk_flip_flop jk_ff4(Q[1] & Q[2],Q[1] & Q[2],clk,Q[3]);
endmodule