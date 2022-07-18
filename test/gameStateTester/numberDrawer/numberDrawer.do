# Set the working dir, where all compiled Verilog goes.
vlib work

# Compile all Verilog modules in mux.v to working dir;
# could also have multiple Verilog files.
# The timescale argument defines default time unit
# (used when no unit is specified), while the second number
# defines precision (all times are rounded to this value)
vlog -timescale 1ns/1ns numberDrawer.v

# Load simulation using mux as the top level simulation module.
vsim numberDrawer

# Log all signals and add some signals to waveform window.
log {/*}
# add wave {/*} would add all items in top level simulation module.
add wave {/*}

force {numbers} 0000_1111_1110_1101_1100_1011_1010_1001_1000_0111_0110_0101_0100_0011_0010_0001
force {clk} 0 0, 1 1 -r 2
force {enable} 0
force {resetn} 0
run 2

force {enable} 1
force {resetn} 1
run 10000


