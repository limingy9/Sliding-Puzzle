vlib work

vlog -timescale 1ns/1ns gameBoardFSM.v

vsim gameBoardFSM

log {/*}

add wave {/*}

force {clk} 0 0, 1 5 -r 10

force {resetn} 0 0, 1 10

force {go} 2#000 0ns, 2#010 30ns, 2#000 50ns, 2#011 100ns, 2#000 150ns

force {initialState} 2#000110

run 200ns