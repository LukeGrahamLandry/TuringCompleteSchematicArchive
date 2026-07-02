module flipzmflopz_butz_updatedz_WITHz_RESET (clk, rst, Input_1, Input_2, Output_1, Output_2);
  parameter UUID = 0;
  parameter NAME = "";
  input wire clk;
  input wire rst;

  input  wire [0:0] Input_1;
  input  wire [0:0] Input_2;
  output  wire [0:0] Output_1;
  output  wire [0:0] Output_2;

  TC_Decoder1 # (.UUID(64'd3970519521177703648 ^ UUID)) Decoder1_0 (.sel(wire_5), .out0(wire_8), .out1(wire_7));
  TC_BitMemory # (.UUID(64'd3163280032365003601 ^ UUID)) BitMemory_1 (.clk(clk), .rst(rst), .save(wire_2), .in(wire_4), .out(wire_5));
  TC_Not # (.UUID(64'd2758340068247873979 ^ UUID), .BIT_WIDTH(64'd1)) Not_2 (.in(wire_5), .out(wire_6));
  TC_Not # (.UUID(64'd723292370210610846 ^ UUID), .BIT_WIDTH(64'd1)) Not_3 (.in(wire_1), .out(wire_0));
  TC_Switch # (.UUID(64'd2182648853108509061 ^ UUID), .BIT_WIDTH(64'd1)) Switch1_4 (.en(wire_0), .in(wire_3), .out(wire_2_1));
  TC_Switch # (.UUID(64'd4448766059559990622 ^ UUID), .BIT_WIDTH(64'd1)) Switch1_5 (.en(wire_0), .in(wire_6), .out(wire_4));
  TC_Switch # (.UUID(64'd4589941512139056938 ^ UUID), .BIT_WIDTH(64'd1)) Switch1_6 (.en(wire_1), .in(wire_1), .out(wire_2_0));

  wire [0:0] wire_0;
  wire [0:0] wire_1;
  assign wire_1 = Input_2;
  wire [0:0] wire_2;
  wire [0:0] wire_2_0;
  wire [0:0] wire_2_1;
  assign wire_2 = wire_2_0|wire_2_1;
  wire [0:0] wire_3;
  assign wire_3 = Input_1;
  wire [0:0] wire_4;
  wire [0:0] wire_5;
  wire [0:0] wire_6;
  wire [0:0] wire_7;
  assign Output_2 = wire_7;
  wire [0:0] wire_8;
  assign Output_1 = wire_8;

endmodule
