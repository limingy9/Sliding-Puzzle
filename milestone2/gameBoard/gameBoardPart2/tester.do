vlib work

vlog -timescale 1ns/1ns tester.v

vsim gameBoardPart2

log {/*}

add wave {/*}

force {clk} 0 0, 1 5 -r 10

force {resetn} 0 0, 1 10


force {initialGameBoard} 2#0000111111101101110010111010100110000111011001010100001100100001
force {initialState} 2#010000
force {go} 2#000 0ns, 2#100 50ns, 2#000 100ns

run 6000ns
