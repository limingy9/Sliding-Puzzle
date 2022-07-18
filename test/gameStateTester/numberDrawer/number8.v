module number8(xIn, yIn, clk, enable, resetn, xOut, yOut);
	input [7: 0] xIn;
	input [6: 0] yIn;
	input clk, enable, resetn;
	output [7: 0] xOut;
	output [6: 0] yOut;
	
	wire [4:0]x0, y0, x1, y1, x2, y2, x3, y3, x4, y4;
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
				if (counter == 7'd120)
					begin
						counter <= 0;
						ld <= 3'd0;
					end
				else if (counter == 7'd20)
					begin
						ld <= 3'd1;
						counter <= counter + 1;
					end
				else if (counter == 7'd40)
					begin
						ld <= 3'd2;
						counter <= counter + 1;
					end
				else if (counter == 7'd60)
					begin
						ld <= 3'd3;
						counter <= counter + 1;
					end
				else if (counter == 7'd90)
					begin
						ld <= 3'd4;
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
	
	horizontalLine h1(
		.x(5'd11),
		.y(5'd14),
		.distance(5'd7),
		.clk(clk),
		.enable(enable),
		.resetn(resetn),
		.xOut(x1),
		.yOut(y1)
	);
	
	horizontalLine h2(
		.x(5'd11),
		.y(5'd21),
		.distance(5'd7),
		.clk(clk),
		.enable(enable),
		.resetn(resetn),
		.xOut(x2),
		.yOut(y2)
	);
	
	verticalLine v0(
		.x(5'd11),
		.y(5'd9),
		.distance(5'd11),
		.clk(clk),
		.enable(enable),
		.resetn(resetn),
		.xOut(x3),
		.yOut(y3)
	);
	
	verticalLine v1(
		.x(5'd17),
		.y(5'd9),
		.distance(5'd11),
		.clk(clk),
		.enable(enable),
		.resetn(resetn),
		.xOut(x4),
		.yOut(y4)
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
			3'd2: begin
						x = x2;
						y = y2;
					end
			3'd3: begin
						x = x3;
						y = y3;
					end
			3'd4: begin
						x = x4;
						y = y4;
					end
		endcase
	end
	
	assign xOut = xIn + x;
	assign yOut = yIn + y;

endmodule