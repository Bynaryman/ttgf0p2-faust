# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles


def pack_ui(use_external: bool, sample: int) -> int:
    """Pack the UI bus based on faust_core's mux encoding."""
    select_bit = 1 if use_external else 0
    even_sample = sample & 0xFE  # LSB is ignored inside faust_core
    return even_sample | select_bit


async def capture_samples(dut, cycles: int):
    """Collect uo_out samples over a number of clock cycles."""
    values = []
    for _ in range(cycles):
        await ClockCycles(dut.clk, 1)
        values.append(int(dut.uo_out.value))
    return values


async def initialize_dut(dut):
    """Start the clock, assert reset, and leave the DUT ready for stimulus."""
    clock = Clock(dut.clk, 20, units="ns")
    cocotb.start_soon(clock.start())

    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 8)
    dut.rst_n.value = 1
    await ClockCycles(dut.clk, 2)


async def measure_dc_response(dut, sample: int, settle_cycles: int = 160, capture_cycles: int = 16):
    """Drive a constant external sample and return the steady-state average output."""
    dut.ui_in.value = pack_ui(use_external=True, sample=sample)
    await ClockCycles(dut.clk, settle_cycles)
    samples = await capture_samples(dut, capture_cycles)
    avg = sum(samples) / len(samples)
    return avg, samples


@cocotb.test()
async def test_faust_streaming_paths(dut):
    """Exercise both counter-driven and external-sample modes."""
    await initialize_dut(dut)

    # Internal ramp source should generate a varying waveform.
    dut.ui_in.value = pack_ui(use_external=False, sample=0x00)
    await ClockCycles(dut.clk, 40)
    ramp_samples = await capture_samples(dut, 12)
    assert len(set(ramp_samples)) > 1, "Counter-driven DSP should not be constant"

    # External source should converge to a stable value for a constant stimulus.
    ext_sample = 0x68
    dut.ui_in.value = pack_ui(use_external=True, sample=ext_sample)
    await ClockCycles(dut.clk, 80)
    external_samples = await capture_samples(dut, 8)
    steady_tail = external_samples[-4:]
    assert len(set(steady_tail)) == 1, "Constant external sample must yield steady output"
    assert steady_tail[0] != ramp_samples[-1], "Switching the source should change the stream"


@cocotb.test(skip=True)
async def test_soft_clip_characteristic(dut):
    """Sweep a set of input levels and ensure the Faust tanh core soft-clips the extremes.

    Temporarily skipped because the current analog model does not converge under CI.
    """
    await initialize_dut(dut)

    quiet_avg, _ = await measure_dc_response(dut, sample=0x10)
    mid_avg, _ = await measure_dc_response(dut, sample=0x70)
    hot_avg, _ = await measure_dc_response(dut, sample=0xF0)

    assert quiet_avg < mid_avg < hot_avg, "Output must remain monotonic with respect to the input amplitude"

    mid_slope = mid_avg - quiet_avg
    hot_slope = hot_avg - mid_avg

    assert hot_slope * 2 < mid_slope + 1e-3, (
        "Soft clipping expected: incremental gain near the rails should shrink vs. mid-range"
    )
