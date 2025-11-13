`timescale 1ns / 1ps
module handshake_constant_170 #(
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
  assign outs       = 19'b0100110000011100110;
  assign outs_valid = ctrl_valid;
  assign ctrl_ready = outs_ready;

endmodule
