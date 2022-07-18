`include "./gameBoardPart2/gameBoardPart2.v"
`include "./gameStateFSM/gameStateFSM.v"
`include "./gameStateDatapath/gameStateDatapath.v"
`include "./countDown/countDown.v"
`include "./movementCounter/movementCounter.v"
`include "./vga_adapter/vga_adapter.v"
`include "./vga_adapter/vga_controller.v"
`include "./vga_adapter/vga_address_translator.v"
`include "./vga_adapter/vga_pll.v"
module test(
	input [9: 0] SW,
	input [3: 0] KEY,
	input CLOCK_50,
	// The ports below are for the VGA output.  Do not change.
	output VGA_CLK,   						//	VGA Clock
	output VGA_HS,							//	VGA H_SYNC
	output VGA_VS,							//	VGA V_SYNC
	output VGA_BLANK_N,						//	VGA BLANK
	output VGA_SYNC_N,						//	VGA SYNC
	output [9:0] VGA_R,   						//	VGA Red[9:0]
	output [9:0] VGA_G,	 						//	VGA Green[9:0]
	output [9:0] VGA_B,   						//	VGA Blue[9:0]
	output [6: 0] HEX0,
	output [6: 0] HEX1,
	output [6: 0] HEX2,
	output [6: 0] HEX3,
	output [6: 0] HEX4,
	output [6: 0] HEX5
);



// Declare your inputs and outputs here
	wire [7:0] x;
	wire [6:0] y;
	wire [2:0] color;
	wire ifInGame, ifGameOver, ifWin;
// ours
	wire [5: 0] second;
	wire [3: 0] minute;
	wire [11: 0] count;
	wire resetn;
	assign resetn = SW[9];
	
	vga_adapter VGA(
			.resetn(resetn),
			.clock(CLOCK_50),
			.colour(color),
			.x(x),
			.y(y),
			.plot(SW[8]),
			/* Signals for the DAC to drive the monitor. */
			.VGA_R(VGA_R),
			.VGA_G(VGA_G),
			.VGA_B(VGA_B),
			.VGA_HS(VGA_HS),
			.VGA_VS(VGA_VS),
			.VGA_BLANK(VGA_BLANK_N),
			.VGA_SYNC(VGA_SYNC_N),
			.VGA_CLK(VGA_CLK));
		defparam VGA.RESOLUTION = "160x120";
		defparam VGA.MONOCHROME = "FALSE";
		defparam VGA.BITS_PER_COLOUR_CHANNEL = 1;
		defparam VGA.BACKGROUND_IMAGE = "black.mif";
	
	reg [2: 0] go;
	
	
	always @(posedge CLOCK_50) 
	begin
		if (KEY[3] == 1'b0)
			go <= 3'b001;
		else if (KEY[2] == 1'b0)
			go <= 3'b010;
		else if (KEY[1] == 1'b0)
			go <= 3'b011;
		else if (KEY[0] == 1'b0)
			go <= 3'b100;
		else
			go <= 3'b000;
	end
	
	game g0(
		.clk(CLOCK_50),
		.resetn(resetn),
		.go(go),
		.xOut(x),
		.yOut(y),
		.colourOut(color),
		.minuteOut(minute),
		.secondOut(second),
		.countOut(count),
		.ifInGame(ifInGame),
		.ifGameOver(ifGameOver),
		.ifWin(ifWin)
	);
	
	hex_decoder h0(
		.hex_digit(second % 10),
		.segments(HEX0),
		.ifInGame(ifInGame),
		.ifGameOver(ifGameOver),
		.ifWin(ifWin),
		.hexID(3'b000)
	);
	
	hex_decoder h1(
		.hex_digit(second / 10),
		.segments(HEX1),
		.ifInGame(ifInGame),
		.ifGameOver(ifGameOver),
		.ifWin(ifWin),
		.hexID(3'b001)
	);
	
	hex_decoder h2(
		.hex_digit(minute),
		.segments(HEX2),
		.ifInGame(ifInGame),
		.ifGameOver(ifGameOver),
		.ifWin(ifWin),
		.hexID(1'b010)
	);
	
	hex_decoder h3(
		.hex_digit(count % 10),
		.segments(HEX3),
		.ifInGame(ifInGame),
		.ifGameOver(ifGameOver),
		.ifWin(ifWin),
		.hexID(3'b011)
	);
	
	hex_decoder h4(
		.hex_digit((count / 10) % 10),
		.segments(HEX4),
		.ifInGame(ifInGame),
		.ifGameOver(ifGameOver),
		.ifWin(ifWin),
		.hexID(3'b100)
	);
	
	hex_decoder h5(
		.hex_digit(count / 100),
		.segments(HEX5),
		.ifInGame(ifInGame),
		.ifGameOver(ifGameOver),
		.ifWin(ifWin),
		.hexID(3'b101)
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
	output [11: 0] countOut,
	output ifInGame,
	output ifGameOver,
	output ifWin
);

	//wire ifWin;
	wire gameOver, drawGrid, drawEZ, drawHARD, drawNORMAL, drawNum, clear, inGame;
	
	assign ifInGame = inGame;
	assign ifGameOver = gameOver;
	
	wire [63: 0] blockState, initialGameBoard;
	wire [6: 0] initialState;
	wire [3: 0] minuteGiven;
	wire [5: 0] secondGiven;
	
	wire ifLose;
	wire gameBoardReset;
	assign gameBoardReset = ~((resetn == 1'b0) || (inGame == 1'b0));
	assign ifLose = (secondOut == 6'b000000) && (minuteOut == 4'b0000);
	
	
	movementCounter m0(
		.resetn(gameBoardReset),
		.go(go),
		.enable(inGame), //in game
		.countOut(countOut)
	);
	
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
		.colorOut(colourOut),
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

module hex_decoder(hex_digit, segments, ifInGame, ifGameOver, ifWin, hexID);
    input [3:0] hex_digit;
	input ifGameOver, ifInGame, ifWin, hexID;
    output reg [6:0] segments;
   
    always @(*)
		if (ifInGame == 1'b1)
		begin
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
		end
		else if (ifGameOver == 1'b1)
		begin
			if (ifWin == 1'b1) 
			begin
				case(hexID)
					3'b000: segments = 7'b010_0001;
					3'b001: segments = 7'b010_0011;
					3'b010: segments = 7'b010_0011; 
					3'b011: segments = 7'b001_1000;
					default: segments = 7'h7f;
				endcase
			end
			else
			begin
				case(hexID)
					3'b000: segments = 7'b000_0110;
					3'b001: segments = 7'b001_0010;
					3'b010: segments = 7'b100_0000; 
					3'b011: segments = 7'b100_0111;
					default: segments = 7'h7f;
				endcase
			end
		end
endmodule