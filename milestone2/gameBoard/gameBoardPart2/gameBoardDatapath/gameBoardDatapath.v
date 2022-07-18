`include "blank.v"
`include "number1.v"
`include "number2.v"
`include "number3.v"
`include "number4.v"
`include "number5.v"
`include "number6.v"
`include "number7.v"
`include "number8.v"
`include "number9.v"
`include "number10.v"
`include "number11.v"
`include "number12.v"
`include "number13.v"
`include "number14.v"
`include "number15.v"
`include "verticalLine.v"
`include "horizontalLine.v"

module gameBoardDatapath(
	input clk,
    input resetn,
	input [4: 0] moveTo,
	input [4: 0] moveFrom,
	input [63: 0] initialGameBoard,
	//input ifJustify, // If we need to judge if the gamer wins
	output ifWin,
	output reg [63: 0] blockState // each four bit indicates what number is in which block,
	//e.g., blockState[7: 4]'s value is the second block's value
);

	//-----------------------------------------------
	wire [15: 0] bitState; 
	// i-th bit of this register is 1 iff the i-th block is on the right position,
	// e.g., bitState = 16'b0111101101111111 means that only 5 and 8 are in wrong position. 
	// bitState[0] is dont care.
	
	//reg [63: 0] blockState; 
	
	assign bitState[1] = (blockState[3: 0] == 4'b0001);
	assign bitState[2] = (blockState[7: 4] == 4'b0010);
	assign bitState[3] = (blockState[11: 8] == 4'b0011);
	assign bitState[4] = (blockState[15: 12] == 4'b0100);
	assign bitState[5] = (blockState[19: 16] == 4'b0101);
	assign bitState[6] = (blockState[23: 20] == 4'b0110);
	assign bitState[7] = (blockState[27: 24] == 4'b0111);
	assign bitState[8] = (blockState[31: 28] == 4'b1000);
	assign bitState[9] = (blockState[35: 32] == 4'b1001);
	assign bitState[10] = (blockState[39: 36] == 4'b1010);
	assign bitState[11] = (blockState[43: 40] == 4'b1011);
	assign bitState[12] = (blockState[47: 44] == 4'b1100);
	assign bitState[13] = (blockState[51: 48] == 4'b1101);
	assign bitState[14] = (blockState[55: 52] == 4'b1110);
	assign bitState[15] = (blockState[59: 56] == 4'b1111);
	//-----------------------------------------------------
	
	//reg enableDrawFSM;
	//reg interrupt;
	//--------------------------initialize the board
	always @(posedge clk)
	begin
		if (resetn == 1'b0)
			begin
				blockState = initialGameBoard;
				//enableDrawFSM = 1'b0;
				//interrupt = 1'b1;
			end
		else
			begin
				if (blockState[(moveFrom-1)*4 +: 4] != 4'b0000)
				begin
					blockState[(moveTo-1)*4 +: 4] = blockState[(moveFrom-1)*4 +: 4];
					blockState[(moveFrom-1)*4 +: 4] = 4'b0000;
				end
				//if (interrupt == 1'b1)
				//	enableDrawFSM = 1'b0;
				//else
				//	enableDrawFSM = 1'b1;
			end
	end
	//-----------------------------

	
	/*//s--------------------------------------------------------------------------------------
	reg [13: 0] counter;
	reg slowClk;
	always @(posedge clk)
	begin
		if (resetn == 1'b0)
			begin
				counter <= 14'd59999; //since we have to reset fsm
				slowClk <= 0;
			end				
		else
			begin
				if (counter == 1'b0)
					begin
						counter <= 14'd59999;
						slowClk <= ~slowClk;
					end
				else
					counter <= counter - 1;
			end
	end
	*///e--------------------------------------------------------------------------------------
	
	//-----------------------------
	assign ifWin = & (bitState[15: 1]);
	/*
	always @(posedge ifJustify)
	begin
		ifWin = 
	end
	*/
	//-----------------------------------
	/*
	wire [7: 0] drawAtX;
	wire [6: 0] drawAtY;
	wire [3: 0] drawNumber;
	wire enableDraw; 
	
	
	assign drawAtX = (slowClk == 0) ? (moveTo-1)%4*29: (moveFrom-1)%4*29;
	//first argument is moveTo, second is moveFrom
	assign drawAtY = (slowClk == 0) ? (moveTo-1)/4*29: (moveFrom-1)/4*29;
	assign drawNumber = (slowClk == 0) ? blockState[(moveTo-1)*4 +: 4]: blockState[(moveFrom-1)*4 +: 4];
	
	//wire [1: 0] current;
	
	drawAtFSM f0(
		.clk(slowClk),
		.resetn(resetn),
		.enable(enableDrawFSM),
		.moveFrom(moveFrom),
		.moveTo(moveTo),
		.numMoved(blockState[(moveTo - 1) * 4 +: 4]),
		.drawAtX(drawAtX),
		.drawAtY(drawAtY),
		.drawNumber(drawNumber),
		.enableDraw(enableDraw),
		.interrupt(interrupt),
		.current(current)
	);
	
	
	drawAt d0(
		.xIn(drawAtX),
		.yIn(drawAtY),
		.numberIn(drawNumber),
		.clk(clk),
		.enable(1'b1),
		.resetn(resetn),
		.xOut(xOut),
		.yOut(yOut),
		.colour(colourOut)
	);
	*/
	
endmodule
/*
module drawAtFSM(
    input clk,
	input resetn,
    input enable,
	input [4: 0] moveFrom,
	input [4: 0] moveTo,
	input [3: 0] numMoved, //blockState[moveTo*4-1: (moveTo-1)*4]
    output reg [7: 0] drawAtX,
	output reg [6: 0] drawAtY,
	output reg [3: 0] drawNumber,
	output reg enableDraw,
	output reg interrupt,
	output [1: 0] current
);
	
	reg [1: 0] currentState;
	reg [1: 0] nextState;
	
	assign current = currentState;
	
	localparam  DRAW_BLANK     = 2'b00,
				//DRAW_BLANK_2   = 2'b01,
				DRAW_NUMBER    = 2'b10,
				END			   = 2'b11;
				
	always @(posedge clk)
	begin
		case(currentState)
			//DRAW_BLANK_1: nextState = DRAW_BLANK_2;
			DRAW_BLANK: nextState = DRAW_NUMBER;
			DRAW_NUMBER: nextState = END;
			END: nextState = END;
		endcase
	end
	
	 // Output logic aka all of our datapath control signals
    always @(*)
    begin: enable_signals
		//this input won't change the picture
        drawAtX = 8'b00000001;
		drawAtY = 7'b0000001;
		drawNumber = 4'b0000;
		enableDraw = 1'b0;
		interrupt = 1'b0;
		case(currentState)
			DRAW_BLANK: 
				begin
					drawAtX = (moveFrom-1)%4*29;
					drawAtY = (moveFrom-1)/4*29;
					drawNumber = 4'b0000;
					enableDraw = 1'b1;
				end
			DRAW_NUMBER: 
				begin
					drawAtX = (moveTo-1)%4*29;
					drawAtY = (moveTo-1)/4*29;
					drawNumber = numMoved;
					enableDraw = 1'b1;
				end
			END: 
				begin
					enableDraw = 1'b0;
					interrupt = 1'b1;
				end
		endcase
    end // enable_signals
	
	 // current_state registers
    always @(posedge clk)
    begin: state_FFs
		if (!resetn)
			currentState = END;
        else if (enable)
			begin
				currentState = (currentState == END) ? DRAW_BLANK : nextState;
			end
        else
			begin
				currentState = END;
			end
    end // state_FFS
endmodule


module drawAt(
	input [7: 0] xIn,
	input [6: 0] yIn,
	input [3: 0] numberIn,
	input clk,
	input enable,
	input resetn,
	output reg [7: 0] xOut,
	output reg [6: 0] yOut,
	output reg [2: 0] colour
);

	wire [7: 0] xOut0, xOut1, xOut2, xOut3, xOut4, xOut5, xOut6, xOut7, xOut8;
	wire [7: 0] xOut9, xOut10, xOut11, xOut12, xOut13, xOut14, xOut15;
	wire [6: 0] yOut0, yOut1, yOut2, yOut3, yOut4, yOut5, yOut6, yOut7, yOut8;
	wire [6: 0] yOut9, yOut10, yOut11, yOut12, yOut13, yOut14, yOut15;
	
	always @(posedge clk)
	begin
		if (resetn == 1'b0)
			begin
				xOut <= 8'd1;
				yOut <= 7'd1;
				colour <= 3'b000;
			end
		else
			begin
				case(numberIn)
					4'b0000:
						begin
							colour <= 3'b000;
							xOut <= xOut0;
							yOut <= yOut0;
						end
					4'b0001:
						begin
							colour <= 3'b111;
							xOut <= xOut1;
							yOut <= yOut1;
						end
					4'b0010:
						begin
							colour <= 3'b111;
							xOut <= xOut2;
							yOut <= yOut2;
						end
					4'b0011:
						begin
							colour <= 3'b111;
							xOut <= xOut3;
							yOut <= yOut3;
						end
					4'b0100:
						begin
							colour <= 3'b111;
							xOut <= xOut4;
							yOut <= yOut4;
						end
					4'b0101:
						begin
							colour <= 3'b111;
							xOut <= xOut5;
							yOut <= yOut5;
						end
					4'b0110:
						begin
							colour <= 3'b111;
							xOut <= xOut6;
							yOut <= yOut6;
						end
					4'b0111:
						begin
							colour <= 3'b111;
							xOut <= xOut7;
							yOut <= yOut7;
						end
					4'b1000:
						begin
							colour <= 3'b111;
							xOut <= xOut8;
							yOut <= yOut8;
						end
					4'b1001:
						begin
							colour <= 3'b111;
							xOut <= xOut9;
							yOut <= yOut9;
						end
					4'b1010:
						begin
							colour <= 3'b111;
							xOut <= xOut10;
							yOut <= yOut10;
						end
					4'b1011:
						begin
							colour <= 3'b111;
							xOut <= xOut11;
							yOut <= yOut11;
						end
					4'b1100:
						begin
							colour <= 3'b111;
							xOut <= xOut12;
							yOut <= yOut12;
						end
					4'b1101:
						begin
							colour <= 3'b111;
							xOut <= xOut13;
							yOut <= yOut13;
						end		
					4'b1110:
						begin
							colour <= 3'b111;
							xOut <= xOut14;
							yOut <= yOut14;
						end
					4'b1111:
						begin
							colour <= 3'b111;
							xOut <= xOut15;
							yOut <= yOut15;
						end		
				endcase
			end
	end
	blank n0(
		.xIn(xIn),
		.yIn(yIn),
		.clk(clk), 
		.enable(enable), 
		.resetn(resetn), 
		.xOut(xOut0),
		.yOut(yOut0)
	);
	number1 n1(
		.xIn(xIn),
		.yIn(yIn),
		.clk(clk),
		.enable(enable),
		.resetn(resetn),
		.xOut(xOut1),
		.yOut(yOut1)
	);
	
	number2 n2(
		.xIn(xIn),
		.yIn(yIn),
		.clk(clk),
		.enable(enable),
		.resetn(resetn),
		.xOut(xOut2),
		.yOut(yOut2)
	);
	
	number3 n3(
		.xIn(xIn),
		.yIn(yIn),
		.clk(clk),
		.enable(enable),
		.resetn(resetn),
		.xOut(xOut3),
		.yOut(yOut3)
	);
	
	number4 n4(
		.xIn(xIn),
		.yIn(yIn),
		.clk(clk),
		.enable(enable),
		.resetn(resetn),
		.xOut(xOut4),
		.yOut(yOut4)
	);
	
	number5 n5(
		.xIn(xIn),
		.yIn(yIn),
		.clk(clk),
		.enable(enable),
		.resetn(resetn),
		.xOut(xOut5),
		.yOut(yOut5)
	);
	
	number6 n6(
		.xIn(xIn),
		.yIn(yIn),
		.clk(clk),
		.enable(enable),
		.resetn(resetn),
		.xOut(xOut6),
		.yOut(yOut6)
	);
	
	number7 n7(
		.xIn(xIn),
		.yIn(yIn),
		.clk(clk),
		.enable(enable),
		.resetn(resetn),
		.xOut(xOut7),
		.yOut(yOut7)
	);
	
	number8 n8(
		.xIn(xIn),
		.yIn(yIn),
		.clk(clk),
		.enable(enable),
		.resetn(resetn),
		.xOut(xOut8),
		.yOut(yOut8)
	);
	
	number9 n9(
		.xIn(xIn),
		.yIn(yIn),
		.clk(clk),
		.enable(enable),
		.resetn(resetn),
		.xOut(xOut9),
		.yOut(yOut9)
	);
	
	number10 n10(
		.xIn(xIn),
		.yIn(yIn),
		.clk(clk),
		.enable(enable),
		.resetn(resetn),
		.xOut(xOut10),
		.yOut(yOut10)
	);
	
	number11 n11(
		.xIn(xIn),
		.yIn(yIn),
		.clk(clk),
		.enable(enable),
		.resetn(resetn),
		.xOut(xOut11),
		.yOut(yOut11)
	);
	
	number12 n12(
		.xIn(xIn),
		.yIn(yIn),
		.clk(clk),
		.enable(enable),
		.resetn(resetn),
		.xOut(xOut12),
		.yOut(yOut12)
	);
	
	number13 n13(
		.xIn(xIn),
		.yIn(yIn),
		.clk(clk),
		.enable(enable),
		.resetn(resetn),
		.xOut(xOut13),
		.yOut(yOut13)
	);
	
	number14 n14(
		.xIn(xIn),
		.yIn(yIn),
		.clk(clk),
		.enable(enable),
		.resetn(resetn),
		.xOut(xOut14),
		.yOut(yOut14)
	);
	
	number15 n15(
		.xIn(xIn),
		.yIn(yIn),
		.clk(clk),
		.enable(enable),
		.resetn(resetn),
		.xOut(xOut15),
		.yOut(yOut15)
	);
	
	
endmodule
*/