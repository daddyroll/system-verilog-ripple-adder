# Adder Verification Project (SystemVerilog)

## Overview

This project demonstrates a SystemVerilog verification environment for an N-bit ripple-carry adder. It goes beyond simple functional checks by generating randomized input vectors, applying them to the DUT, and performing automated pass/fail checks.

**Key verification skills demonstrated:**
- Testbench design
- Random stimulus generation
- Automated result checking
- Waveform visualization using GTKWave

## Project Structure

```
adder-verification/
├── rtl/
│   └── adder_nbit.sv          # DUT: N-bit ripple-carry adder
├── tb/
│   └── tb_adder_random.sv     # Testbench with randomized vectors
├── waves/
│   └── adder_wave.vcd         # Example waveform dump (for GTKWave)
└── README.md
```

## How to Run

### 1. Compile DUT + Testbench
```bash
iverilog -o adder_tb rtl/adder_nbit.sv tb/tb_adder_random.sv
```

### 2. Run Simulation
```bash
vvp adder_tb
```
The terminal will show PASS or FAIL messages for 2000 randomized vectors.

### 3. View Waveforms (Optional)
```bash
gtkwave adder_wave.vcd
```

## Example Output

```bash
# Testbench started with 2000 random vectors
# Vector 123: PASS
# Vector 124: PASS
# ...
# All tests passed!
```

## Key Features

- Parameterized N-bit adder (easily change bit-width)
- Randomized testing to ensure coverage
- Self-checking testbench (no manual checking needed)
- Compatible with Icarus Verilog + GTKWave (open-source flow)

## Related Work

- [Ripple-Carry Adder (Design Focus)](https://github.com/daddyroll/system-verilog-ripple-adder) → focuses on RTL design
- This repo → focuses on verification methodology
