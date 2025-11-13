`default_nettype none

/*
 * Faust DSP wrapper
 *
 * - Instantiates the generated `process_wrapper` module.
 * - Provides a simple streaming source that always keeps the DSP fed.
 * - Selects between an internal ramp counter and the external UI inputs.
 *
 * UI encoding:
 *   ui_in[0]   : source select (0 = counter, 1 = external sample)
 *   ui_in[7:1] : external sample MSBs, LSB padded with 0
 */

module faust_core (
    input  wire       clk,
    input  wire       rst,     // Active-high synchronous reset
    input  wire [7:0] ui_in,   // TinyTapeout dedicated inputs
    output wire [7:0] out      // Processed audio sample
);

  localparam SAMPLE_WIDTH = 8;

  // ---------------------------------------------------------------------------
  // Sample source selection
  // ---------------------------------------------------------------------------
  wire        select_external = ui_in[0];
  wire [7:0]  external_sample = {ui_in[7:1], 1'b0};

  reg  [7:0]  counter;
  reg  [7:0]  sample_reg;
  reg         start_pending;
  reg         data_pending;

  wire [7:0]  selected_sample = select_external ? external_sample : counter;

  wire       start_ready;
  wire       in_ready;

  // Handshake bookkeeping: issue a new sample once both start and data tokens
  // have been accepted by the Faust pipeline.
  wire start_fire = start_pending && start_ready;
  wire data_fire  = data_pending  && in_ready;

  always @(posedge clk) begin
    if (rst) begin
      counter       <= 8'd0;
      sample_reg    <= 8'd0;
      start_pending <= 1'b0;
      data_pending  <= 1'b0;
    end else begin
      if (start_fire) start_pending <= 1'b0;
      if (data_fire)  data_pending  <= 1'b0;

      if (!start_pending && !data_pending) begin
        sample_reg    <= selected_sample;
        start_pending <= 1'b1;
        data_pending  <= 1'b1;
        counter       <= counter + 8'd1;  // Free-running ramp for self-test
      end
    end
  end

  // ---------------------------------------------------------------------------
  // Faust-generated core
  // ---------------------------------------------------------------------------
  wire [7:0] process_out;
  wire       process_out_valid;
  wire       end_token;

  process_wrapper dsp_core (
      .in0         (sample_reg),
      .in0_valid   (data_pending),
      .in0_ready   (in_ready),
      .start_valid (start_pending),
      .start_ready (start_ready),
      .clk         (clk),
      .rst         (rst),
      .out0        (process_out),
      .out0_valid  (process_out_valid),
      .out0_ready  (1'b1),
      .end_valid   (end_token),
      .end_ready   (1'b1)
  );

  wire _unused_core = &{1'b0, end_token};

  // Hold the most recent processed sample so downstream logic sees a stable bus.
  reg [7:0] out_reg;

  always @(posedge clk) begin
    if (rst) begin
      out_reg <= 8'd0;
    end else if (process_out_valid) begin
      out_reg <= process_out;
    end
  end

  assign out = out_reg;

endmodule

`default_nettype wire
