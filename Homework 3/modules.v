module CharDecoder(
    input [7:0] char,
    output reg [25:0] decodedChar
    );
    always @(*)
    begin
        decodedChar = 26'd0;
        decodedChar[char - 65] = 1;
    end
endmodule

module CharEncoder(
    input [25:0] decodedChar,
    output reg [7:0]  char
    );
    integer i;
    always @(*)
    begin
        for(i=0; i<26; i = i + 1)
        begin
            if(decodedChar[i] == 1 )
            begin
                char = i + 65;
            end  
        end
    end 
endmodule

module CircularLeftShift(   
    input [25:0]data,
    input [4:0]shiftAmount,
    output reg [25:0]out
    );
    integer i;
    always@(*)
    begin
        i = 0;
        out = data;
        for(i = 0; i < shiftAmount; i = i+1)
        begin
            out = {out[24:0],out[25]};
        end
    end
endmodule

module CircularRightShift(
    input [25:0]data,
    input [4:0]shiftAmount,
    output reg [25:0]out
    );
    integer i;
    
    always@(*)
    begin
        i = 0;
        out = data;
        for(i = 0; i < shiftAmount; i = i+1)
        begin
            out = {out[0],out[25:1]};
        end
    end
endmodule

module CaesarEncryption(
    input [7:0] plainChar,
    input [4:0] shiftCount,
    output [7:0] chipherChar
    );
    wire [25:0] decoder_result;
    wire [25:0] shift_result;
    
    CharDecoder CharDecoder(plainChar, decoder_result);
    CircularLeftShift CircularLeftShift(decoder_result, shiftCount, shift_result);
    CharEncoder CharEncoder(shift_result, chipherChar);
endmodule 

module CaesarDecryption(
    input [7:0] chipherChar,
    input [4:0] shiftCount,
    output [7:0] decryptedChar
    );
    wire [25:0] decoder_result;
    wire [25:0] shift_result;
    
    CharDecoder CharDecoder(chipherChar, decoder_result);
    CircularRightShift CircularRightShift(decoder_result, shiftCount, shift_result);
    CharEncoder CharEncoder(shift_result, decryptedChar);
endmodule  

module CaesarEnvironment(
    input [7:0] plainChar,
    input [4:0] shiftCount,
    output [7:0] chipherChar,
    output [7:0] decryptedChar
    );
    CaesarEncryption CaesarEncryption(plainChar, shiftCount, chipherChar);
    CaesarDecryption CaesarDecryption(chipherChar, shiftCount, decryptedChar);    
endmodule 

module VigenereEncryption(
    input [7:0] plainChar,
    input [79:0] keyInput,
    input load,
    input clock,
    output reg [7:0] chipherChar
    );

    always@(posedge load)
    begin
       chipherChar <= ((plainChar + keyInput[79:72]) % 26);
    end 
    integer i;
    always@(posedge clock)
    begin
       if(i >= 15)begin
            i = i - 8;
        end
        else begin 
            i = 79;
        end
       chipherChar = ((plainChar + keyInput[i-:8]) %26);
    end  
    always@(*)begin
        chipherChar = chipherChar + 8'h41;
    end
endmodule

module VigenereDecryption(
    input [7:0] chipherChar,
    input [79:0] keyInput,
    input load,
    input clock,
    output reg [7:0] decryptedChar
    );
    always@(posedge load)
    begin
       decryptedChar = (chipherChar  - keyInput[79:72] );
       
       while(decryptedChar[7] == 1) begin
            decryptedChar = decryptedChar + 26;
       end
       
       decryptedChar = decryptedChar % 26;
    end 

    integer i;
    
    always@(posedge clock) begin
        if(i >= 15)begin
            i = i - 8;
        end
        else begin 
            i = 79;
        end
       
       decryptedChar = (chipherChar  - keyInput[i-:8]);
       
       while(decryptedChar[7] == 1)
       begin
            decryptedChar = decryptedChar + 26;
       end
       
       decryptedChar = decryptedChar % 26;
    end
    always@(*)begin
    decryptedChar = decryptedChar + "A";
    end
endmodule

module VigenereEnvironment(
    input [7:0] plainChar,
    input [79:0] keyInput,
    input load,
    input clock,
    input clock2,
    output [7:0] chipherChar,
    output [7:0] decryptedChar
    );
    VigenereEncryption VigenereEncryption(plainChar, keyInput, load, clock, chipherChar);
    VigenereDecryption VigenereDecryption(chipherChar, keyInput, load, clock2, decryptedChar);
endmodule

module PlugBoard(
    input  [25:0] charInput,
    input  [25:0] backwardInput,
    output [25:0] forwardOutput,
    output [25:0] backwardOutput
    );
    assign    forwardOutput[0] = charInput[4];
    assign    forwardOutput[1] = charInput[10];
    assign    forwardOutput[2] = charInput[12];
    assign    forwardOutput[3] = charInput[5];
    assign    forwardOutput[4] = charInput[11];
    assign    forwardOutput[5] = charInput[6];
    assign    forwardOutput[6] = charInput[3];
    assign    forwardOutput[7] = charInput[16];
    assign    forwardOutput[8] = charInput[21];
    assign    forwardOutput[9] = charInput[25];
    assign    forwardOutput[10] = charInput[13];
    assign    forwardOutput[11] = charInput[19];
    assign    forwardOutput[12] = charInput[14];
    assign    forwardOutput[13] = charInput[22];
    assign    forwardOutput[14] = charInput[24];
    assign    forwardOutput[15] = charInput[7];
    assign    forwardOutput[16] = charInput[23];
    assign    forwardOutput[17] = charInput[20];
    assign    forwardOutput[18] = charInput[18];
    assign    forwardOutput[19] = charInput[15];
    assign    forwardOutput[20] = charInput[0];
    assign    forwardOutput[21] = charInput[8];
    assign    forwardOutput[22] = charInput[1];
    assign    forwardOutput[23] = charInput[17];
    assign    forwardOutput[24] = charInput[2];
    assign    forwardOutput[25] = charInput[9];
        
    assign    backwardOutput[4] = backwardInput[0];
    assign    backwardOutput[10] = backwardInput[1];
    assign    backwardOutput[12] = backwardInput[2];
    assign    backwardOutput[5] = backwardInput[3];
    assign    backwardOutput[11] = backwardInput[4];
    assign    backwardOutput[6] = backwardInput[5];
    assign    backwardOutput[3] = backwardInput[6];
    assign    backwardOutput[16] = backwardInput[7];
    assign    backwardOutput[21] = backwardInput[8];
    assign    backwardOutput[25] = backwardInput[9];
    assign    backwardOutput[13] = backwardInput[10];
    assign    backwardOutput[19] = backwardInput[11];
    assign    backwardOutput[14] = backwardInput[12];
    assign    backwardOutput[22] = backwardInput[13];
    assign    backwardOutput[24] = backwardInput[14];
    assign    backwardOutput[7] = backwardInput[15];
    assign    backwardOutput[23] = backwardInput[16];
    assign    backwardOutput[20] = backwardInput[17];
    assign    backwardOutput[18] = backwardInput[18];
    assign    backwardOutput[15] = backwardInput[19];
    assign    backwardOutput[0] = backwardInput[20];
    assign    backwardOutput[8] = backwardInput[21];
    assign    backwardOutput[1] = backwardInput[22];
    assign    backwardOutput[17] = backwardInput[23];
    assign    backwardOutput[2] = backwardInput[24];
    assign    backwardOutput[9] = backwardInput[25];
endmodule

module Rotor1(
    input [25:0]forwardInput,
    input [25:0]backwardInput,
    input [4:0]startPosition,
    input load,
    input clockIn,
    output reg clockOut,
    output [25:0]forwardOutput,
    output [25:0]backwardOutput
    );
    wire [25:0]forwardInput1;
    wire [25:0]forwardInput2;
    wire [25:0]backwardInput1;
    wire [25:0]backwardInput2;
    wire [25:0]forwardOutput1;
    wire [25:0]backwardOutput1;
    wire [4:0]temp_Position;
    reg load_signal = 0;
    always @(posedge load)
    begin
        load_signal = 1;
    end
    assign temp_Position[0] = startPosition[0] & load_signal;
    assign temp_Position[1] = startPosition[1] & load_signal;
    assign temp_Position[2] = startPosition[2] & load_signal;
    assign temp_Position[3] = startPosition[3] & load_signal;
    assign temp_Position[4] = startPosition[4] & load_signal;
    
    CircularRightShift CircularRightShift_forward(forwardInput,temp_Position,forwardInput1);
    CircularRightShift CircularRightShift_backward(backwardInput,temp_Position,backwardInput1);
    
    integer clock_cycles = 0;
    time clock_signal = 0;
    always @(posedge clockIn) begin
        clockOut <= 0;
        clock_signal = 1;       
        
        if(clockOut == 1)begin
            clockOut <= 0;
        end
        
        if(clock_cycles == 25) begin
            clockOut <= 1;
            clock_cycles = 0;
        end

        clock_cycles = clock_cycles + 1;  
    end
    
    CircularRightShift CircularRightShift_forward2(forwardInput1,clock_signal,forwardInput2);
    CircularRightShift CircularRightShift_backward2(backwardInput1,clock_signal,backwardInput2);
        
        assign forwardOutput1[0] = forwardInput2[7];
        assign forwardOutput1[1] = forwardInput2[12];
        assign forwardOutput1[2] = forwardInput2[21];
        assign forwardOutput1[3] = forwardInput2[17];
        assign forwardOutput1[4] = forwardInput2[0];
        assign forwardOutput1[5] = forwardInput2[2];
        assign forwardOutput1[6] = forwardInput2[22];
        assign forwardOutput1[7] = forwardInput2[20];
        assign forwardOutput1[8] = forwardInput2[23];
        assign forwardOutput1[9] = forwardInput2[18];
        assign forwardOutput1[10] = forwardInput2[9];
        assign forwardOutput1[11] = forwardInput2[25];
        assign forwardOutput1[12] = forwardInput2[15];
        assign forwardOutput1[13] = forwardInput2[3];
        assign forwardOutput1[14] = forwardInput2[14];
        assign forwardOutput1[15] = forwardInput2[13];
        assign forwardOutput1[16] = forwardInput2[11];
        assign forwardOutput1[17] = forwardInput2[8];
        assign forwardOutput1[18] = forwardInput2[4];
        assign forwardOutput1[19] = forwardInput2[10];
        assign forwardOutput1[20] = forwardInput2[6];
        assign forwardOutput1[21] = forwardInput2[5];
        assign forwardOutput1[22] = forwardInput2[19];
        assign forwardOutput1[23] = forwardInput2[16];
        assign forwardOutput1[24] = forwardInput2[24];
        assign forwardOutput1[25] = forwardInput2[1];
        
        
        assign backwardOutput1[7] = backwardInput2[0];
        assign backwardOutput1[12] = backwardInput2[1];
        assign backwardOutput1[21] = backwardInput2[2];
        assign backwardOutput1[17] = backwardInput2[3];
        assign backwardOutput1[0] = backwardInput2[4];
        assign backwardOutput1[2] = backwardInput2[5];
        assign backwardOutput1[22] = backwardInput2[6];
        assign backwardOutput1[20] = backwardInput2[7];
        assign backwardOutput1[23] = backwardInput2[8];
        assign backwardOutput1[18] = backwardInput2[9];
        assign backwardOutput1[9] = backwardInput2[10];
        assign backwardOutput1[25] = backwardInput2[11];
        assign backwardOutput1[15] = backwardInput2[12];
        assign backwardOutput1[3] = backwardInput2[13];
        assign backwardOutput1[14] = backwardInput2[14];
        assign backwardOutput1[13] = backwardInput2[15];
        assign backwardOutput1[11] = backwardInput2[16];
        assign backwardOutput1[8] = backwardInput2[17];
        assign backwardOutput1[4] = backwardInput2[18];
        assign backwardOutput1[10] = backwardInput2[19];
        assign backwardOutput1[6] = backwardInput2[20];
        assign backwardOutput1[5] = backwardInput2[21];
        assign backwardOutput1[19] = backwardInput2[22];
        assign backwardOutput1[16] = backwardInput2[23];
        assign backwardOutput1[24] = backwardInput2[24];
        assign backwardOutput1[1] = backwardInput2[25];

    CircularLeftShift CircularLeftShift_forward(forwardOutput1,clock_signal,forwardOutput);
    CircularLeftShift CircularLeftShift_backward(backwardOutput1,clock_signal,backwardOutput);
    
    
endmodule

module Rotor2(
    input [25:0]forwardInput,
    input [25:0]backwardInput,
    input [4:0]startPosition,
    input load,
    input clockIn,
    output reg clockOut,
    output [25:0]forwardOutput,
    output [25:0]backwardOutput
    );

    wire[25:0]forwardInput1;
    wire[25:0]forwardInput2;
    wire[25:0]backwardInput1;
    wire[25:0]backwardInput2;
    wire[25:0]forwardOutput1;
    wire[25:0]backwardOutput1;
    wire [4:0]temp_Position;
    reg load_signal = 0;
    always @(posedge load) begin
        load_signal = 1;
    end
    assign temp_Position[0] = startPosition[0] & load_signal;
    assign temp_Position[1] = startPosition[1] & load_signal;
    assign temp_Position[2] = startPosition[2] & load_signal;
    assign temp_Position[3] = startPosition[3] & load_signal;
    assign temp_Position[4] = startPosition[4] & load_signal;
    
    CircularRightShift CircularRightShift_forward(forwardInput,temp_Position,forwardInput1);
    CircularRightShift CircularRightShift_backward(backwardInput,temp_Position,backwardInput1);
    
    integer clock_cycles = 0;
    time clock_signal = 0;
    always @(posedge clockIn) begin
        clockOut <= 0;
        clock_signal = 1;  
        
        if(clockOut == 1) begin
            clockOut <= 0;  
        end
        
        if(clock_cycles == 25) begin
            clockOut <= 1;          
            clock_cycles = 0;
        end
        clock_cycles = clock_cycles + 1;  
    end
    
    CircularRightShift CircularRightShift_forward2(forwardInput1,clock_signal,forwardInput2);
    CircularRightShift CircularRightShift_backward2(backwardInput1,clock_signal,backwardInput2);
    
        assign forwardOutput1[0] = forwardInput2[19];
        assign forwardOutput1[1] = forwardInput2[4];
        assign forwardOutput1[2] = forwardInput2[7];
        assign forwardOutput1[3] = forwardInput2[6];
        assign forwardOutput1[4] = forwardInput2[12];
        assign forwardOutput1[5] = forwardInput2[17];
        assign forwardOutput1[6] = forwardInput2[8];
        assign forwardOutput1[7] = forwardInput2[5];
        assign forwardOutput1[8] = forwardInput2[2];
        assign forwardOutput1[9] = forwardInput2[0];
        assign forwardOutput1[10] = forwardInput2[1];
        assign forwardOutput1[11] = forwardInput2[20];
        assign forwardOutput1[12] = forwardInput2[25];
        assign forwardOutput1[13] = forwardInput2[9];
        assign forwardOutput1[14] = forwardInput2[14];
        assign forwardOutput1[15] = forwardInput2[22];
        assign forwardOutput1[16] = forwardInput2[24];
        assign forwardOutput1[17] = forwardInput2[18];
        assign forwardOutput1[18] = forwardInput2[15];
        assign forwardOutput1[19] = forwardInput2[13];
        assign forwardOutput1[20] = forwardInput2[3];
        assign forwardOutput1[21] = forwardInput2[10];
        assign forwardOutput1[22] = forwardInput2[21];
        assign forwardOutput1[23] = forwardInput2[16];
        assign forwardOutput1[24] = forwardInput2[11];
        assign forwardOutput1[25] = forwardInput2[23];
        
        assign backwardOutput1[19] = backwardInput2[0];
        assign backwardOutput1[4] = backwardInput2[1];
        assign backwardOutput1[7] = backwardInput2[2];
        assign backwardOutput1[6] = backwardInput2[3];
        assign backwardOutput1[12] = backwardInput2[4];
        assign backwardOutput1[17] = backwardInput2[5];
        assign backwardOutput1[8] = backwardInput2[6];
        assign backwardOutput1[5] = backwardInput2[7];
        assign backwardOutput1[2] = backwardInput2[8];
        assign backwardOutput1[0] = backwardInput2[9];
        assign backwardOutput1[1] = backwardInput2[10];
        assign backwardOutput1[20] = backwardInput2[11];
        assign backwardOutput1[25] = backwardInput2[12];
        assign backwardOutput1[9] = backwardInput2[13];
        assign backwardOutput1[14] = backwardInput2[14];
        assign backwardOutput1[22] = backwardInput2[15];
        assign backwardOutput1[24] = backwardInput2[16];
        assign backwardOutput1[18] = backwardInput2[17];
        assign backwardOutput1[15] = backwardInput2[18];
        assign backwardOutput1[13] = backwardInput2[19];
        assign backwardOutput1[3] = backwardInput2[20];
        assign backwardOutput1[10] = backwardInput2[21];
        assign backwardOutput1[21] = backwardInput2[22];
        assign backwardOutput1[16] = backwardInput2[23];
        assign backwardOutput1[11] = backwardInput2[24];
        assign backwardOutput1[23] = backwardInput2[25];
      
    CircularLeftShift CircularLeftShift_forward(forwardOutput1,clock_signal,forwardOutput);
    CircularLeftShift CircularLeftShift_backward(backwardOutput1,clock_signal,backwardOutput);
    
endmodule

module Rotor3(
    input [25:0]forwardInput,
    input [25:0]backwardInput,
    input [4:0]startPosition,
    input load,
    input clockIn,
    output [25:0]forwardOutput,
    output [25:0]backwardOutput
    );

    wire[25:0]forwardInput1;
    wire[25:0]forwardInput2;
    wire[25:0]backwardInput1;
    wire[25:0]backwardInput2;
    wire[25:0]forwardOutput1;
    wire[25:0]backwardOutput1;
    wire[4:0]temp_Position;
    reg load_signal = 0;
    always @(posedge load) begin
        load_signal = 1;
    end
    assign temp_Position[0] = startPosition[0] & load_signal;
    assign temp_Position[1] = startPosition[1] & load_signal;
    assign temp_Position[2] = startPosition[2] & load_signal;
    assign temp_Position[3] = startPosition[3] & load_signal;
    assign temp_Position[4] = startPosition[4] & load_signal;
    
    CircularRightShift CircularRightShift_forward(forwardInput,temp_Position,forwardInput1);
    CircularRightShift CircularRightShift_backward(backwardInput,temp_Position,backwardInput1);
    
    time clock_signal = 0;
    always @(posedge clockIn) begin        
        clock_signal = 1;
    end
    
    CircularRightShift CircularRightShift_forward2(forwardInput1,clock_signal,forwardInput2);
    CircularRightShift CircularRightShift_backward2(backwardInput1,clock_signal,backwardInput2);
    
        assign forwardOutput1[0] = forwardInput2[19];
        assign forwardOutput1[1] = forwardInput2[0];
        assign forwardOutput1[2] = forwardInput2[6];
        assign forwardOutput1[3] = forwardInput2[1];
        assign forwardOutput1[4] = forwardInput2[15];
        assign forwardOutput1[5] = forwardInput2[2];
        assign forwardOutput1[6] = forwardInput2[18];
        assign forwardOutput1[7] = forwardInput2[3];
        assign forwardOutput1[8] = forwardInput2[16];
        assign forwardOutput1[9] = forwardInput2[4];
        assign forwardOutput1[10] = forwardInput2[20];
        assign forwardOutput1[11] = forwardInput2[5];
        assign forwardOutput1[12] = forwardInput2[21];
        assign forwardOutput1[13] = forwardInput2[13];
        assign forwardOutput1[14] = forwardInput2[25];
        assign forwardOutput1[15] = forwardInput2[7];
        assign forwardOutput1[16] = forwardInput2[24];
        assign forwardOutput1[17] = forwardInput2[8];
        assign forwardOutput1[18] = forwardInput2[23];
        assign forwardOutput1[19] = forwardInput2[9];
        assign forwardOutput1[20] = forwardInput2[22];
        assign forwardOutput1[21] = forwardInput2[11];
        assign forwardOutput1[22] = forwardInput2[17];
        assign forwardOutput1[23] = forwardInput2[10];
        assign forwardOutput1[24] = forwardInput2[14];
        assign forwardOutput1[25] = forwardInput2[12];
        
        assign backwardOutput1[19] = backwardInput2[0];
        assign backwardOutput1[0] = backwardInput2[1];
        assign backwardOutput1[6] = backwardInput2[2];
        assign backwardOutput1[1] = backwardInput2[3];
        assign backwardOutput1[15] = backwardInput2[4];
        assign backwardOutput1[2] = backwardInput2[5];
        assign backwardOutput1[18] = backwardInput2[6];
        assign backwardOutput1[3] = backwardInput2[7];
        assign backwardOutput1[16] = backwardInput2[8];
        assign backwardOutput1[4] = backwardInput2[9];
        assign backwardOutput1[20] = backwardInput2[10];
        assign backwardOutput1[5] = backwardInput2[11];
        assign backwardOutput1[21] = backwardInput2[12];
        assign backwardOutput1[13] = backwardInput2[13];
        assign backwardOutput1[25] = backwardInput2[14];
        assign backwardOutput1[7] = backwardInput2[15];
        assign backwardOutput1[24] = backwardInput2[16];
        assign backwardOutput1[8] = backwardInput2[17];
        assign backwardOutput1[23] = backwardInput2[18];
        assign backwardOutput1[9] = backwardInput2[19];
        assign backwardOutput1[22] = backwardInput2[20];
        assign backwardOutput1[11] = backwardInput2[21];
        assign backwardOutput1[17] = backwardInput2[22];
        assign backwardOutput1[10] = backwardInput2[23];
        assign backwardOutput1[14] = backwardInput2[24];
        assign backwardOutput1[12] = backwardInput2[25];
        
    CircularLeftShift CircularLeftShift_forward(forwardOutput1,clock_signal,forwardOutput);
    CircularLeftShift CircularLeftShift_backward(backwardOutput1,clock_signal,backwardOutput);
    
endmodule

module Reflector(
    input  [25:0]inputConnection,
    output [25:0]outputConnection
    );
    assign  outputConnection[0] = inputConnection[24];
    assign  outputConnection[1] = inputConnection[17];
    assign  outputConnection[2] = inputConnection[20];
    assign  outputConnection[3] = inputConnection[7];
    assign  outputConnection[4] = inputConnection[16];
    assign  outputConnection[5] = inputConnection[18];
    assign  outputConnection[6] = inputConnection[11];
    assign  outputConnection[7] = inputConnection[3];
    assign  outputConnection[8] = inputConnection[15];
    assign  outputConnection[9] = inputConnection[23];
    assign  outputConnection[10] = inputConnection[13];
    assign  outputConnection[11] = inputConnection[6];
    assign  outputConnection[12] = inputConnection[14];
    assign  outputConnection[13] = inputConnection[10];
    assign  outputConnection[14] = inputConnection[12];
    assign  outputConnection[15] = inputConnection[8];
    assign  outputConnection[16] = inputConnection[4];
    assign  outputConnection[17] = inputConnection[1];
    assign  outputConnection[18] = inputConnection[5];
    assign  outputConnection[19] = inputConnection[25];
    assign  outputConnection[20] = inputConnection[2];
    assign  outputConnection[21] = inputConnection[22];
    assign  outputConnection[22] = inputConnection[21];
    assign  outputConnection[23] = inputConnection[9];
    assign  outputConnection[24] = inputConnection[0];
    assign  outputConnection[25] = inputConnection[19];
endmodule

module EnigmaMachine(
    input [7:0]char,
    input [4:0]startPosition1,
    input [4:0]startPosition2,
    input [4:0]startPosition3,
    input load,
    input clock,
    output [7:0]outChar
    );
    wire rotor2_clock;
    wire rotor3_clock;
    wire [25:0] decodedChar;
    wire [25:0] plugOutput;
    wire [25:0] backwardInput;
    wire [25:0] forwardOutput;
    wire [25:0] rotor1_forward;
    wire [25:0] rotor1_backward;
    wire [25:0] rotor2_forward;
    wire [25:0] rotor2_backward; 
    wire [25:0] rotor3_forward;
    wire [25:0] rotor3_backward;
    
    CharDecoder CharDecoder(char,decodedChar);
    PlugBoard PlugBoard(decodedChar,backwardInput,forwardOutput,plugOutput);
    Rotor1 Rotor1(forwardOutput,plugOutput,startPosition1,load,clock,rotor2_clock,rotor1_forward,rotor1_backward);
    Rotor2 Rotor2(rotor1_forward,rotor1_backward,startPosition2,load,rotor2_clock,rotor3_clock,rotor2_forward,rotor2_backward);
    Rotor3 Rotor3(rotor2_forward,rotor2_backward,startPosition3,load,rotor3_clock,rotor3_forward,rotor3_backward);
    Reflector Reflector(rotor3_forward,rotor3_backward);
    CharEncoder CharEncoder(rotor3_backward,outChar);
endmodule

module EnigmaCommunication(
    input [7:0]plainChar,
    input [4:0]startPosition1,
    input [4:0]startPosition2,
    input [4:0]startPosition3,
    input load,
    input clock,
    output [7:0]chipherChar,
    output [7:0]decryptedChar
    );
    
    EnigmaMachine EnigmaMachine1(plainChar,startPosition1,startPosition2,startPosition3,load,clock,chipherChar);
    EnigmaMachine EnigmaMachine2(chipherChar,startPosition1,startPosition2,startPosition3,load,clock,decryptedChar);
endmodule
