`include "./gameBoardDatapath/gameBoardDatapath.v"
`include "./gameBoardFSM/gameBoardFSM.v"
module gameBoardPart2(
	input clk,
    input resetn,
	input [63: 0] initialGameBoard,
	input [2: 0] go,  //001 up, 010 down, 011 left, 100 right. default (no operation is 000)
	input [5: 0] initialState, // means which block is empty, e.g., 000001 means S_1 state.
	output ifWin,
	output [63: 0] blockState
);

	
	wire [4: 0] moveTo, moveFrom;

	gameBoardFSM f0(
		.clk(clk),
		.resetn(resetn),
		.go(go),
		.initialState(initialState),
		.moveTo(moveTo),
		.moveFrom(moveFrom)
	);
	gameBoardDatapath d0(
		.clk(clk),
		.resetn(resetn),
		.moveTo(moveTo),
		.moveFrom(moveFrom),
		.initialGameBoard(initialGameBoard),
		.ifWin(ifWin),
		.blockState(blockState)
	);

	
endmodule