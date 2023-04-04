from amaranth import *


class Adder(Elaboratable):
    def __init__(self, num_bits):       # port & parameter setting
        self.num_bits = num_bits        # parameter

        # Signal() instead of reg/wire
        # automatically assigned by m.d.comb or m.d.sync
        # used in comb -> wire
        # used in sync -> reg
        # if used in both -> Compile Error!!!!
        # 1-bit, unsigned -> default
        # reset value 0 -> default
        # ex) Signal() -> unsigned 1bit, Signal(4) -> unsigned 4bit, Signal(range(-8, 7)) -> signed(4)
        self.in_a = Signal(num_bits)    # input Signal - Signal cover both wire, reg, input, output
        self.in_b = Signal(num_bits)    # input
        self.out_d = Signal(num_bits)   # output
        self.out_ovf = Signal(1)        # overflow flag
        # NO SYNC UNIT! -> comb

    def elaborate(self, platform):      # logic design(condition & operation)
        m = Module()

        m.d.comb += [
            # assign {out_d, out_ovf} = in_a + in_b
            Cat(self.out_d, self.out_ovf).eq(self.in_a + self.in_b)
        ]

        return m


if __name__ == '__main__':
    num_bits = 4
    dut = Adder(num_bits=num_bits)

    from amaranth.sim import Simulator, Delay, Settle

    def test_case(dut, a, b, d, ovf):       # dut is model, test_case base function
        yield dut.in_a.eq(a)    # deliver input
        yield dut.in_b.eq(b)    # deliver input
        yield Settle()          # check input valid
        yield Delay(1e-6)       # small delay(simulate clk)
        assert (yield dut.out_d == d)       # get output
        assert (yield dut.out_ovf == ovf)   # get output

    def bench():                            # test case setting()
        for i in range(2 ** num_bits):
            for j in range(2 ** num_bits):
                try:
                    yield from test_case(dut, i, j,
                                         (i + j) % (2 ** num_bits),
                                         (i + j) // (2 ** num_bits))
                except AssertionError:
                    print(i, j, (i + j) % (2 ** num_bits),
                          (i + j) // (2 ** num_bits))

    from pathlib import Path
    p = Path(__file__)

    sim = Simulator(dut)
    sim.add_process(bench)  # comb logic -> add_process, sync -> add_sync

    with open(p.with_suffix('.vcd'), 'w') as f:     # get output by vcd file
        with sim.write_vcd(f):
            sim.run()

    from amaranth.back import verilog
    top = Adder(num_bits=num_bits)
    with open(p.with_suffix('.v'), 'w') as f:
        f.write(
            verilog.convert(
                top,
                ports=[top.in_a, top.in_b, top.out_d, top.out_ovf]))    # declare port for verilog translate
