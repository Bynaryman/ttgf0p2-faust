`timescale 1ns / 1ps
module handshake_constant_70 #(
  parameter DATA_WIDTH = 32  // Default set to 32 bits
) (
  input                       clk,
  input                       rst,
  // Input Channel
  input                       ctrl_valid,
  output                      ctrl_ready,
  // Output Channel
  output [DATA_WIDTH - 1 : 0] outs,
  output                      outs_valid,
  input                       outs_ready
);
  assign outs       = 29'b01010001110110010011001110100;
  assign outs_valid = ctrl_valid;
  assign ctrl_ready = outs_ready;

endmodule
