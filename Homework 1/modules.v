`timescale 1ns / 1ps

module and_gate(
    input [0:0] I1,
    input [0:0] I2,
    output [0:0] O
    );
    
    assign O = I1 & I2;
endmodule

module or_gate(
    input [0:0] I1,
    input [0:0] I2,
    output [0:0] O
    );
    
    assign O = I1 | I2;
endmodule

module not_gate(
    input [0:0] I,
    output [0:0] O
    );
    
    assign O = ~I;
endmodule

module nand_gate(
    input [0:0] I1,
    input [0:0] I2,
    output [0:0] O
    );
    
    assign O = ~(I1 & I2);
endmodule

module nand_3_gate(
    input [0:0] I1,
    input [0:0] I2,
    input [0:0] I3,
    output [0:0] O
    );
    assign O = ~(I1 & I2 & I3);
endmodule

module xor_gate(
    input [0:0] I1,
    input [0:0] I2,
    output [0:0] O
    );
    
    assign O = (~I1 & I2) | (I1 & ~I2);
endmodule

module decoder_gate(
    input [0:0] S0,
    input [0:0] S1,
    input [0:0] S2,
    output [0:0] O0,
    output [0:0] O1,
    output [0:0] O2,
    output [0:0] O3,
    output [0:0] O4,
    output [0:0] O5,
    output [0:0] O6,
    output [0:0] O7
    );
    
    assign O0 = (~S2 & ~S1 & ~S0),
           O1 = (~S2 & ~S1 & S0),
           O2 = (~S2 & S1 & ~S0),
           O3 = (~S2 & S1 & S0),
           O4 = (S2 & ~S1& ~S0),
           O5 = (S2 & ~S1 & S0),
           O6 = (S2 & S1 & ~S0),
           O7 = (S2 & S1 & S0);
endmodule

module multiplexer_gate(
    input [0:0] S0,
    input [0:0] S1,
    input [0:0] S2,
    input [0:0] I0,
    input [0:0] I1,
    input [0:0] I2,
    input [0:0] I3,
    input [0:0] I4,
    input [0:0] I5,
    input [0:0] I6,
    input [0:0] I7,
    output [0:0] O
    );
    
    assign O = (~S2 & ~S1 & ~S0) & I0 |
               (~S2 & ~S1 & S0)  & I1 |
               (~S2 & S1 & ~S0)  & I2 |
               (~S2 & S1 & S0)   & I3 |
               (S2 & ~S1 & ~S0)  & I4 |
               (S2 & ~S1 & S0)   & I5 |
               (S2 & S1 & ~S0)   & I6 |
               (S2 & S1 & S0)    & I7 ;
endmodule

module exp_part2(
    input a,
    input b,
    input c,
    input d,
    output o
    );
    not_gate not_1(a, a_comp); // a'
    not_gate not_2(b, b_comp); // b'
    not_gate not_3(d, d_comp); // d'
    
    and_gate and_1(b, c, bc); // bc
    and_gate and_2(a_comp, bc , nabc); // a'bc
    
    and_gate and_3(c, d, cd); // cd
    and_gate and_4(a, cd , acd); //acd
    
    and_gate and_5(b_comp, d_comp, nbnd); // b'd'
    
    or_gate or_1(nabc, acd, nabc_or_acd);
    or_gate or_2(nabc_or_acd, nbnd, nabc_or_acd_or_nbnd); // b'd' + acd + a'bc
    
    assign o = nabc_or_acd_or_nbnd;  
endmodule

module exp_part3(
    input a,
    input b,
    input c,
    input d,
    output o
    );
    nand_gate nand_1(a,a,nand_aa); // a'
    nand_gate nand_2(b,b,nand_bb); // b'
    nand_gate nand_3(d,d,nand_dd); // d'
    
    nand_3_gate nand_3_1(nand_aa, b, c, nand_abc); // (a'bc)'
    
    nand_3_gate nand_3_2(a, c, d, nand_acd); // (acd)'
    
    nand_gate nand_4(nand_bb, nand_dd, nand_nbnd); // (b'd')'
    
    nand_3_gate nand_3_3(nand_nbnd, nand_abc, nand_acd, final);
    assign o = final;  
endmodule

module exp_part4(
    input [0:0] a,
    input [0:0] b,
    input [0:0] c,
    input [0:0] d,
    output [0:0] o
    );
    
    not_gate not_1(d, d_comp);
    multiplexer_gate multiplexer_1(c, b, a, d_comp, d_comp, d_comp, 1, d_comp, 1, 0, d, choice);
    assign o = choice;
endmodule

module exp_part5(
    input [0:0] a,
    input [0:0] b,
    input [0:0] c,
    output [0:0] o
    );
    
    decoder_gate decoder_1(c, b, a, o0, o1, o2, o3, o4, o5, o6, o7);
    or_gate or_1(o6, o7, final);
    assign o = final;   
endmodule

module half_adder(
    input a,
    input b,
    output s,
    output c
    );
    xor_gate xor_1(a, b, s);
    and_gate and_1(a, b, c);
endmodule

module full_adder(
    input a,
    input b,
    input cin,
    output sum,
    output cout
    );
    
    half_adder half_adder_1(a, b, sum1, cout1);
    half_adder half_adder_2(sum1, cin, sum, cout2);
    
    or_gate or_1(cout1, cout2, cout);   
endmodule

module four_bit_full_adder(
    input [3:0] A,
    input [3:0] B,
    input [0:0] Cin,
    output [3:0] S,
    output [0:0] Cout
    );
    full_adder full_adder_1(A[0], B[0], Cin, S[0], C0);
    full_adder full_adder_2(A[1], B[1], C0, S[1], C1);
    full_adder full_adder_3(A[2], B[2], C1, S[2], C2);
    full_adder full_adder_4(A[3], B[3], C2, S[3], Cout);
endmodule

module eight_bit_full_adder(
    input [7:0] A,
    input [7:0] B,
    input [0:0] Cin,
    output [7:0] S,
    output [0:0] Cout
    );
    four_bit_full_adder four_bit_1(A[3:0], B[3:0], Cin, S[3:0], C0);
    four_bit_full_adder four_bit_2(A[7:4], B[7:4], C0, S[7:4], Cout);
endmodule

module sixteen_bit_full_adder(
    input [15:0] A,
    input [15:0] B,
    input [0:0] Cin,
    output [15:0] S,
    output [0:0] Cout
    );

    eight_bit_full_adder eight_bit_1(A[7:0], B[7:0], Cin, S[7:0], C0);
    eight_bit_full_adder eight_bit_2(A[15:8], B[15:8], C0, S[15:8], Cout);    
endmodule

module subtractor(
    input [15:0] A,
    input [15:0] B,
    //input Cin, // Always = 1 because it always subtracts
    inout [15:0] two_A,
    inout [15:0] minus_two_A,
    output [15:0] S,
    output Cout
    );
    sixteen_bit_full_adder sixteen_bit_1(A, A, 0, two_A, Cout);
    xor_gate xor_multi [15:0] (two_A, 16'b1111111111111111, minus_two_A);
    sixteen_bit_full_adder sixteen_bit_2(B, minus_two_A, 1, S, Cout);
endmodule