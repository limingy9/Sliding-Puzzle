module gameStateDatapath(
	input clk, resetn,
	input drawGrid, drawEZ, drawNORMAL, drawHARD, drawNum, clear,
	input [63:0]numbers,
	output [2:0] colorOut,
	output [7:0] xOut,
	output [6:0] yOut
	);
	
	reg [2:0] color;
	wire [2:0] gridColor, ezColor, normalColor, hardColor, numColor, clearColor;
	
	reg [7:0] x;
	reg [6:0] y;
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
		.numbers(64'b0000_1111_1110_1101_1100_1011_1010_1001_1000_0111_0110_0101_0100_0011_0010_0001),
		.clk(clk),
		.enable(drawEZ),
		.resetn(resetn),
		.colorOut(ezColor),
		.xOut(ezXOut),
		.yOut(ezYOut)
	);
	
	numberDrawer d1(
		.numbers(64'b0000_0001_0010_0011_0100_0101_0110_0111_1000_1001_1010_1011_1100_1101_1110_1111),
		.clk(clk),
		.enable(drawNORMAL),
		.resetn(resetn),
		.colorOut(normalColor),
		.xOut(normalXOut),
		.yOut(normalYOut)
	);
	
	numberDrawer d2(
		.numbers(64'b0000_0101_0010_1011_0100_0001_0110_0011_1000_1001_1010_0111_1100_1101_1110_1111),
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
		if (drawGrid == 1'b1)
			begin
				x = gridXOut;
				y = gridYOut;
				color = gridColor;
			end
		else if (drawEZ == 1'b1)
			begin
				x = ezXOut;
				y = ezYOut;
				color = ezColor;
			end
		else if (drawNORMAL == 1'b1)
			begin
				x = normalXOut;
				y = normalYOut;
				color = normalColor;
			end
		else if (drawHARD == 1'b1)
			begin
				x = hardXOut;
				y = hardYOut;
				color = hardColor;
			end
		else if (drawNum == 1'b1)
			begin
				x = numXOut;
				y = numYOut;
				color = numColor;
			end
		else if (clear == 1'b1)
			begin
				x = clearXOut;
				y = clearYOut;
				color = clearColor;
			end
	end
	
	assign colorOut = color;
	assign xOut = x;
	assign yOut = y;
	
endmodule