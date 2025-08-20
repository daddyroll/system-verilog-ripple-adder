# Parameterized Ripple-Carry Adder (SystemVerilog) — Part of RISC-V Pipeline Project

## Introduction

This project implements a parameterized ripple-carry adder in SystemVerilog as part of a larger 5-stage pipelined RISC-V processor development. The adder serves as a foundational building block for the Arithmetic Logic Unit (ALU) component.

### Features
- **Half Adder**: Basic XOR and AND gate implementation
- **Full Adder**: Built using two half adders with carry propagation
- **Parameterized N-bit Adder**: Scalable ripple-carry adder using generate loops
- **Comprehensive Testbench**: Full verification with waveform generation

## Files

### Directory Structure
```
adder_topdown/
├── rtl/                    # RTL (Register Transfer Level) files
│   ├── half_adder.sv      # Half adder implementation
│   ├── full_adder.sv      # Full adder implementation  
│   └── adder_nbit.sv      # Parameterized N-bit ripple-carry adder
├── tb/                    # Testbench files
│   └── tb_adder.sv        # Main testbench with stimulus
├── docs/                  # Documentation and results
│   └── [waveform screenshots]     # Simulation results (to be added)
├── sim/                   # Simulation files (empty for EDA Playground)
├── README.md              # This file
├── .gitignore            # Git ignore rules
└── Makefile              # Build automation (future use)
```

## How to Run (EDA Playground)

1. **Access EDA Playground**: Visit [EDA Playground](https://www.edaplayground.com/)
2. **Select Tools & Simulators**: Choose "SystemVerilog" and "Verilator" or "Icarus Verilog"
3. **Upload Files**: Copy and paste the following files:
   - `rtl/half_adder.sv`
   - `rtl/full_adder.sv` 
   - `rtl/adder_nbit.sv`
   - `tb/tb_adder.sv`
4. **Run Simulation**: Click "Run" to compile and simulate
5. **View Waveforms**: Open the generated VCD file to view timing diagrams

### Quick Test
The testbench includes comprehensive test cases covering:
- Edge cases (all zeros, all ones)
- Carry propagation scenarios
- Overflow conditions
- Random test vectors

## Results

### Simulation Status
✅ **Successfully compiled and simulated in EDA Playground**
✅ **Waveforms generated and verified**
✅ **All test cases passed**

### Waveform Screenshot
*Waveform screenshot from EDA Playground simulation showing proper signal timing and carry propagation*

The simulation demonstrates proper:
- Signal propagation through the ripple-carry chain
- Carry generation and propagation timing
- Correct arithmetic results for various input combinations
- Clear timing relationships between inputs (a[0:0], b[0:0], cin) and outputs (sum[0:0], cout)
- Active simulation period showing multiple test vectors with proper carry propagation

## Next Steps

This adder implementation will be integrated into:
1. **ALU Design**: As the core addition/subtraction unit
2. **Pipeline Integration**: Within the Execute stage of the RISC-V pipeline
3. **Performance Optimization**: Potential carry-lookahead improvements

## Tech Stack

- **Hardware Description Language**: SystemVerilog
- **Simulation Tools**: Synopsys VCS, Icarus Verilog, Verilator
- **Development Platform**: EDA Playground (online SystemVerilog simulation)
- **Version Control**: Git with appropriate .gitignore rules
- **Build Automation**: Makefile for local development

## Development Environment

- **Primary**: EDA Playground (online SystemVerilog simulation)
- **Future**: Local development with Icarus Verilog/Verilator
- **Version Control**: Git with appropriate .gitignore rules

---

*Part of the RISC-V Pipeline Processor Project - Day 1 Implementation*
