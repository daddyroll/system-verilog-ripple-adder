# Full Adder Equivalence & Gate-Level Comparison

## Overview

This experiment demonstrates **functional equivalence verification** and **synthesis comparison** between two different full-adder implementations:

1. **Naive Implementation** (`full_adder_naive.sv`) - Uses two half-adders + OR gate
2. **Optimized Implementation** (`full_adder_opt.sv`) - Uses factored carry logic

## Key Learning Objectives

- **Functional Equivalence**: Verify both implementations produce identical results
- **Synthesis Analysis**: Compare gate-level complexity using Yosys
- **RTL Optimization**: Understand how coding style affects synthesis results

## Project Structure

```
experiments/full_adder_equiv/
├── rtl/
│   ├── half_adder.sv          # Half adder implementation
│   ├── full_adder_naive.sv    # Naive full adder (hierarchical)
│   └── full_adder_opt.sv      # Optimized full adder (factored)
├── tb/
│   └── tb_full_adder_equiv.v  # Equivalence testbench
├── scripts/
│   └── fa_compare.ys          # Yosys synthesis comparison script
├── reports/
│   └── fa_compare.log         # Synthesis comparison results
└── README.md
```

## Implementation Details

### Naive Full Adder
```verilog
// Uses two half-adders + OR gate for carry
half_adder ha0(.x(a), .y(b), .s(s1), .c(c1));
half_adder ha1(.x(s1), .y(cin), .s(sum), .c(c2));
assign cout = c1 | c2;
```

### Optimized Full Adder
```verilog
// Uses factored carry logic
wire p; // propagate term
wire c1, c2;
assign p = a ^ b;
assign sum = p ^ cin;
assign c1 = a & b;
assign c2 = p & cin;
assign cout = c1 | c2;
```

## How to Run

### 1. Functional Equivalence Test
```bash
# Compile and run equivalence testbench
iverilog -g2012 -o sim/fa_equiv_tb \
  tb/tb_full_adder_equiv.v \
  rtl/half_adder.sv \
  rtl/full_adder_naive.sv \
  rtl/full_adder_opt.sv
vvp sim/fa_equiv_tb
```

### 2. Synthesis Comparison
```bash
# Run Yosys synthesis comparison
yosys -s scripts/fa_compare.ys | tee reports/fa_compare.log
```

## Expected Results

### Functional Equivalence
```
FULL ADDER EQUIV PASS: 8 vectors OK.
```

### Synthesis Comparison
Both implementations should synthesize to the same primitive cell count, demonstrating that:
- **Coding style affects synthesis results** - Different RTL implementations can lead to different gate-level representations
- **The factored carry `cout = (a & b) | (cin & (a ^ b))` is more efficient** than the naïve 3-term sum-of-products
- **Hierarchical vs flattened counts** - Yosys shows both per-module cells and flattened primitive counts

## Key Insights

1. **Logical Equivalence**: Both implementations are functionally identical
2. **Synthesis Efficiency**: The factored form uses shared logic more efficiently
3. **Design Hierarchy**: Yosys reveals the true primitive counts after flattening

## Tools Used

- **Icarus Verilog**: Functional simulation and equivalence checking
- **Yosys**: Synthesis and gate-level analysis
- **SystemVerilog**: RTL design and testbench implementation




