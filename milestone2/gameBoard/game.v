`include "./gameBoardPart2/gameBoardPart2.v"
`include "./gameStateFSM/gameStateFSM.v"
`include "./gameStateDatapath/gameStateDatapath.v"
`include "./countDown/countDown.v"
`include "./movementCounter/movementCounter.v"

module test(
	input [9: 0] SW,
	input [3: 0] KEY,
	input CLOCK_50,
	output [6: 0] HEX0,
	output [6: 0] HEX1,
	output [6: 0] HEX2,
	output [6: 0] HEX3,
	output [6: 0] HEX4,
	output [6: 0] HEX5
);

	wire [5: 0] second;
	wire [3: 0] minute;
	wire [11: 0] count;
	
	game g0(
		.clk(CLOCK_50),
		.resetn(KEY[0]),
		.xOut(),
		.yOut(),
		.colourOut(),
		.minuteOut(minute),
		.secondOut(second),
		.countOut(count)
	);
	
	hex_decoder h0(
		.hex_digit(second % 10),
		.segments(HEX0)
	);
	
	hex_decoder h1(
		.hex_digit(second / 10),
		.segments(HEX1)
	);
	
	hex_decoder h2(
		.hex_digit(minute),
		.segments(HEX2)
	);
	
	hex_decoder h3(
		.hex_digit(count % 100),
		.segments(HEX3)
	);
	
	hex_decoder h4(
		.hex_digit((count % 10) % 10),
		.segments(HEX4)
	);
	
	hex_decoder h5(
		.hex_digit(count / 100),
		.segments(HEX5)
	);
	
	

endmodule

module game(
	input clk,
    input resetn,
	input [2: 0] go, //001 up, 010 down, 011 left, 100 right. default (no operation is 000)
	output [7: 0] xOut,
	output [6: 0] yOut,
	output [2: 0] colourOut,
	output [3: 0] minuteOut,
	output [5: 0] secondOut,
	output [11: 0] countOut
);

	//wire ifWin;
	wire gameOver, drawGrid, drawEZ, drawHARD, drawNORMAL, drawNum, clear, drawGrid, inGame;

	wire [63: 0] blockState, initialGameBoard;
	wire [6: 0] initialState;
	wire [3: 0] minuteGiven;
	wire [5: 0] secondGiven;
	
	wire ifWin;
	wire ifLose;
	wire gameBoardReset;
	assign gameBoardReset = ~((resetn == 1'b0) || (inGame == 1'b0));
	assign ifLose = (secondOut == 6'b000000) && (minuteOut == 4'b0000);
	
	
	movementCounter m0(
		.resetn(gameBoardReset),
		.clk(clk),
		.enable(inGame), //in game
		.countOut(countOut)
	)
	
	countDown c0(
		.clk(clk),
		.resetn(gameBoardReset),
		.enable(inGame), //in game
		.minuteIn(minuteGiven),
		.secondIn(secondGiven),
		.minuteOut(minuteOut),
		.secondOut(secondOut)
	);
	
	gameStateFSM g0(
		.clk(clk),
		.resetn(resetn),
		.go(go),
		.win(ifWin), //time out or win
		.lose(ifLose),
		.drawGrid(drawGrid),
		.drawEZ(drawEZ),
		.drawNORMAL(drawNORMAL),
		.drawHARD(drawHARD),
		.inGame(inGame),
		.drawNum(drawNum),
		.gameOver(gameOver),
		.clear(clear)
	);
	
	gameStateDatapath d0(
		.clk(clk), 
		.resetn(resetn),
		.drawGrid(drawGrid), 
		.drawEZ(drawEZ), 
		.drawNORMAL(drawNORMAL), 
		.drawHARD(drawHARD), 
		.drawNum(drawNum), 
		.clear(clear),
		.numbers(blockState), //input
		.colorOut(colorOut),
		.xOut(xOut),
		.yOut(yOut),
		.initialGameBoard(initialGameBoard),
		.initialState(initialState),
		.secondGiven(secondGiven),
		.minuteGiven(minuteGiven)
	);
	
	gameBoardPart2 g1(
		.clk(clk),
		.resetn(gameBoardReset),
		.initialGameBoard(initialGameBoard),
		.go(go),
		.initialState(initialState),
		.ifWin(ifWin), //output
		.blockState(blockState) //output
	);
	
endmodule

module hex_decoder(hex_digit, segments);
    input [3:0] hex_digit;
    output reg [6:0] segments;
   
    always @(*)
        case (hex_digit)
            4'h0: segments = 7'b100_0000;
            4'h1: segments = 7'b111_1001;
            4'h2: segments = 7'b010_0100;
            4'h3: segments = 7'b011_0000;
            4'h4: segments = 7'b001_1001;
            4'h5: segments = 7'b001_0010;
            4'h6: segments = 7'b000_0010;
            4'h7: segments = 7'b111_1000;
            4'h8: segments = 7'b000_0000;
            4'h9: segments = 7'b001_1000;
            4'hA: segments = 7'b000_1000;
            4'hB: segments = 7'b000_0011;
            4'hC: segments = 7'b100_0110;
            4'hD: segments = 7'b010_0001;
            4'hE: segments = 7'b000_0110;
            4'hF: segments = 7'b000_1110;   
            default: segments = 7'h7f;
        endcase
endmodule