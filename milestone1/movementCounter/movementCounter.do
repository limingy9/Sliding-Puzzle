vlib work

vlog -timescale 1ns/1ns movementCounter.v

vsim movementCounter

log {/*}

add wave {/*}

force {clk} 0 0, 1 5 -r 10

force {resetn} 0 0, 1 10

force {enable} 1

run 500ns