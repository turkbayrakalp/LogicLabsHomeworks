`timescale 1ns / 1ps

module CharDecoder_sim(); 
   reg [7:0] char;
   wire [25:0] decodedChar;
   
   CharDecoder uut(char, decodedChar);
   initial begin
       char = "A"; #100;
       char = "Z"; #100;
       char = "T"; #100;
       char = "C"; #100;
       char = "F"; #100;
       char = "D"; #100;
       char = "Y"; #100;
   end
endmodule

module CharEncoder_sim();
   reg [25:0] decodedChar;
   wire [7:0] char;
   
   CharEncoder uut(decodedChar, char);
   initial begin
        decodedChar = 26'h0000020; #100;
        decodedChar = 26'h0000400; #100;
        decodedChar = 26'h0020000; #100;
        decodedChar = 26'b10000000000000000000000000; #100;
        decodedChar = 26'b00000000010000000000000000; #100;
        decodedChar = 26'b00000000000000000000000001; #100;
        decodedChar = 26'b00000000000000000000000100; #100;
        decodedChar = 26'b00000000000000000000001000; #100;    
   end
endmodule

module CircularLeftShift_sim(); 
   reg [25:0]data;
   reg [4:0]shiftAmount;
   wire [25:0]out;
   CircularLeftShift uut(data, shiftAmount, out);

   initial begin
        data = 26'b10000000000000000000000000; shiftAmount = 5'b00010; #200;
        data = 26'b00000000000000000000000001; shiftAmount = 5'b00001; #200;
        data = 26'b00000000000000000000000010; shiftAmount = 5'b00001; #200;
        data = 26'b00000000000000000000000100; shiftAmount = 5'b00100; #200;
   end
endmodule

module CircularRightShift_sim(); 
   reg [25:0]data;
   reg [4:0]shiftAmount;
   wire [25:0]out;
   CircularRightShift uut(data, shiftAmount, out);

   initial begin
        data = 26'b10000000000000000000000000; shiftAmount = 5'b00010; #200;
        data = 26'b00000000000000000000000001; shiftAmount = 5'b00001; #200;
        data = 26'b00000000000000000000000010; shiftAmount = 5'b00001; #200;
        data = 26'b00000000000000000000000100; shiftAmount = 5'b00100; #200;  
   end
endmodule

module CaesarEncryption_sim();
    reg [7:0] plainChar;
    reg [4:0] shiftCount;
    wire [7:0] chipherChar;
   
   CaesarEncryption uut(plainChar, shiftCount, chipherChar);
   initial begin
        plainChar = "A"; shiftCount = 3; #150;
        plainChar = "F"; shiftCount = 3; #150;        
        plainChar = "X"; shiftCount = 3; #150;
        plainChar = "B"; shiftCount = 3; #150;
        plainChar = "E"; shiftCount = 3; #150;
        plainChar = "G"; shiftCount = 3; #150;
   end

endmodule

module CaesarDecryption_sim();
    reg [7:0] chipherChar;
    reg [4:0] shiftCount;
    wire [7:0] decryptedChar;
   
   CaesarDecryption uut(chipherChar, shiftCount, decryptedChar);
   initial begin
        chipherChar = "D"; shiftCount = 3; #150;
        chipherChar = "I"; shiftCount = 3; #150;
        chipherChar = "A"; shiftCount = 3; #150;    
        chipherChar = "E"; shiftCount = 3; #150;
        chipherChar = "H"; shiftCount = 3; #150;
        chipherChar = "J"; shiftCount = 3; #150;
   end
endmodule

module CaesarEnvironment_sim();
    reg [7:0] plainChar;
    reg [4:0] shiftCount;
    wire [7:0] chipherChar;
    wire [7:0] decryptedChar;
   
   CaesarEnvironment uut(plainChar, shiftCount, chipherChar, decryptedChar);
   initial begin
        plainChar = "A"; shiftCount = 3; #150;
        plainChar = "F"; shiftCount = 3; #150;        
        plainChar = "X"; shiftCount = 3; #150;
        plainChar = "B"; shiftCount = 3; #150;
        plainChar = "E"; shiftCount = 3; #150;
        plainChar = "G"; shiftCount = 3; #150;
   end
endmodule

module VigenereEncryption_sim(); 
   reg [7:0] plainChar;
   reg [79:0] keyInput;
   reg load;
   reg clock;
   wire [7:0] chipherChar;
   
   VigenereEncryption uut(plainChar, keyInput, load, clock, chipherChar);
   initial begin
       clock = 0;   load = 1; plainChar = "I"; keyInput = "KADIROZLEM"; #66;
                    load = 0; plainChar = "S"; keyInput = "KADIROZLEM"; #66;
                    load = 0; plainChar = "T"; keyInput = "KADIROZLEM"; #66;
                    load = 0; plainChar = "A"; keyInput = "KADIROZLEM"; #66;
                    load = 0; plainChar = "N"; keyInput = "KADIROZLEM"; #66;
                    load = 0; plainChar = "B"; keyInput = "KADIROZLEM"; #66;
                    load = 0; plainChar = "U"; keyInput = "KADIROZLEM"; #66;
                    load = 0; plainChar = "L"; keyInput = "KADIROZLEM"; #66;
                    load = 0; plainChar = "T"; keyInput = "KADIROZLEM"; #66;
                    load = 0; plainChar = "E"; keyInput = "KADIROZLEM"; #66;
                    load = 0; plainChar = "C"; keyInput = "KADIROZLEM"; #66;
                    load = 0; plainChar = "H"; keyInput = "KADIROZLEM"; #66;
                    load = 0; plainChar = "N"; keyInput = "KADIROZLEM"; #66;
                    load = 0; plainChar = "I"; keyInput = "KADIROZLEM"; #66;
                    load = 0; plainChar = "C"; keyInput = "KADIROZLEM"; #66;

   end
   always begin
       clock <= ~clock; #33;
   end

endmodule

module VigenereDecryption_sim(); 
   reg [7:0] chipherChar;
   reg [79:0] keyInput;
   reg load;
   reg clock;
   wire [7:0] decryptedChar;
   
   VigenereDecryption uut(chipherChar, keyInput, load, clock, decryptedChar);
   initial begin
       clock = 0;   load = 1; chipherChar = "S"; keyInput = "KADIROZLEM"; #66;
                    load = 0; chipherChar = "S"; keyInput = "KADIROZLEM"; #66;
                    load = 0; chipherChar = "W"; keyInput = "KADIROZLEM"; #66;
                    load = 0; chipherChar = "I"; keyInput = "KADIROZLEM"; #66;
                    load = 0; chipherChar = "E"; keyInput = "KADIROZLEM"; #66;
                    load = 0; chipherChar = "P"; keyInput = "KADIROZLEM"; #66;
                    load = 0; chipherChar = "T"; keyInput = "KADIROZLEM"; #66;
                    load = 0; chipherChar = "W"; keyInput = "KADIROZLEM"; #66;
                    load = 0; chipherChar = "X"; keyInput = "KADIROZLEM"; #66;
                    load = 0; chipherChar = "Q"; keyInput = "KADIROZLEM"; #66;
                    load = 0; chipherChar = "M"; keyInput = "KADIROZLEM"; #66;
                    load = 0; chipherChar = "H"; keyInput = "KADIROZLEM"; #66;
                    load = 0; chipherChar = "Q"; keyInput = "KADIROZLEM"; #66;
                    load = 0; chipherChar = "Q"; keyInput = "KADIROZLEM"; #66;
                    load = 0; chipherChar = "T"; keyInput = "KADIROZLEM"; #66;
   end
   always begin
       clock <= ~clock; #33;
   end
endmodule

module VigenereEnvironment_sim(); 
   reg [7:0] plainChar;
   reg [79:0] keyInput;
   reg load;
   reg clock;
   reg clock2;
   wire [7:0] chipherChar;
   wire [7:0] decryptedChar;
   VigenereEnvironment uut(plainChar, keyInput, load, clock, clock2, chipherChar, decryptedChar);

   initial begin
       clock = 0; clock2 = 0;   load = 1; plainChar = "I"; keyInput = "KADIROZLEM"; #66.6;
                                load = 0; plainChar = "S"; keyInput = "KADIROZLEM"; #66.6;
                                load = 0; plainChar = "T"; keyInput = "KADIROZLEM"; #66.6;
                                load = 0; plainChar = "A"; keyInput = "KADIROZLEM"; #66.6;
                                load = 0; plainChar = "N"; keyInput = "KADIROZLEM"; #66.6;
                                load = 0; plainChar = "B"; keyInput = "KADIROZLEM"; #66.6;
                                load = 0; plainChar = "U"; keyInput = "KADIROZLEM"; #66.6;
                                load = 0; plainChar = "L"; keyInput = "KADIROZLEM"; #66.6;
                                load = 0; plainChar = "T"; keyInput = "KADIROZLEM"; #66.6;
                                load = 0; plainChar = "E"; keyInput = "KADIROZLEM"; #66.6;
                                load = 0; plainChar = "C"; keyInput = "KADIROZLEM"; #66.6;
                                load = 0; plainChar = "H"; keyInput = "KADIROZLEM"; #66.6;
                                load = 0; plainChar = "N"; keyInput = "KADIROZLEM"; #66.6;
                                load = 0; plainChar = "I"; keyInput = "KADIROZLEM"; #66.6;
                                load = 0; plainChar = "C"; keyInput = "KADIROZLEM"; #66.6;
       end
   always begin
       clock <= ~clock; #33.3;
   end
   always begin
       #0.2
       clock2 <= ~clock2; #33.1;
   end
endmodule

module Rotor1_sim(); 
   reg [25:0]forwardInput;
   reg [25:0]backwardInput;
   reg [4:0]startPosition;
   reg load;
   reg clockIn;
   wire clockOut;
   wire [25:0]forwardOutput;
   wire [25:0]backwardOutput;
   Rotor1 uut(forwardInput, backwardInput, startPosition, load, clockIn,clockOut, forwardOutput, backwardOutput);

   initial begin
        clockIn = 0;    startPosition = 5'd0;   forwardInput = 26'b00000000000000000000010000; backwardInput = 26'b00000000000000000000000001; load = 0; #250;
                        startPosition = 5'd5;   forwardInput = 26'b00000000000000010000000000; backwardInput = 26'b00000000000000000000000010; load = 1; #250;
                                                forwardInput = 26'b00000000000001000000000000; backwardInput = 26'b00000000000000000000000100; load = 0; #250;
                                                forwardInput = 26'b00000000000000000000100000; backwardInput = 26'b00000000000000000000001000; #250;
   end
   always begin
       clockIn <= ~clockIn; #125;
   end
endmodule
 
module Rotor2_sim(); 
   reg [25:0]forwardInput;
   reg [25:0]backwardInput;
   reg [4:0]startPosition;
   reg load;
   reg clockIn;
   wire clockOut;
   wire [25:0]forwardOutput;
   wire [25:0]backwardOutput;
   Rotor2 uut(forwardInput, backwardInput, startPosition, load, clockIn,clockOut, forwardOutput, backwardOutput);

   initial begin
        clockIn = 0;    startPosition = 5'd4;   forwardInput = 26'b00000000000000000000010000; backwardInput = 26'b00000000000000000000000001; load = 1; #250;
                        startPosition = 5'd5;   forwardInput = 26'b00000000000000010000000000; backwardInput = 26'b00000000000000000000000010; load = 0; #250;
                                                forwardInput = 26'b00000000000001000000000000; backwardInput = 26'b00000000000000000000000100; #250;
                                                forwardInput = 26'b00000000000000000000100000; backwardInput = 26'b00000000000000000000001000; #250;
   end
   always begin
       clockIn <= ~clockIn; #125;
   end
endmodule

module Rotor3_sim(); 
   reg [25:0]forwardInput;
   reg [25:0]backwardInput;
   reg [4:0]startPosition;
   reg load;
   reg clockIn;
   wire [25:0]forwardOutput;
   wire [25:0]backwardOutput;
   Rotor3 uut(forwardInput, backwardInput, startPosition, load, clockIn, forwardOutput, backwardOutput);

   initial begin
        clockIn = 0;    startPosition = 5'd4;   forwardInput = 26'b00000000000000000000010000; backwardInput = 26'b00000000000000000000000001; load = 1; #250;
                        startPosition = 5'd5;   forwardInput = 26'b00000000000000010000000000; backwardInput = 26'b00000000000000000000000010; load = 0; #250;
                                                forwardInput = 26'b00000000000001000000000000; backwardInput = 26'b00000000000000000000000100; #250;
                                                forwardInput = 26'b00000000000000000000100000; backwardInput = 26'b00000000000000000000001000; #250;
   end
   always begin
       clockIn <= ~clockIn; #125;
   end
endmodule

module PlugBoard_sim();
    reg  [25:0] charInput;
    reg  [25:0] backwardInput;
    wire [25:0] forwardOutput;
    wire [25:0] backwardOutput;
    PlugBoard uut(charInput,backwardInput,forwardOutput,backwardOutput);
    initial begin
        charInput = 26'b00000000000000000000010000; backwardInput = 26'b00000000000000000000010000; #250;
        charInput = 26'b00000000000000010000000000; backwardInput = 26'b00000000000000010000000000; #250;
        charInput = 26'b00000000000001000000000000; backwardInput = 26'b00000000000001000000000000; #250;
        charInput = 26'b00000000000000000000100000; backwardInput = 26'b00000000000000000000100000; #250;
   end
endmodule

module Reflector_sim(); 
   reg [25:0]inputConnection;
   wire [25:0]outputConnection;
   Reflector uut(inputConnection, outputConnection);

   initial begin
        inputConnection = 26'b00000000000000000000010000;#250;
        inputConnection = 26'b00000000000000010000000000;#250;
        inputConnection = 26'b00000000000001000000000000;#250;
        inputConnection = 26'b00000000000000000000100000;#250;
   end
endmodule

module EnigmaCommunication_sim(); 
   reg [7:0]plainChar;
   reg [4:0]startPosition1;
   reg [4:0]startPosition2;
   reg [4:0]startPosition3;
   reg load;
   reg clock;
   wire [7:0]chipherChar;
   wire [7:0]decryptedChar;
   EnigmaCommunication uut(plainChar, startPosition1, startPosition2, startPosition3, load,clock, chipherChar,decryptedChar);

   initial begin
        clock= 0;   plainChar = "I"; startPosition1 = 5'd24; startPosition2 = 5'd25; startPosition3 = 5'd25; load = 1; #250;
                    plainChar = "S"; startPosition1 = 5'd24; startPosition2 = 5'd25; startPosition3 = 5'd25; load = 0; #250;
                    plainChar = "T"; startPosition1 = 5'd24; startPosition2 = 5'd25; startPosition3 = 5'd25;#250;
                    plainChar = "A"; startPosition1 = 5'd24; startPosition2 = 5'd25; startPosition3 = 5'd25;#250;
   end   
   always begin
       clock <= ~clock; #125;
   end
endmodule

module EnigmaMachine_sim(); 
   reg [7:0]char;
   reg [4:0]startPosition1;
   reg [4:0]startPosition2;
   reg [4:0]startPosition3;
   reg load;
   reg clock;
   wire [7:0]outChar;
   EnigmaMachine uut(char, startPosition1, startPosition2, startPosition3, load,clock, outChar);

   initial begin
        clock= 0;   char = "I"; startPosition1 = 5'd0; startPosition2 = 5'd0; startPosition3 = 5'd0; load = 1; #250;
                    char = "S"; startPosition1 = 5'd0; startPosition2 = 5'd0; startPosition3 = 5'd0; load = 0; #250;
                    char = "T"; startPosition1 = 5'd0; startPosition2 = 5'd0; startPosition3 = 5'd0;#250;
                    char = "A"; startPosition1 = 5'd0; startPosition2 = 5'd0; startPosition3 = 5'd0;#250;
   end
   always begin
       clock <= ~clock; #125;
   end
endmodule
