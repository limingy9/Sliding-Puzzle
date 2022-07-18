module blank(xIn, yIn, clk, enable, resetn, xOut, yOut);
	input [7: 0] xIn;
	input [6: 0] yIn;
	input clk, enable, resetn;
	output [7: 0] xOut;
	output [6: 0] yOut;
	
	wire [4:0]x0, y0, x1, y1, x2, y2, x3, y3, x4, y4, x5, y5, x6, y6, x7, y7;
	reg [8:0]counter;
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
				if (counter == 9'd320)
					begin
						counter <= 0;
						ld <= 3'd0;
					end
				else if (counter == 9'd40)
					begin
						ld <= 3'd1;
						counter <= counter + 1;
					end
				else if (counter == 9'd80)
					begin
						ld <= 3'd2;
						counter <= counter + 1;
					end
				else if (counter == 9'd120)
					begin
						ld <= 3'd3;
						counter <= counter + 1;
					end
				else if (counter == 9'd160)
					begin
						ld <= 3'd4;
						counter <= counter + 1;
					end
				else if (counter == 9'd200)
					begin
						ld <= 3'd5;
						counter <= counter + 1;
					end
				else if (counter == 9'd240)
					begin
						ld <= 3'd6;
						counter <= counter + 1;
					end
				else if (counter == 9'd280)
					begin
						ld <= 3'd7;
						counter <= counter + 1;
					end
				else 
					counter <= counter + 1;
			end
	end
	
	verticalLine v0(
		.x(5'd8),
		.y(5'd7),
		.distance(5'd15),
		.clk(clk),
		.enable(enable),
		.resetn(resetn),
		.xOut(x0),
		.yOut(y0)
	);
	
	verticalLine v1(
		.x(5'd11),
		.y(5'd7),
		.distance(5'd15),
		.clk(clk),
		.enable(enable),
		.resetn(resetn),
		.xOut(x1),
		.yOut(y1)
	);
	
	verticalLine v2(
		.x(5'd13),
		.y(5'd7),
		.distance(5'd15),
		.clk(clk),
		.enable(enable),
		.resetn(resetn),
		.xOut(x2),
		.yOut(y2)
	);
	
	verticalLine v3(
		.x(5'd15),
		.y(5'd7),
		.distance(5'd15),
		.clk(clk),
		.enable(enable),
		.resetn(resetn),
		.xOut(x3),
		.yOut(y3)
	);
	
	verticalLine v4(
		.x(5'd17),
		.y(5'd7),
		.distance(5'd15),
		.clk(clk),
		.enable(enable),
		.resetn(resetn),
		.xOut(x4),
		.yOut(y4)
	);
	
	verticalLine v5(
		.x(5'd19),
		.y(5'd7),
		.distance(5'd15),
		.clk(clk),
		.enable(enable),
		.resetn(resetn),
		.xOut(x5),
		.yOut(y5)
	);
	
	verticalLine v6(
		.x(5'd21),
		.y(5'd7),
		.distance(5'd15),
		.clk(clk),
		.enable(enable),
		.resetn(resetn),
		.xOut(x6),
		.yOut(y6)
	);
	
	verticalLine v7(
		.x(5'd23),
		.y(5'd7),
		.distance(5'd15),
		.clk(clk),
		.enable(enable),
		.resetn(resetn),
		.xOut(x7),
		.yOut(y7)
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
			3'd5: begin
						x = x5;
						y = y5;
					end
			3'd6: begin
						x = x6;
						y = y6;
					end
			3'd7: begin
						x = x7;
						y = y7;
					end
		endcase
	end
	
	assign xOut = xIn + x;
	assign yOut = yIn + y;
endmodule