vlib work

vlog -timescale 1ns/1ns gameBoardPart2.v

vsim gameBoardPart2

log {/*}

add wave {/*}

force {clk} 0 0, 1 5 -r 10

force {resetn} 0 0, 1 10

force {initialState} 2#000001

force {go} 3#000 0, 3#001 100, 2#000 150

force {initialGameBoard} 2#1110101001101000010101110001001011010010111111001011100100110000

run 300ns