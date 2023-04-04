from amaranth import *


class AdderSync(Elaboratable):
    def __init__(self, num_bits, delay=1):
        self.num_bits = num_bits                    # parameters
        self.delay = delay                          # parameters
        assert delay >= 0

        self.in_a = Signal(num_bits)                #
        self.in_b = Signal(num_bits)                #
        self.in_rst = Signal(1, reset_less=True)    # reset signal
        self.in_en = Signal(1)                      #
        self.out_d = Signal(num_bits)               #
        self.out_ovf = Signal(1)                    #

        if delay == 0:          # for simulation, setting blocking delay
            delay = 1
        self.sim_delay = Signal((num_bits + 1) * delay) # bit > 1 consider as array

    def elaborate(self, platform):
        m = Module()

        m.d.comb += [           # wire, if want reg, then using m.d.sync
            # {out_d, out_ovf} = delay[0:self.num_bits] - output is MSB of data pipline
            Cat(self.out_d, self.out_ovf).eq(
                self.sim_delay[-(self.num_bits+1):])    # support python's array indexing
        ]

        with m.If(self.in_en):      # Runtime Branch - actual model : use signal!!!!!
            if self.delay == 0:     # Compile time Branch - consider in building model : use parameter
                m.d.comb += [
                    self.sim_delay.eq(self.in_a + self.in_b)
                ]
            else:
                m.d.sync += [   # now used in sync block, all signal consider as reg
                    self.sim_delay.eq(                                  # output pipline
                        self.sim_delay.rotate_left(self.num_bits+1)),   # -> transform data in LSB of sim_delay to MSB
                    self.sim_delay[:self.num_bits+1].eq(
                        self.in_a + self.in_b),                         # set result of addition in LSB of sim_delay
                ]

        return m


if __name__ == '__main__':
    num_bits = 4
    delay = 3

    dut = AdderSync(num_bits, delay=delay)
    dut = ResetInserter(dut.in_rst)(dut)    # auto reset code generate -> reset data with default value

    from amaranth.sim import Simulator
    from collections import deque

    def test_case(dut, in_a, in_b, dout, ovf, in_rst=0, in_en=1):
        yield dut.in_rst.eq(in_rst)
        yield dut.in_en.eq(in_en)
        yield dut.in_a.eq(in_a)
        yield dut.in_b.eq(in_b)
        yield                               # one yield one cycle
        assert (yield dut.out_d == dout)
        assert (yield dut.out_ovf == ovf)

    mask = 0x0001
    for i in range(num_bits - 1):
        mask |= (mask << 1)

    def bench():
        dout_history = deque()
        ovf_history = deque()

        for _ in range(delay):
            dout_history.append(0)
            ovf_history.append(0)

        for i in range(2 ** num_bits):
            for j in range(2 ** num_bits):
                added = i + j
                dout = added & mask
                ovf = (added & (0x0001 << num_bits)) >> num_bits
                dout_history.append(dout)
                ovf_history.append(ovf)

                dout = dout_history.popleft()
                ovf = ovf_history.popleft()
                try:
                    yield from test_case(
                        dut, i, j, dout, ovf)
                except AssertionError:
                    print(i, j, dout, ovf)

    from pathlib import Path
    p = Path(__file__)

    sim = Simulator(dut)
    sim.add_clock(1e-6)
    sim.add_sync_process(bench)
    with open(p.with_suffix('.vcd'), 'w') as f:
        with sim.write_vcd(f):
            sim.run()

    from amaranth.back import verilog
    top = AdderSync(num_bits, delay=delay)
    with open(p.with_suffix('.v'), 'w') as f:
        f.write(
            verilog.convert(
                top, ports=[
                    top.in_en, top.in_a, top.in_b, top.out_d, top.out_ovf]))    # no reset, no clk