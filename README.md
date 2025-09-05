# Adder Verification Project (SystemVerilog)

## Project Progress

- [Ripple-Carry Adder with Testbench & Waveform Verification](./README.md) ✅ Completed
- [Full Adder Equivalence & Gate-Level Comparison](./experiments/full_adder_equiv/README.md) 🔄 Current

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

## Equivalence Testing
A dedicated testbench (`tb_full_adder_equiv.v`) verifies that the **naïve full adder** and the **optimized full adder** produce identical outputs across all test vectors.  
This confirms functional correctness regardless of internal gate structure.

## Generic Synthesis (Yosys)
Using Yosys synthesis without technology mapping:  

- **Naïve Full Adder**: 5 gates  
  - 2 × XOR  
  - 2 × AND  
  - 1 × OR  
- **Optimized Full Adder**: 2 gates  
  - 1 × XOR3  
  - 1 × MAJ3  

Both designs are logically equivalent, but the optimized version is more compact.

## Sky130 Tech-Mapped Synthesis
Mapped to Sky130 standard cells using Liberty files:  

- **Naïve Full Adder**  
  - 2 × `sky130_fd_sc_hd__and2_0`  
  - 2 × `sky130_fd_sc_hd__xor2_1`  
  - 1 × `sky130_fd_sc_hd__or2_1`  

- **Optimized Full Adder**  
  - 1 × `sky130_fd_sc_hd__xor3_1`  
  - 1 × `sky130_fd_sc_hd__maj3_1`  

### Key Finding
The optimized implementation reduces the logic from 5 primitive cells to 2 composite cells.  
This demonstrates technology-aware optimization: the factored carry (`cout = (a&b) | ((a^b)&cin)`) is efficiently realized by the **MAJ3** gate in Sky130.

## Artifacts & Logs

### Synthesis Logs
- [fa_sky130.log](reports/fa_sky130.log) — Complete Yosys synthesis logs with detailed statistics

### Sky130 Mapped Netlists
- [full_adder_naive_sky130.v](reports/full_adder_naive_sky130.v) — Naïve full adder mapped to Sky130 standard cells
- [full_adder_opt_sky130.v](reports/full_adder_opt_sky130.v) — Optimized full adder mapped to Sky130 standard cells  

### Synthesis Reports

### Generic Synthesis Results
![Full Adder Naive - Generic Synthesis](docs/FINAL%20OUTPUT1.png)
*Naïve full adder generic synthesis showing 5 primitive cells (2×$and, 1×$or, 2×$xor)*

### Sky130 Tech-Mapped Synthesis Results  
![Full Adder Optimized - Sky130 Synthesis](docs/FINAL%20OUTPUT2.png)
*Optimized full adder Sky130 synthesis showing 2 composite cells (1×sky130_fd_sc_hd_maj3_1, 1×sky130_fd_sc_hd_xor3_1)*

## Related Work

- [Ripple-Carry Adder (Design Focus)](https://github.com/daddyroll/system-verilog-ripple-adder) → focuses on RTL design
- This repo → focuses on verification methodology
