/*
 * Copyright (c) 2024 Louis Ledoux, Pierre Cochard, Emeraude Team @INRIA
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_gf0p2_faust_top (
    input  wire [7:0] ui_in,    // [0]=source select, [7:1]=external sample MSBs
    output wire [7:0] uo_out,   // Dedicated outputs -> R-2R ladder
    input  wire [7:0] uio_in,   // Bidirectional IOs: input path
    output wire [7:0] uio_out,  // Bidirectional IOs: output path
    output wire [7:0] uio_oe,   // Bidirectional IOs: output enable (1=output)
    input  wire       ena,      // Always 1 when powered
    input  wire       clk,      // Global clock
    input  wire       rst_n     // Active-low reset
);

  // ---------------------------------------------------------------------------
  // Internal wires
  // ---------------------------------------------------------------------------
  wire [7:0] faust_sample;    // 8-bit sample stream from the Faust core

  // ---------------------------------------------------------------------------
  // Faust DSP core instance
  // ---------------------------------------------------------------------------
  // The core outputs one sample whenever its internal pipeline produces data.
  faust_core core (
      .clk  (clk),
      .rst  (!rst_n),          // Convert active-low reset to active-high
      .ui_in(ui_in),
      .out  (faust_sample)
  );

  assign uo_out = faust_sample;  // Drive R-2R DAC outputs

  // ---------------------------------------------------------------------------
  // Unused IO configuration
  // ---------------------------------------------------------------------------
  assign uio_out = 8'b0;   // Not used
  assign uio_oe  = 8'b0;   // Configure all UIO pins as inputs

  // Tie off unused inputs to prevent synthesis warnings
  wire _unused = &{ena, uio_in, 1'b0};

endmodule
