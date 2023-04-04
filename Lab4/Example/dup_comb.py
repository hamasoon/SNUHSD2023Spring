from amaranth import *


class DupComb(Elaboratable):
    def __init__(self, ):

        self.cnt = Signal(4)
        self.cnt_ovf = Signal(1)
        self.cnt_next = Signal(5)

        self.in_halt = Signal(1)
        self.in_rst = Signal(1)

    def elaborate(self, platform):
        m = Module()

        m.d.sync += [
            Cat(self.cnt, self.cnt_ovf).eq(self.cnt_next),
        ]

        m.d.comb += [
            self.cnt_next.eq(self.cnt + 1),
        ]

        with m.If(self.in_halt):
            m.d.comb += [
                self.cnt_next.eq(self.cnt_next),
            ]
        return m


if __name__ == '__main__':
    dut = DupComb()
    dut = ResetInserter(dut.in_rst)(dut)

    from amaranth.sim import Simulator

    def test_case(dut, in_halt, in_rst):
        yield dut.in_halt.eq(in_halt)
        yield dut.in_rst.eq(in_rst)
        yield

    def bench():
        for i in range(32):
            yield from test_case(dut, i % 4 == 0, i % 16 == 0)

    from pathlib import Path
    p = Path(__file__)

    sim = Simulator(dut)
    sim.add_clock(1e-6)
    sim.add_sync_process(bench)

    with open(p.with_suffix('.vcd'), 'w') as f:
        with sim.write_vcd(f):
            sim.run()

    from amaranth.back import verilog
    top = DupComb()
    with open(p.with_suffix('.v'), 'w') as f:
        f.write(
            verilog.convert(
                top,
                ports=[top.in_halt]))