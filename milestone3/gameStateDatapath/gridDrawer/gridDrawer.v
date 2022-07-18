module gridDrawer(clk, enable, resetn, colorOut, xOut, yOut);
	input clk, enable, resetn;
	output [2: 0] colorOut;
	output [7: 0] xOut;
	output [6: 0] yOut;
	
	//wire enableHorizontal, enableVertical;
	
	wire [7: 0] horizontalXOut, verticalXOut;
	wire [6: 0] horizontalYOut, verticalYOut;
	
	wire [6: 0] pixelCount;
	reg slowerClk;
	
	
	horizontalGridDrawer d0(
		.clk(clk),
		.enable(enable),
		.resetn(resetn),
		.xOut(horizontalXOut),
		.yOut(horizontalYOut)
	);
	
	verticalGridDrawer d1(
		.clk(clk),
		.enable(enable),
		.resetn(resetn),
		.xOut(verticalXOut),
		.yOut(verticalYOut)
	);
	
	linePixelCounter c0(
		.clk(clk),
		.enable(enable),
		.resetn(resetn),
		.load(7'b1111111), // give it enough time to draw
		.out(pixelCount)
	);
	
	always @(posedge clk)
	begin
		if (resetn == 1'b0)
			slowerClk <= 1'b0;
		else if (pixelCount == 0)
			slowerClk <= ~slowerClk;
	end
			
	assign xOut = (slowerClk == 0)? horizontalXOut : verticalXOut;
	assign yOut = (slowerClk == 0)? horizontalYOut : verticalYOut;	
	
	assign colorOut = 3'b111;
endmodule

module horizontalGridDrawer(clk, enable, resetn, xOut, yOut);
	input clk, enable, resetn;
	output [7: 0] xOut;
	output [6: 0] yOut;
	
	wire [6: 0] x;
	reg [6: 0] y;

	always @(posedge clk)
	begin
		if (resetn == 0)
				y <= 0;
		else if (enable == 1'b1)
			begin
				if (y == 7'd116)
					y <= 0;
				else 
					y <= y + 5'd29;
			end
	end
	
	linePixelCounter c0(
		.clk(clk),
		.enable(enable),
		.resetn(resetn),
		.load(7'b1110100), // which is 116 in decimal
		.out(x)
	);
	
	assign xOut = {1'b0, x};
	assign yOut = y;
				
endmodule


module verticalGridDrawer(clk, enable, resetn, xOut, yOut);
	input clk, enable, resetn;
	output [7: 0] xOut;
	output [6: 0] yOut;
	
	reg [7: 0] x;
	wire [6: 0] y;
	
	always @(posedge clk)
	begin
		if (resetn == 0)
			begin
				x <= 0;
			end	
		else if (enable == 1'b1)
			begin
				if (x == 7'd116)
					x <= 0;
				else 
					x <= x + 5'd29;
			end
	end
	
	linePixelCounter c0(
		.clk(clk),
		.enable(enable),
		.resetn(resetn),
		.load(7'b1110100), // which is 116 in decimal
		.out(y)
	);
	
	assign xOut = x;
	assign yOut = y;
				
endmodule

module linePixelCounter(clk, enable, resetn, load, out);
	input clk, enable, resetn;
	input [6: 0] load;
	reg [6: 0] cnt;
	output [6: 0] out;
	
	always @(posedge clk)
	begin 
		if (resetn == 0 || cnt >= load) 
			cnt <= 0;
		else if (enable == 1'b1)
			cnt <= cnt + 1;
	end
	assign out = cnt;
endmodule
	