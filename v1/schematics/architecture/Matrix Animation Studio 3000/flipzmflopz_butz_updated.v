module flipzmflopz_butz_updated (clk, rst, Input, Output_1, Output_2);
  parameter UUID = 0;
  parameter NAME = "";
  input wire clk;
  input wire rst;

  input  wire [0:0] Input;
  output  wire [0:0] Output_1;
  output  wire [0:0] Output_2;

  TC_Decoder1 # (.UUID(64'd3970519521177703648 ^ UUID)) Decoder1_0 (.sel(wire_2), .out0(wire_0), .out1(wire_4));
  TC_BitMemory # (.UUID(64'd3163280032365003601 ^ UUID)) BitMemory_1 (.clk(clk), .rst(rst), .save(wire_3), .in(wire_1), .out(wire_2));
  TC_Not # (.UUID(64'd2758340068247873979 ^ UUID), .BIT_WIDTH(64'd1)) Not_2 (.in(wire_2), .out(wire_1));

  wire [0:0] wire_0;
  assign Output_1 = wire_0;
  wire [0:0] wire_1;
  wire [0:0] wire_2;
  wire [0:0] wire_3;
  assign wire_3 = Input;
  wire [0:0] wire_4;
  assign Output_2 = wire_4;

endmodule
