module process_wrapper(
  input [7:0] in0,
  input  in0_valid,
  input  start_valid,
  input  clk,
  input  rst,
  input  out0_ready,
  input  end_ready,
  output  in0_ready,
  output  start_ready,
  output [7:0] out0,
  output  out0_valid,
  output  end_valid
);
  wire [7:0] process_wrapped_out0;
  wire  process_wrapped_out0_valid;
  wire  process_wrapped_out0_ready;
  wire  process_wrapped_end_valid;
  wire  process_wrapped_end_ready;

  assign out0 = process_wrapped_out0;
  assign out0_valid = process_wrapped_out0_valid;
  assign process_wrapped_out0_ready = out0_ready;
  assign end_valid = process_wrapped_end_valid;
  assign process_wrapped_end_ready = end_ready;

  process process_wrapped(
    .in0 (in0),
    .in0_valid (in0_valid),
    .in0_ready (in0_ready),
    .start_valid (start_valid),
    .start_ready (start_ready),
    .clk (clk),
    .rst (rst),
    .out0 (process_wrapped_out0),
    .out0_valid (process_wrapped_out0_valid),
    .out0_ready (process_wrapped_out0_ready),
    .end_valid (process_wrapped_end_valid),
    .end_ready (process_wrapped_end_ready)
  );

endmodule
