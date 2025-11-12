/*
 * Simple placeholder Faust core generating a 16-bit ramp.
 */

`default_nettype none

module faust_core (
    input  wire       clk,
    input  wire       rst,   // Active-high synchronous reset
    output reg [15:0] out
);

  always @(posedge clk) begin
    if (rst) begin
      out <= 16'd0;
    end else begin
      out <= out + 16'd1;
    end
  end

endmodule
