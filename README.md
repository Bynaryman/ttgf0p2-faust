![](../../workflows/gds/badge.svg) ![](../../workflows/docs/badge.svg) ![](../../workflows/test/badge.svg) ![](../../workflows/fpga/badge.svg)

# TTGF0P2 Faust Softclip Experiment

## Introduction

This Tiny Tapeout design shows how a one-line Faust tanh soft clipper is compiled to silicon through our `r_arith` and `fixedpoint_arith` MLIR dialects.
The flow approximates `tanh(3x)` on the [-1, 1] input domain with a degree-10 Horner polynomial and quantizes the outputs to 8 bits before lowering to RTL.
The macro (`tt_um_gf0p2_faust_top`) simply multiplexes between an internal ramp and an off-chip drive so the datapath can be probed on hardware.


## Repository Layout

```
.
├── docs/                     # Project summary rendered on the info page
├── info.yaml                 # Tiny Tapeout metadata (pins, authors, etc.)
├── src/
│   ├── project.v             # Aggregates every RTL source for the flow
│   ├── faust_core.v          # MLIR-generated soft clipper datapath
│   ├── ttgf0p2_faust_top.v   # Tile wrapper with muxing/control
│   ├── phasor/               # Support logic (cordic/phasing experiments)
│   └── 20251113-.../         # Complete MLIR/Faust IR snapshots for every lowering step
├── test/
│   ├── Makefile              # Cocotb + fallback Icarus targets
│   ├── tb.v                  # Structural testbench
│   └── test.py               # Cocotb regression suite
└── README.md
```

The `src/20251113-120748-faust-tanh-softclip-switchcase` tree mirrors the full compiler pipeline: `stages/00-frontend` captures the canonical Faust AST, while directories all the way through `70-dynamatic-hdl` store the concretized MLIR and HDL states.

## Faust DSP Source

Before the frontend IR is captured, we write the Faust DSP exactly as shown below. The soft clipper fits in a handful of lines and sets the exact behavior we expect every later stage to preserve:

```faust
// Soft clipping waveshaper using hyperbolic tangent implemented via a foreign function.
gain = 3.0;

tanh = ffunction(float tanhf|tanh|tanhl (float), <math.h>, "");

softclip(x) = tanh(gain * x) / tanh(gain);

process = softclip;
```

Keeping this canonical DSP text nearby makes it easy to re-run the pipeline with adjusted gain or approximation settings without touching the later MLIR artifacts.

## Intermediate Representations

### Stage 00 – Faust frontend

`stages/00-frontend/00-frontend.mlir` records the raw Faust graph before any quantization.
The entire effect is captured with native Faust ops, which preserves the analytic structure for later passes:

```mlir
faust.graph @process(inputs: 1, outputs: 1) {
  %0 = faust.real(3.000000e+00 : f32)
  %1 = faust.tanh(%0 : !faust.rconst)
  %2 = faust.input(0 : ui32)
  %3 = faust.real(3.000000e+00 : f32)
  %4 = faust.mul(%3, %2)
  %5 = faust.tanh(%4)
  %6 = faust.div(%5, %1)
  faust.output(%6)
}
```

Although the literal is annotated as `f32`, the `faust.real` constant models a true real-number gain; the floating-point tag is purely symbolic and only captures the textual origin of the value.

### Stage 10 – `faust-to-core-real-arith` + `configure-faust-real-arith`

Running `--faust-to-core-real-arith --configure-faust-real-arith="config=hls-driver/pipelines/tanh-softclip-8bit-config.json"` (see `stages/10-configure/10-configured.mlir`) migrates the graph into the `r_arith` dialect and tags input domains/precision targets before any piecewise work begins:

```mlir
%3 = r_arith.mul(%2 : !r_arith.r_const, %arg0 : !fixed_pt_arith.fixedpt<0, -7, signed>)
%4 = r_arith.tanh(%3 : !r_arith.r_expr)
%5 = r_arith.div(%4 : !r_arith.r_expr, %1 : !r_arith.r_const)
%7 = r_arith.mul(%5, %6)
%8 = r_arith.machine_repr of %7 as !fixed_pt_arith.fixedpt<0, -7, signed>
```

This stage attaches `r_arith.input_domain = [-1, 1]` metadata, guiding later decisions.

### Stage 20 – `realarith-to-fixed_pt_arith` (uniform piecewise)

`stages/20-uniform-piecewise/20-fixed-piecewise.mlir` shows the result of `--realarith-to-fixed_pt_arith="approximation-method=uniform_piecewise_poly polynomial-degree=10 coeff-storage=switch"`.
The pass partitions the Q0.7 input domain into eight uniform regions (top three fractional bits) and materializes Horner coefficients per region via `scf.index_switch`:

```mlir
%11:11 = scf.index_switch %10 -> !fixed_pt_arith.fixedpt<26, -9, signed>, ...
case 0 {
  %74 = fixed_pt_arith.const <5640589127, !fixed_pt_arith.fixedpt<26, -9, signed>>
  %75 = fixed_pt_arith.const <5510525043, !fixed_pt_arith.fixedpt<24, -9, signed>>
  ...
  scf.yield %74, %75, ..., %84
}
```

The yielded coefficients feed a Horner ladder entirely in `fixed_pt_arith`, keeping every rescale explicit:

```mlir
%12 = fixed_pt_arith.extract <-3, -7, signed> from %arg0
%13 = fixed_pt_arith.rescale_2pow %12 : <-3, -7, signed> shift by -2
%14 = fixed_pt_arith.extend %13 : <-5, -9, signed> to <-3, -9, signed>
%15 = fixed_pt_arith.mul %11#10, %14
%16 = fixed_pt_arith.rescale_2pow %15 : <-4, -18, signed> shift by 6
...
%30 = fixed_pt_arith.add %29, %11#7
```

With the interval mapping encoded, this stage fully describes an 8-segment, degree-10 approximation of `tanh(3x)` and locks down the fixed-point noise injected while truncating back to the 8-bit output format.

### Stage 30 – `fixed_pt_arith-to-arith`

`stages/30-to-arith/30-arith-switchcase.mlir` applies `--fixed_pt_arith-to-arith --cse --symbol-dce --canonicalize`, rewriting every custom op into plain `arith`+`scf` while retaining the switch-case coefficient storage:

```mlir
%0 = arith.shrui %arg0, %c5_i8 : i8
%1 = arith.trunci %0 : i8 to i3
%2 = arith.index_cast %1 : i3 to index
%3:11 = scf.index_switch %2 -> i36, i34, ..., i8
```

### Stage 40 – `switch-to-if`

`stages/40-switch-to-if/40-switch-to-if.mlir` shows the result of `--switch-to-if`, which converts the `scf.index_switch` into a cascade of `scf.if` blocks.
This normalization removes the remaining multi-way constructs so the subsequent control-flow conversion does not have to reason about sparse switch tables.

### Stage 50 – `convert-scf-to-cf`

`stages/50-cf-finalize/50-final.mlir` applies `--convert-scf-to-cf --canonicalize --cse`, replacing every structured op with canonical `cf.br`/`cf.cond_br` while also cleaning up duplicated arithmetic paths.
At this point the function is ready for the Handshake lowering pipeline.

### Stage 55 – `strip-real-arith-arg-attrs`

`stages/55-strip-real-arith-attrs/55-sanitized.mlir` simply drops the `r_arith.input_domain` argument tags via `--strip-real-arith-arg-attrs` so that Dynamatic does not see unknown attributes during the CF→Handshake descent. The numerical behavior is unchanged, but the IR is now sanitized for downstream consumers.

## Hardware emission and future work

Today the hardware back end routes through Dynamatic’s handshake-to-Verilog flow. `stages/70-dynamatic-hdl/process.v` exposes the generated network of forks, merges, and arithmetic kernels that realize the Horner pipeline:

```verilog
module process(
  input [7:0] in0,
  input in0_valid,
  ...
  wire [33:0] constant103_outs;
  wire [33:0] constant214_outs;
  ...
  wire [7:0] shrui0_result;
```

Our next milestone is to bypass the handshake netlist and retarget the same `arith` IR toward CIRCT’s `datapath`/`comb` dialects (or a custom lowering) so that the fixed-point pipeline maps directly into Tiny Tapeout-friendly synchronous logic without the auxiliary control fabric.
Keeping the Dynamatic artifacts in-tree provides a reference for regression until the CIRCT path is validated.

## Testing

All functional verification happens in `test/`.
The Cocotb regression boots the synthesized RTL, toggles between the internal ramp and an external drive, and checks for soft-clipping behavior.
A lightweight Icarus-only path (`make sim`) is available when Cocotb is not installed, while `make` runs the full Python-driven suite.
Waveforms land in `test/tb.vcd` for gtkwave inspection.

## Cite This Work

Related work can be found on published litterature, specifically details on the proposed dialects.
BibTeX entries are below:

```bibtex
@misc{cochard:hal-05063466,
  TITLE = {{Towards Multi-Level Arithmetic Optimizations}},
  AUTHOR = {Cochard, Pierre and Forget, Luc and de Dinechin, Florent and Ledoux, Louis},
  URL = {https://hal.science/hal-05063466},
  NOTE = {Poster},
  HOWPUBLISHED = {{EuroLLVM 2025 -}},
  YEAR = {2025},
  MONTH = Apr,
  KEYWORDS = {mlir ; llvm ; flopoco ; computer arithmetic ; hardare design ; compilation ; high level synthesis},
  PDF = {https://hal.science/hal-05063466v1/file/2025-eurollvm.pdf},
  HAL_ID = {hal-05063466},
  HAL_VERSION = {v1},
}

@article{Ledoux2025Towards,
  author       = {Louis Ledoux and Pierre Cochard and Florent de Dinechin},
  title        = {Towards Optimized Arithmetic Circuits with MLIR},
  journal      = {WiPiEC Journal – Works in Progress in Embedded Computing Journal},
  volume       = {11},
  number       = {1},
  pages        = {4},
  year         = {2025},
  doi          = {10.64552/wipiec.v11i1.90},
  publisher    = {WiPiEC Consortium},
  url          = {https://doi.org/10.64552/wipiec.v11i1.90}
}

```

## Authors

- Louis Ledoux (@bynaryman)
- Pierre Cochard (@phcdev)
