from amaranth import *


class TestMemory(Elaboratable):
    def __init__(self, width=8, depth_bits=4):
        self.addr_bits = depth_bits

        self.adr = Signal(self.addr_bits)
        self.dat_r = Signal(width)
        self.dat_w = Signal(width)
        self.we = Signal(1)

        self.mem = Memory(width=width, depth=2 ** depth_bits)

    def elaborate(self, platform):
        m = Module()

        m.submodules.rdport = rdport = self.mem.read_port()
        m.submodules.wrport = wrport = self.mem.write_port()

        # NOTE address alias for write & read
        # NOTE 1 cycle delay for read, 1 cycle delay for write
        m.d.comb += [
            rdport.addr.eq(self.adr),
            self.dat_r.eq(rdport.data),
            wrport.addr.eq(self.adr),
            wrport.data.eq(self.dat_w),
            wrport.en.eq(self.we),
        ]

        return m


if __name__ == '__main__':
    width = 32
    depth_bits = 3
    dut = TestMemory(width=width, depth_bits=depth_bits)

    from amaranth.sim import Simulator
    import numpy as np

    def test_case(dut, adr, dat_w, we):
        yield dut.adr.eq(adr)
        yield dut.dat_w.eq(dat_w)
        yield dut.we.eq(we)
        yield

    def bench():
        for i in range(2 * (2 ** depth_bits)):
            rdm = int(np.random.randint(low=0, high=0xffff, size=1))
            yield from test_case(dut, adr=i % (2 ** depth_bits), dat_w=rdm, we=i < 2 ** depth_bits)
        for i in range(2 ** depth_bits):
            data = yield dut.mem._array._inner[i]
            print(data)

    from pathlib import Path
    p = Path(__file__)

    sim = Simulator(dut)
    sim.add_clock(1e-6)
    sim.add_sync_process(bench)

    with open(p.with_suffix('.vcd'), 'w') as f:
        with sim.write_vcd(f):
            sim.run()

    from amaranth.back import verilog
    top = TestMemory(width=width, depth_bits=depth_bits)
    with open(p.with_suffix('.v'), 'w') as f:
        f.write(
            verilog.convert(
                top,
                ports=[top.adr, top.dat_r, top.dat_w, top.we]))