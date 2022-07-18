module number7(xIn, yIn, clk, enable, resetn, xOut, yOut);
	input [7: 0] xIn;
	input [6: 0] yIn;
	input clk, enable, resetn;
	output [7: 0] xOut;
	output [6: 0] yOut;
	
	wire [4:0]x0, y0, x1, y1;
	reg [6:0]counter;
	reg [2:0]ld;
	reg [4:0]x,y;
	
	always @(posedge clk)
	begin
		if (resetn == 0)
			begin
				counter <= 0;
				ld <= 0;
			end				
		else if (enable == 1'b1)
			begin
				if (counter == 7'd50)
					begin
						counter <= 0;
						ld <= 3'd0;
					end
				else if (counter == 7'd20)
					begin
						ld <= 3'd1;
						counter <= counter + 1;
					end
				else 
					counter <= counter + 1;
			end
	end
	
	horizontalLine h0(
		.x(5'd11),
		.y(5'd7),
		.distance(5'd7),
		.clk(clk),
		.enable(enable),
		.resetn(resetn),
		.xOut(x0),
		.yOut(y0)
	);
	
	verticalLine v0(
		.x(5'd17),
		.y(5'd9),
		.distance(5'd13),
		.clk(clk),
		.enable(enable),
		.resetn(resetn),
		.xOut(x1),
		.yOut(y1)
	);
	
	always @(*)
	begin
		case (ld)
			3'd0: begin
						x = x0;
						y = y0;
					end
			3'd1: begin
						x = x1;
						y = y1;
					end
		endcase
	end
	
	assign xOut = xIn + x;
	assign yOut = yIn + y;

endmodule
