1. Signal

2. Combinational VS Sequential
- Combinational
``` python
    m.d.Comb += [
        Cat(self.out_d, self.out_ovf).eq(self.in_a + self.in_b)
    ]
```
- Sequnetial
```python
    m.d.Sync += [
        Cat(self.out_d, self.out_ovf).eq(self.in_a + self.in_b)
    ]
```

3. Runtime Branch VS Compiletime Branch
- Runtime branch : Signal parameter condition
```python
    with m.If(condition):
        ...
    with m.Elif(condition):
        ...
    with m.Else():
        ...
```
- Compile time branch : Non-Signal parameter condition
```python
    if condition:
        ...
    elif condition:
        ...
    else:
        ...
```

4. adder_sync : Note to delay
```python
class AdderSync(Elaboratable):
    def __init__(self, num_bits, delay=1):
        self.num_bits = num_bits                    # parameters
        self.delay = delay                          # parameters
        assert delay >= 0

        self.in_a = Signal(num_bits)                # first input
        self.in_b = Signal(num_bits)                # second input
        self.in_rst = Signal(1, reset_less=True)    # reset signal
        self.in_en = Signal(1)                      # enable signal
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
```

10. Design Principle of amaranth
- Set input port and output port with combinational logic
- Using FSM and If/Switch to Control signal like valid, invalid