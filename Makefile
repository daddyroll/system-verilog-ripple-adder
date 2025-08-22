# Makefile for SystemVerilog Ripple-Carry Adder Project
# Uses Icarus Verilog for compilation and simulation

# Compiler and simulator
IVERILOG = iverilog
VVP = vvp
GTKWAVE = gtkwave

# Directories
RTL_DIR = rtl
TB_DIR = tb
SIM_DIR = sim

# Source files
RTL_FILES = $(RTL_DIR)/half_adder.sv \
            $(RTL_DIR)/full_adder.sv \
            $(RTL_DIR)/adder_nbit.sv

TB_FILES = $(TB_DIR)/tb_adder.sv

# Output files
SIM_EXEC = $(SIM_DIR)/adder_sim
VCD_FILE = $(SIM_DIR)/adder_waves.vcd

# Default target
all: compile run

# Compile the design
compile: $(SIM_DIR)
	$(IVERILOG) -g2012 -o $(SIM_EXEC) $(RTL_FILES) $(TB_FILES)

# Run simulation
run: compile
	$(VVP) $(SIM_EXEC) -vcd $(VCD_FILE)

# View waveforms (requires GTKWave)
wave: run
	$(GTKWAVE) $(VCD_FILE)

# Create simulation directory
$(SIM_DIR):
	mkdir -p $(SIM_DIR)

# Clean build artifacts
clean:
	rm -rf $(SIM_DIR)/*
	rm -f *.vcd *.out *.log

# Help target
help:
	@echo "Available targets:"
	@echo "  all     - Compile and run simulation"
	@echo "  compile - Compile SystemVerilog files"
	@echo "  run     - Run simulation and generate VCD"
	@echo "  wave    - Run simulation and open GTKWave"
	@echo "  clean   - Remove build artifacts"
	@echo "  help    - Show this help message"

.PHONY: all compile run wave clean help



