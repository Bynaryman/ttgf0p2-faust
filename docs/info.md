<!---

This file is used to generate your project datasheet. Please fill in the information below and delete any unused
sections.

You can also include images in this folder and reference them in the markdown. Each image must be less than
512 kb in size, and the combined size of all images must be less than 1 MB.
-->

## How it works

TTGF0P2 compiles the one-line Faust soft clipper `softclip(x) = tanh(3x) / tanh(3)` into silicon.
The flow snapshots every MLIR stage in `src/20251113-120748-faust-tanh-softclip-switchcase/stages`, which mirrors the pipeline below:

1. **Stage 00 – Faust frontend.** Capture the canonical Faust AST with `faust.graph` ops.
2. **Stage 10 – Real arithmetic.** `--faust-to-core-real-arith --configure-faust-real-arith="config=hls-driver/pipelines/tanh-softclip-8bit-config.json"` tags the input domain `[-1, 1]` and keeps the DSP in symbolic real form.
3. **Stage 20 – Uniform piecewise fixed-point.** `--realarith-to-fixed_pt_arith` subdivides the domain into eight regions, emits Horner coefficients per region, and keeps all truncations explicit.
4. **Stage 30 – FixedPointArith to Arith.** `--fixed_pt_arith-to-arith` rewrites everything into `arith` + `scf` so the datapath is purely integer.
5. **Stage 40/50/55 – Switch normalization and CF prep.** `--switch-to-if`, `--convert-scf-to-cf`, and `--strip-real-arith-arg-attrs` sanitize control flow before Dynamatic lowers the result to handshake/RTL.

The resulting RTL lives in `src/faust_core.v` and is wrapped by `tt_um_gf0p2_faust_top`, which multiplexes between an internal ramp and the external sample bus. `ui_in[0]` selects the source (0 = internal ramp, 1 = external data on `ui_in[7:1]`), and the 8-bit result appears on `uo_out`, ready to drive an R-2R ladder.

## How to test

1. Install the Python requirements (`pip install -r test/requirements.txt`).
2. Run `make -C test` for the full Cocotb suite or `make -C test sim` for the Icarus-only path.
3. Inspect `test/results.xml` or `test/tb.vcd` for pass/fail information and waveforms.

The regression toggles between the internal ramp and external stimulus to ensure the Horner pipeline matches the saved MLIR snapshots.

## External hardware

- Attach the 8-bit Tiny Tapeout DAC (or Digilent Pmod R-2R) to `uo[7:0]` for line-level audio.
- Provide an optional external 7-bit sample stream on `ui[7:1]` (MSB on `ui[7]`) and raise `ui[0]` to route it through the Faust core.
- Keep every `uio` pin unconnected; they remain inputs inside the design.

The Pmod R-2R documentation: https://digilent.com/reference/pmod/pmodr2r/start
