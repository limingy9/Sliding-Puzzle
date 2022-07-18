`include "./gameBoardDatapath/gameBoardDatapath.v"
`include "./gameBoardFSM/gameBoardFSM.v"
`include "./vga_adapter/vga_adapter.v"
`include "./vga_adapter/vga_controller.v"
`include "./vga_adapter/vga_address_translator.v"
`include "./vga_adapter/vga_pll.v"
module tester
	(
		LEDR,
		CLOCK_50,						//	On Board 50 MHz
		// Your inputs and outputs here
        KEY,
        SW,
		// The ports below are for the VGA output.  Do not change.
		VGA_CLK,   						//	VGA Clock
		VGA_HS,							//	VGA H_SYNC
		VGA_VS,							//	VGA V_SYNC
		VGA_BLANK_N,						//	VGA BLANK
		VGA_SYNC_N,						//	VGA SYNC
		VGA_R,   						//	VGA Red[9:0]
		VGA_G,	 						//	VGA Green[9:0]
		VGA_B   						//	VGA Blue[9:0]
	);

	input			CLOCK_50;				//	50 MHz
	input   [9:0]   SW;
	input   [3:0]   KEY;
	output [9: 0] LEDR;

	// Declare your inputs and outputs here
	wire [7:0] x;
	wire [6:0] y;
	wire [2:0] color;
	
	// Do not change the following outputs
	output			VGA_CLK;   				//	VGA Clock
	output			VGA_HS;					//	VGA H_SYNC
	output			VGA_VS;					//	VGA V_SYNC
	output			VGA_BLANK_N;				//	VGA BLANK
	output			VGA_SYNC_N;				//	VGA SYNC
	output	[9:0]	VGA_R;   				//	VGA Red[9:0]
	output	[9:0]	VGA_G;	 				//	VGA Green[9:0]
	output	[9:0]	VGA_B;   				//	VGA Blue[9:0]
	
	wire resetn;
	assign resetn = SW[8];
	
	//assign LEDR[3: 1] = color;
	//assign LEDR[6: 4] = go;
	reg plot;
	// Create the colour, x, y and writeEn wires that are inputs to the controller.
	
	// Create an Instance of a VGA controller - there can be only one!
	// Define the number of colours as well as the initial background
	// image file (.MIF) for the controller.
	vga_adapter VGA(
			.resetn(resetn),
			.clock(CLOCK_50),
			.colour(color),
			.x(x),
			.y(y),
			.plot(plot),
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
	
	
	always @(*) 
	begin
		if (KEY[3] == 1'b0)
			begin
			go <= 3'b001;
			plot <= 1'b0;
			end
		else if (KEY[2] == 1'b0)
			begin
			go <= 3'b010;
			plot <= 1'b0;
			end
		else if (KEY[1] == 1'b0)
			begin
			go <= 3'b011;
			plot <= 1'b0;
			end
		else if (KEY[0] == 1'b0)
			begin
			go <= 3'b100;
			plot <= 1'b0;
			end
		else
			begin
			go <= 3'b000;
			plot <= 1'b1;
			end
	end
	wire ifWin;//temp
	gameBoardPart2 g0(
		.clk(CLOCK_50),
		.resetn(resetn),
		//.initialGameBoard(64'b1110_1010_0110_1000_0101_0111_0001_0010_1101_0010_1111_1100_1011_1001_0011_0000),
		.initialGameBoard(64'b0000_1111_1110_1101_1100_1011_1010_1001_1000_0111_0110_0101_0100_0011_0010_0001),
		.go(go),
		//.initialState(6'b000110),
		.initialState(6'b010000),
		.ifWin(ifWin),
		.xOut(x),
		.yOut(y),
		.colourOut(color),
		.to(LEDR[4: 0]),
		.from(LEDR[9: 5])
		
	);
endmodule
module gameBoardPart2(
	input clk,
    input resetn,
	input [63: 0] initialGameBoard,
	input [2: 0] go,  //001 up, 010 down, 011 left, 100 right. default (no operation is 000)
	input [5: 0] initialState, // means which block is empty, e.g., 000001 means S_1 state.
	output ifWin,
	output [63: 0] blockState
	//output [7: 0] xOut,
	//output [6: 0] yOut,
	//output [2: 0] colourOut
	//output [4: 0] to,//temp
	//output [4: 0] from//temp
);

	
	wire [4: 0] moveTo, moveFrom;
	//assign to = moveTo;
	//assign from = moveFrom;
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