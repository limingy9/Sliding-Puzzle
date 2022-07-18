module gameStateDatapath(
	input clk, resetn,
	input drawGrid, drawEZ, drawNORMAL, drawHARD, drawNum, clear,
	input [63:0] numbers,
	output reg [2:0] colorOut,
	output reg [7:0] xOut,
	output reg [6:0] yOut,
	output reg [63: 0] initialGameBoard,
	output reg [5: 0] initialState,
	output reg [3: 0] minuteGiven;
	output reg [5: 0] secondGiven;
	);
	

	wire [2:0] gridColor, ezColor, normalColor, hardColor, numColor, clearColor;
	wire [7: 0] gridXOut, ezXOut, normalXOut, hardXOut, numXOut, clearXOut;
	wire [6: 0] gridYOut, ezYOut, normalYOut, hardYOut, numYOut, clearYOut;
	
	gridDrawer g0(
		.clk(clk),
		.enable(drawGrid),
		.resetn(resetn),
		.colorOut(gridColor),
		.xOut(gridXOut),
		.yOut(gridYOut)
	);
	 
	numberDrawer d0(
		.numbers(64'b0000_1110_1101_1111_1100_1011_1010_1001_1000_0111_0110_0101_0100_0011_0010_0001),
		.clk(clk),
		.enable(drawEZ),
		.resetn(resetn),
		.colorOut(ezColor),
		.xOut(ezXOut),
		.yOut(ezYOut)
	);
	
	numberDrawer d1(
		.numbers(64'b0000_1011_1110_1101_1111_0111_1010_1001_1100_0110_0101_0001_1000_0100_0011_0010),
		.clk(clk),
		.enable(drawNORMAL),
		.resetn(resetn),
		.colorOut(normalColor),
		.xOut(normalXOut),
		.yOut(normalYOut)
	);
	
	numberDrawer d2(
		.numbers(64'b0000_0101_1010_1110_1111_0010_0011_1101_0100_1100_1000_0110_1001_0111_1011_0001),
		.clk(clk),
		.enable(drawHARD),
		.resetn(resetn),
		.colorOut(hardColor),
		.xOut(hardXOut),
		.yOut(hardYOut)
	);
	
	numberDrawer d3(
		.numbers(numbers),
		.clk(clk),
		.enable(drawNum),
		.resetn(resetn),
		.colorOut(numColor),
		.xOut(numXOut),
		.yOut(numYOut)
	);
	
	clear c0(
		.clk(clk),
		.enable(clear),
		.resetn(resetn),
		.colorOut(clearColor),
		.xOut(clearXOut),
		.yOut(clearYOut)
	);
		
	
	always@(*)
	begin
		if (resetn == 0)
			begin
				xOut = 8'd0;
				yOut = 7'd0;
				colorOut = 3'd0;
				initialGameBoard = 64'd0;
				initialState = 6'd0;
				secondGiven = 6'd0;
				minuteGiven = 4'd0;
			end
				
		else if (drawGrid == 1'b1)
			begin
				xOut = gridXOut;
				yOut = gridYOut;
				colorOut = gridColor;
			end
		else if (drawEZ == 1'b1)
			begin
				xOut = ezXOut;
				yOut = ezYOut;
				colorOut = ezColor;
				initialGameBoard = 64'b0000_1110_1101_1111_1100_1011_1010_1001_1000_0111_0110_0101_0100_0011_0010_0001;
				initialState = 6'b010000;
				secondGiven = 6'b111011;
				minuteGiven = 4'b1001;
			end
		else if (drawNORMAL == 1'b1)
			begin
				xOut = normalXOut;
				yOut = normalYOut;
				colorOut = normalColor;
				initialGameBoard = 64'b0000_1011_1110_1101_1111_0111_1010_1001_1100_0110_0101_0001_1000_0100_0011_0010;
				initialState = 6'b010000;
				secondGiven = 6'b111011;
				minuteGiven = 4'b0101;
			end
		else if (drawHARD == 1'b1)
			begin
				xOut = hardXOut;
				yOut = hardYOut;
				colorOut = hardColor;
				initialGameBoard = 64'b0000_0101_1010_1110_1111_0010_0011_1101_0100_1100_1000_0110_1001_0111_1011_0001;
				initialState = 6'b010000;
				secondGiven = 6'b111011;
				minuteGiven = 4'b0010;
			end
		else if (drawNum == 1'b1)
			begin
				xOut = numXOut;
				yOut = numYOut;
				colorOut = numColor;
			end
		else if (clear == 1'b1)
			begin
				xOut = clearXOut;
				yOut = clearYOut;
				colorOut = clearColor;
			end
		else
			begin
				xOut = 8'd0;
				yOut = 7'd0;
				colorOut = 3'b111;
			end
	end
endmodule