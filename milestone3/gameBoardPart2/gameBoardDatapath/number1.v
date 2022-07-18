module number1(xIn, yIn, clk, enable, resetn, xOut, yOut);
	input [7: 0] xIn;
	input [6: 0] yIn;
	input clk, enable, resetn;
	output [7: 0] xOut;
	output [6: 0] yOut;
	
	wire [4:0]x, y;
	
	verticalLine v0(
		.x(5'd14),
		.y(5'd7),
		.distance(5'd15),
		.clk(clk),
		.enable(enable),
		.resetn(resetn),
		.xOut(x),
		.yOut(y)
	);
	
	assign xOut = xIn + x;
	assign yOut = yIn + y;
endmodule