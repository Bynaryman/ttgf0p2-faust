`timescale 1ns / 1ps
module handshake_constant_57 #(
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
  assign outs       = 37'b0100101100010110110100000110100001011;
  assign outs_valid = ctrl_valid;
  assign ctrl_ready = outs_ready;

endmodule
