vlib work

vlog -timescale 1ns/1ns countDown.v

vsim countDown

log {/*}

add wave {/*}

force {clk} 0 0, 1 5 -r 10

force {resetn} 0 0, 1 10

force {enable} 1

force {minuteIn} 2#0101

force {secondIn} 2#000000

run 500ns