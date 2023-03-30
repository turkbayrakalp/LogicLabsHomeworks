module sr_latch_sim(

    );
    reg S;
    reg R;
    wire Q;
    wire Q_NOT;
    sr_latch uut(.S(S), .R(R), .Q(Q), .Q_NOT(Q_NOT));
    initial
        begin
            S=1'b0; R=1'b0; #100;
            S=1'b1; R=1'b0; #100;
            S=1'b0; R=1'b1; #100;
            S=1'b1; R=1'b1; #100;
        end
endmodule

module sre_latch_sim(
    );
    reg S;
    reg R;
    reg E;
    wire Q;
    wire Q_NOT;
    sr_latch uut(.S(S), .R(R), .E(E), .Q(Q), .Q_NOT(Q_NOT));
    initial
        begin
            E=1'b0; S=1'b0; R=1'b0; #100;
            E=1'b0; S=1'b1; R=1'b0; #100;
            E=1'b0; S=1'b0; R=1'b1; #100;
            E=1'b0; S=1'b1; R=1'b1; #100;
            E=1'b1; S=1'b0; R=1'b0; #100;
            E=1'b1; S=1'b1; R=1'b0; #100;
            E=1'b1; S=1'b0; R=1'b1; #100;
            E=1'b1; S=1'b1; R=1'b1; #100;
        end
endmodule

module d_flip_flop_sim(

    );
    reg D;
    reg clk;
    wire Q;
    wire Q_NOT;
    d_flip_flop uut(.D(D), .clk(clk), .Q(Q), .Q_NOT(Q_NOT));
    initial
        begin
        clk=1'b0; D=1'b0; #100;
        clk=1'b1; D=1'b1; #100;
        clk=1'b0; D=1'b0; #100;
        clk=1'b1; D=1'b0; #100;
        clk=1'b0; D=1'b0; #100;
    end
endmodule

module part4_sim(

    );
    reg J, K, clk;
    wire q, qbar;
    jk_ff uut(.J(J), .K(K), .clk(clk), .q(q), .qbar(qbar));
    initial
        begin
        J =1; K =0; clk =0; #100;
        J =1; K =1; #100;
        J =1; K =1; #100;
        J =0; K =1; #100;
        J =1; K =0; #100;
        J =1; K =0; #100;
        J =0; K =1; #100;
        J =1; K =1;#100;
        $finish;
        end
    always begin
        clk = ~clk; #100;
    end
endmodule

module part5_sim(

    );
    reg clk;
    wire [3:0] Q;
    part5 uut(.clk(clk), .Q(Q));
    initial
        begin
        clk = 1; #25;
        end
    always begin
        clk = ~clk; #25;
    end
endmodule

module part6_sim(
    );
    reg clk;
    wire [3:0] Q;
    part6 uut(.clk(clk), .Q(Q));
    initial
        begin
        clk = 1; #25;
        end
    always begin
        clk = ~clk; #25;
    end
endmodule