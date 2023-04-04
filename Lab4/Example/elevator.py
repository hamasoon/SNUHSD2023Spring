from amaranth import *
from enum import Enum


class ElevatorInputSignal(Enum):
    DOWN = 0
    UP = 1


class Elevator(Elaboratable):
    def __init__(self):
        self.in_signal = Signal(1)

        self.out_red = Signal(1)
        self.out_green = Signal(1)

        self.in_rst = Signal(1, reset_less=True)

    def elaborate(self, platform):
        m = Module()

        with m.FSM(reset="Ground"):
            with m.State("Ground"):
                m.d.comb += [
                    self.out_red.eq(1),
                    self.out_green.eq(0),
                ]
                with m.If(self.in_signal == ElevatorInputSignal.UP):
                    m.next = "First"
            with m.State("First"):
                m.d.comb += [
                    self.out_red.eq(0),
                    self.out_green.eq(1),
                ]
                with m.If(self.in_signal == ElevatorInputSignal.DOWN):
                    m.next = "Ground"

        return m


if __name__ == '__main__':
    dut = Elevator()
    dut = ResetInserter(dut.in_rst)(dut)

    from amaranth.sim import Simulator

    def test_case(dut, in_signal):
        yield dut.in_signal.eq(in_signal)
        yield

    def bench():
        for i in range(4):
            yield from test_case(dut, (i // 2) % 2)

    from pathlib import Path
    p = Path(__file__)

    sim = Simulator(dut)
    sim.add_clock(1e-6)
    sim.add_sync_process(bench)

    with open(p.with_suffix('.vcd'), 'w') as f:
        with sim.write_vcd(f):
            sim.run()

    from amaranth.back import verilog
    top = Elevator()
    with open(p.with_suffix('.v'), 'w') as f:
        f.write(
            verilog.convert(
                top,
                ports=[top.in_signal]))