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


@cocotb.test()
async def test_faust_streaming_paths(dut):
    """Exercise both counter-driven and external-sample modes."""
    clock = Clock(dut.clk, 20, units="ns")
    cocotb.start_soon(clock.start())

    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 8)
    dut.rst_n.value = 1

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
