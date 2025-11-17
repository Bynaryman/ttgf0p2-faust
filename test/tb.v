`default_nettype none
`timescale 1ns / 1ps

/* This testbench just instantiates the module and makes some convenient wires
   that can be driven / tested by the cocotb test.py.
*/
module tb ();

  // Dump the signals to a VCD file. You can view it with gtkwave or surfer.
  initial begin
    $dumpfile("tb.vcd");
    $dumpvars(0, tb);
    #1;
  end

  // Wire up the inputs and outputs:
  reg        clk;
  reg        rst_n;
  reg        ena;
  reg [7:0]  ui_in;
  reg [7:0]  uio_in;
  wire [7:0] uo_out;
  wire [7:0] uio_out;
  wire [7:0] uio_oe;
  tt_um_gf0p2_faust_top user_project (
      .ui_in  (ui_in),
      .uo_out (uo_out),
      .uio_in (uio_in),
      .uio_out(uio_out),
      .uio_oe (uio_oe),
      .ena    (ena),
      .clk    (clk),
      .rst_n  (rst_n)
  );

  // Clock generation (50 MHz)
  localparam CLK_PERIOD = 20;
  initial clk = 1'b0;
  always #(CLK_PERIOD / 2) clk = ~clk;

  // Stimulus:
  initial begin
    ena    = 1'b1;
    ui_in  = 8'h00;  // LSB=0 => select internal counter
    uio_in = 8'h00;
    rst_n  = 1'b0;

    // Release reset once the design has settled.
    #(10 * CLK_PERIOD);
    rst_n = 1'b1;

    // Let the internal ramp drive the Faust tanh path for a while.
    #(2000 * CLK_PERIOD);
    $finish;
  end

endmodule
