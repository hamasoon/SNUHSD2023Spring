from amaranth import *
from functools import reduce


class TestArray(Elaboratable):
    def __init__(self, len_arr):
        self.len_arr = len_arr

        self.in_bool = Array([Signal(1, name=f"in_bool_{i}")    # set multiple port as once!
                              for i in range(len_arr)])         # assign name of array by using for
        self.out_bool = Signal(1)

    def elaborate(self, platform):
        m = Module()

        m.d.comb += [
            self.out_bool.eq(
                reduce(lambda acc, cur: acc & cur, self.in_bool, 1)     # we can use reduce function for signal array!
            )
        ]

        return m


if __name__ == '__main__':
    len_arr = 3
    dut = TestArray(len_arr=len_arr)

    from amaranth.sim import Simulator, Delay, Settle
    import numpy as np

    def test_case(dut, in_bool):
        for i, b in enumerate(in_bool):
            yield dut.in_bool[i].eq(bool(b))
        yield Settle()
        yield Delay(1e-6)

    def bench():
        for i in range(2 ** len_arr):
            yield from test_case(
                dut, np.random.randint(low=0, high=2, size=len_arr))

    from pathlib import Path
    p = Path(__file__)

    sim = Simulator(dut)
    sim.add_process(bench)

    with open(p.with_suffix('.vcd'), 'w') as f:
        with sim.write_vcd(f):
            sim.run()

    from amaranth.back import verilog
    top = TestArray(len_arr=len_arr)
    with open(p.with_suffix('.v'), 'w') as f:
        f.write(
            verilog.convert(
                top,
                ports=[*top.in_bool, top.out_bool]))