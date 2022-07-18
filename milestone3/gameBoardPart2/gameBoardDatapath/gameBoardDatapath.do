vlib work

vlog -timescale 1ps/1ps gameBoardDatapath.v

vsim gameBoardDatapath

log {/*}

add wave {/*}

force {clk} 0 0, 1 5 -r 10

force {resetn} 0 0, 1 200ps

force {moveTo} 2#0001
force {moveFrom} 2#0010
force {initialGameBoard} 2#1110101001101000010101110001001011010010111111001011100100110000

run 1000ns