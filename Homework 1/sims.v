`timescale 1ns / 1ps

module and_gate_sim(

    );
    reg I1;
    reg I2;
    wire O;
    
    and_gate and_gate_uut(.I1(I1), .I2(I2), .O(O));
    
    initial
    begin
    I1 = 0; I2 = 0; #250;
    I1 = 0; I2 = 1; #250;
    I1 = 1; I2 = 0; #250;
    I1 = 1; I2 = 1; #250;
    end
endmodule

module or_gate_sim(

    );
    reg I1;
    reg I2;
    wire O;
    
    or_gate or_gate_uut(.I1(I1), .I2(I2), .O(O));
    
    initial
    begin
    I1 = 0; I2 = 0; #250;
    I1 = 0; I2 = 1; #250;
    I1 = 1; I2 = 0; #250;
    I1 = 1; I2 = 1; #250;
    end
endmodule

module not_gate_sim(
    );
    reg I;
    wire O;
    
    not_gate not_gate_uut(.I(I), .O(O));
    
    initial
    begin
    I = 0; #250;
    I = 1; #250;
    end
endmodule

module nand_gate_sim(

    );
    reg I1;
    reg I2;
    wire O;
    
    nand_gate nand_gate_uut(.I1(I1), .I2(I2), .O(O));
    
    initial
    begin
    I1 = 0; I2 = 0; #250;
    I1 = 0; I2 = 1; #250;
    I1 = 1; I2 = 0; #250;
    I1 = 1; I2 = 1; #250;
    end
endmodule

module nand_3_gate_sim(

    );
    reg I1;
    reg I2;
    reg I3;
    wire O;
    
    nand_3_gate nand_3_gate_uut(.I1(I1), .I2(I2), .I3(I3), .O(O));
    
    initial
    begin
        I1 = 0; I2 = 0; I3 = 0; #50;
        I1 = 0; I2 = 0; I3 = 1; #50;
        I1 = 0; I2 = 1; I3 = 0; #50;
        I1 = 0; I2 = 1; I3 = 1; #50;
        I1 = 1; I2 = 0; I3 = 0; #50;
        I1 = 1; I2 = 0; I3 = 1; #50;
        I1 = 1; I2 = 1; I3 = 0; #50;
        I1 = 1; I2 = 1; I3 = 1; #50;
    end
endmodule

module xor_gate_sim(

    );
    reg I1;
    reg I2;
    wire O;
    
    xor_gate xor_gate_uut(.I1(I1), .I2(I2), .O(O));
    initial
    begin
    I1 = 0; I2 = 0; #250;
    I1 = 0; I2 = 1; #250;
    I1 = 1; I2 = 0; #250;
    I1 = 1; I2 = 1; #250;
    end
endmodule

module decoder_gate_sim(

    );
    reg S0;
    reg S1;
    reg S2;
    wire O0;
    wire O1;
    wire O2;
    wire O3;
    wire O4;
    wire O5;
    wire O6;
    wire O7;
    
    decoder_gate decoder_gate_uut(.S0(S0), .S1(S1), .S2(S2), .O0(O0), .O1(O1), .O2(O2), .O3(O3), .O4(O4), .O5(O5), .O6(O6), .O7(O7));
    initial
    begin
        S0 = 0; S1 = 0; S2 = 0; #250;
        S0 = 0; S1 = 0; S2 = 1; #250;
        S0 = 0; S1 = 1; S2 = 0; #250;
        S0 = 0; S1 = 1; S2 = 1; #250;
        S0 = 1; S1 = 0; S2 = 0; #250;
        S0 = 1; S1 = 0; S2 = 1; #250;
        S0 = 1; S1 = 1; S2 = 0; #250;
        S0 = 1; S1 = 1; S2 = 1; #250;
    end
endmodule

module multiplexer_gate_sim(

    );
    reg S0;
    reg S1;
    reg S2;
    reg I0;
    reg I1;
    reg I2;
    reg I3;
    reg I4;
    reg I5;
    reg I6;
    reg I7;
    wire O;
    
    multiplexer_gate multiplexer_gate_uut(.S0(S0), .S1(S1), .S2(S2), .I0(I0), .I1(I1), .I2(I2), .I3(I3), .I4(I4), .I5(I5), .I6(I6), .I7(I7), .O(O));
    initial
    begin
    S0 = 0; S1 = 0; S2 = 0; I0 = 0; I1 = 0; I2 = 0; I3 = 0; I4 = 0; I5 = 0; I6 = 0; I7 = 0; #250;
    S0 = 0; S1 = 0; S2 = 0; I0 = 1; I1 = 0; I2 = 0; I3 = 0; I4 = 0; I5 = 0; I6 = 0; I7 = 0; #250;
    S0 = 1; S1 = 0; S2 = 0; I0 = 0; I1 = 0; I2 = 0; I3 = 0; I4 = 0; I5 = 0; I6 = 0; I7 = 0; #250;
    S0 = 1; S1 = 0; S2 = 0; I0 = 0; I1 = 1; I2 = 0; I3 = 0; I4 = 0; I5 = 0; I6 = 0; I7 = 0; #250;
    end
endmodule

module exp_part2_sim(
    );
    
    reg a;
    reg b;
    reg c;
    reg d;
    wire o;
    
    exp_part2 exp_part2_uut(.a(a), .b(b), .c(c), .d(d), .o(o));
    
    initial
    begin
        a = 0; b = 0; c = 0; d = 0; #250; // 1
        a = 1; b = 1; c = 1; d = 1; #250; // 1
        a = 1; b = 1; c = 1; d = 0; #250; // 0
        a = 0; b = 1; c = 1; d = 0; #250; // 1
    end
endmodule

module exp_part3_sim(
    );
    reg a;
    reg b;
    reg c;
    reg d;
    wire o;
    
    exp_part3 exp_part3_uut(.a(a), .b(b), .c(c), .d(d), .o(o));
    initial
    begin
    a = 0; b = 0; c = 0; d = 0; #100; // 1
    a = 0; b = 0; c = 0; d = 1; #100; // 0
    a = 0; b = 1; c = 1; d = 1; #100; // 1
    a = 0; b = 0; c = 1; d = 1; #100; // 1
    end
endmodule

module exp_part4_sim(
    );
    reg a;
    reg b;
    reg c;
    reg d;
    wire o;
    
    exp_part4 exp_part4_uut(.a(a), .b(b), .c(c), .d(d), .o(o));
    
    initial
    begin
    a = 0; b = 0; c = 0; d = 0; #100; // 1
    a = 1; b = 1; c = 1; d = 0; #100; // 0
    a = 1; b = 0; c = 1; d = 0; #100; // 1
    a = 1; b = 1; c = 1; d = 1; #100; // 1
    a = 0; b = 0; c = 0; d = 1; #100; // 0
    end
endmodule

module exp_part5_sim(
    );
    reg a;
    reg b;
    reg c;
    wire o;
    
    exp_part5 exp_part5_uut(.a(a), .b(b), .c(c), .o(o));
    
    initial
    begin
    a = 0; b = 0; c = 0; #100;
    a = 1; b = 1; c = 1; #100;
    a = 1; b = 0; c = 1; #100;
    a = 1; b = 1; c = 0; #100;
    end
endmodule

module half_adder_sim(

    );
    reg a;
    reg b;
    wire s;
    wire c;
    
    half_adder half_adder_uut(.a(a), .b(b), .s(s), .c(c));
    
    initial begin
    a = 0; b = 0; #250;
    a = 0; b = 1; #250;
    a = 1; b = 0; #250;
    a = 1; b = 1; #250;
    
    end
endmodule

module full_adder_sim(

    );
    reg a;
    reg b;
    reg cin;
    wire sum;
    wire cout;
    
    full_adder full_adder_uut(.a(a), .b(b), .cin(cin), .sum(sum), .cout(cout));
    
    initial begin
    a = 0; b = 0; cin = 0; #100;
    a = 0; b = 0; cin = 1; #100;
    a = 0; b = 1; cin = 0; #100;
    a = 0; b = 1; cin = 1; #100;
    a = 1; b = 0; cin = 0; #100;
    a = 1; b = 0; cin = 1; #100;
    a = 1; b = 1; cin = 0; #100;
    a = 1; b = 1; cin = 1; #100;
    
    end
endmodule

module four_bit_full_adder_sim(

    );
    reg [3:0] A;
    reg [3:0] B;
    reg Cin;
    wire [3:0] S;
    wire Cout;
    
    four_bit_full_adder four_bit_uut(.A(A), .B(B), .Cin(Cin), .S(S), .Cout(Cout));
    
    initial begin
    A = 4'b1000; B = 4'b0001; Cin = 0; # 100; //8 + 1 = 9
    A = 4'b0010; B = 4'b0111; Cin = 0; # 100; //2 + 7 = 9
    A = 4'b0100; B = 4'b0101; Cin = 0; # 100; //4 + 5 = 9
    A = 4'b1011; B = 4'b1010; Cin = 0; # 100; //11 + 10 = 21
    A = 4'b1110; B = 4'b0101; Cin = 0; # 100; //14 + 5 = 19
    A = 4'b1111; B = 4'b1001; Cin = 0; # 100; //15 + 9 = 24
    A = 4'b0110; B = 4'b0011; Cin = 0; # 100; //6 + 3 = 9*/
    end
endmodule

module eight_bit_full_adder_sim(

    );
    reg [7:0] A;
    reg [7:0] B;
    reg Cin;
    wire [7:0] S;
    wire Cout;
    
    
    eight_bit_full_adder eight_bit_full_adder_uut(.A(A), .B(B), .Cin(Cin), .S(S), .Cout(Cout));
    
    initial begin
    A = 8'b00011101; B = 8'b00000101; Cin = 0; #100; // 29 + 5
    A = 8'b00110011; B = 8'b01011100; Cin = 0; #100; // 51 + 92
    A = 8'b00010001; B = 8'b00011100; Cin = 0; #100; // 17 + 28
    A = 8'b10111111; B = 8'b00000010; Cin = 0; #100; // 191 + 2
    A = 8'b11001000; B = 8'b01011111; Cin = 0; #100; // 200 + 95
    A = 8'b00110001; B = 8'b00011001; Cin = 0; #100; // 49 + 25
    A = 8'b01001110; B = 8'b11111111; Cin = 0; #100; // 78 + 255
    A = 8'b00101011; B = 8'b00111011; Cin = 0; #100; // 200 + 95
    end
endmodule

module sixteen_bit_full_adder_sim(

    );
    reg [15:0] A;
    reg [15:0] B;
    reg Cin;
    wire [15:0] S;
    wire Cout;
    
    sixteen_bit_full_adder sixteen_bit_uut(.A(A), .B(B), .Cin(Cin), .S(S), .Cout(Cout));
    
    initial begin
    A = 16'b0000000000010111; B = 16'b0000000000000011; Cin = 0; #100; // 23 + 3
    A = 16'b0000000000010101; B = 16'b0000000001001011; Cin = 0; #100; // 21 + 75
    A = 16'b0100000110100000; B = 16'b0100001000000100; Cin = 0; #100; // 16800 + 16900
  //A = 16'b10001000011001010; B = 16'b10000001111000100; Cin = 0; #100; // 69834 + 66500 NOT REPRESENTABLE
    A = 16'b0000000101000101; B = 16'b0000000001100001; Cin = 0; #100; // 325 + 97
    A = 16'b0000000000101100; B = 16'b0000000010111110; Cin = 0; #100; // 44 + 190
    A = 16'b0000000111001111; B = 16'b0000000011110001; Cin = 0; #100; // 463 + 241

    end
endmodule

module subtractor_sim(

    );
    reg [15:0] A;
    reg [15:0] B;
    //reg Cin, // Always = 1 because it always subtracts
    wire [15:0] two_A;
    wire [15:0] minus_two_A;
    wire [15:0] S;
    wire Cout;
    
    subtractor subtractor_uut(.A(A), .B(B), .two_A(two_A), .minus_two_A(minus_two_A), .S(S), .Cout(Cout));
    
    initial begin
    A = 16'b0000000000100000; B = 16'b0000000000000111; #200; // A = 32 B = 7
    A = 16'b0000000000010101; B = 16'b0000000001010101; #200; // A = 21 B = 85
    A = 16'b0000000000010000; B = 16'b0000000000100100; #200; // A = 16 B = 36
    A = 16'b0000000100000000; B = 16'b0000000000000101; #200; // A = 256 B = 5
    A = 16'b0000000011001000; B = 16'b0000000001011111; #200; // A = 200 B = 95
    A = 16'b0000000000101101; B = 16'b0000000100001111; #200; // A = 45 B = 135
    A = 16'b0000000000100100; B = 16'b0000000011111111; #200; // A = 36 B = 255
    A = 16'b0000000000011001; B = 16'b0000000001000001; #200; // A = 25 B = 65
    end
endmodule