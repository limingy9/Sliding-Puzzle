# Set the working dir, where all compiled Verilog goes.
vlib work

# Compile all Verilog modules in mux.v to working dir;
# could also have multiple Verilog files.
# The timescale argument defines default time unit
# (used when no unit is specified), while the second number
# defines precision (all times are rounded to this value)
# Change X before simulation
vlog -timescale 1ns/1ns numberX.v

# Load simulation using mux as the top level simulation module.
# Change X before simulation
vsim numberX

# Log all signals and add some signals to waveform window.
log {/*}
# add wave {/*} would add all items in top level simulation module.
add wave {/*}

force {xIn} 'd0
force {yIn} 'd0
force {clk} 0 0, 1 1 -r 2
force {enable} 0
force {resetn} 0
run 2

force {enable} 1
force {resetn} 1
run 300


