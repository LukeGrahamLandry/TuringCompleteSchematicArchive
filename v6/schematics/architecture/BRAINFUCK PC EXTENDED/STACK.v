module STACK (clk, rst, POP, PUSH, Input, Output);
  parameter UUID = 0;
  parameter NAME = "";
  input wire clk;
  input wire rst;

  input  wire [0:0] POP;
  input  wire [0:0] PUSH;
  input  wire [15:0] Input;
  output  wire [15:0] Output;

  TC_Ram # (.UUID(64'd1769445781810674440 ^ UUID), .WORD_WIDTH(64'd16), .WORD_COUNT(64'd256)) Ram_0 (.clk(clk), .rst(rst), .load(wire_5), .save(wire_2), .address({{24{1'b0}}, wire_10 }), .in0({{48{1'b0}}, wire_6 }), .in1(64'd0), .in2(64'd0), .in3(64'd0), .out0(wire_7), .out1(), .out2(), .out3());
  TC_Register # (.UUID(64'd4124551315369077048 ^ UUID), .BIT_WIDTH(64'd8)) Register8_1 (.clk(clk), .rst(rst), .load(wire_16), .save(wire_15), .in(wire_0), .out(wire_13));
  TC_Constant # (.UUID(64'd2191923723382915886 ^ UUID), .BIT_WIDTH(64'd8), .value(8'h1)) Constant8_2 (.out(wire_8));
  TC_Add # (.UUID(64'd3694024702693660427 ^ UUID), .BIT_WIDTH(64'd8)) Add8_3 (.in0(wire_13), .in1(wire_3), .ci(1'd0), .out(wire_0), .co());
  TC_Constant # (.UUID(64'd3629740621830647044 ^ UUID), .BIT_WIDTH(64'd1), .value(1'd1)) On_4 (.out(wire_16));
  TC_Or # (.UUID(64'd3408961366828767253 ^ UUID), .BIT_WIDTH(64'd1)) Or_5 (.in0(wire_5), .in1(wire_4), .out(wire_17));
  TC_Switch # (.UUID(64'd3717825088295823402 ^ UUID), .BIT_WIDTH(64'd8)) Switch8_6 (.en(wire_4), .in(wire_13), .out(wire_10_0));
  TC_Switch # (.UUID(64'd2665077490742875059 ^ UUID), .BIT_WIDTH(64'd8)) Switch8_7 (.en(wire_5), .in(wire_0), .out(wire_10_1));
  TC_Constant # (.UUID(64'd3246752864258655758 ^ UUID), .BIT_WIDTH(64'd8), .value(8'hFF)) Constant8_8 (.out(wire_14));
  TC_Switch # (.UUID(64'd2393088290431603376 ^ UUID), .BIT_WIDTH(64'd16)) Output16z_9 (.en(wire_5), .in(wire_7[15:0]), .out(Output));
  TC_Mux # (.UUID(64'd886937604220209854 ^ UUID), .BIT_WIDTH(64'd8)) Mux8_10 (.sel(wire_5), .in0(wire_8), .in1(wire_14), .out(wire_3));
  TC_LessU # (.UUID(64'd48139023949142354 ^ UUID), .BIT_WIDTH(64'd8)) LessU8_11 (.in0(wire_13), .in1(wire_14), .out(wire_11));
  TC_Switch # (.UUID(64'd1060939742680170287 ^ UUID), .BIT_WIDTH(64'd1)) Switch1_12 (.en(wire_11), .in(wire_17), .out(wire_15));
  TC_Equal # (.UUID(64'd1460590757165041191 ^ UUID), .BIT_WIDTH(64'd8)) Equal8_13 (.in0(wire_13), .in1(8'd0), .out(wire_1));
  TC_Not # (.UUID(64'd1741651976860467525 ^ UUID), .BIT_WIDTH(64'd1)) Not_14 (.in(wire_1), .out(wire_9));
  TC_Switch # (.UUID(64'd721402113796423172 ^ UUID), .BIT_WIDTH(64'd1)) Switch1_15 (.en(wire_9), .in(wire_12), .out(wire_5));
  TC_Switch # (.UUID(64'd169572283444044138 ^ UUID), .BIT_WIDTH(64'd1)) Switch1_16 (.en(wire_11), .in(wire_4), .out(wire_2));

  wire [7:0] wire_0;
  wire [0:0] wire_1;
  wire [0:0] wire_2;
  wire [7:0] wire_3;
  wire [0:0] wire_4;
  assign wire_4 = PUSH;
  wire [0:0] wire_5;
  wire [15:0] wire_6;
  assign wire_6 = Input;
  wire [63:0] wire_7;
  wire [7:0] wire_8;
  wire [0:0] wire_9;
  wire [7:0] wire_10;
  wire [7:0] wire_10_0;
  wire [7:0] wire_10_1;
  assign wire_10 = wire_10_0|wire_10_1;
  wire [0:0] wire_11;
  wire [0:0] wire_12;
  assign wire_12 = POP;
  wire [7:0] wire_13;
  wire [7:0] wire_14;
  wire [0:0] wire_15;
  wire [0:0] wire_16;
  wire [0:0] wire_17;

endmodule
