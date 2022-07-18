module numberDrawer(numbers, clk, enable, resetn, colorOut, xOut, yOut);
	input [63:0] numbers;
	input clk, enable, resetn;
	output [2: 0] colorOut;
	output [7: 0] xOut;
	output [6: 0] yOut;
	
	reg [3:0]number;
	reg [7:0]counter;
	reg [3:0]block;
	reg [7:0]x;
	reg [6:0]y;
	wire [7:0]x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x13, x14, x15;
	wire [6:0]y1, y2, y3, y4, y5, y6, y7, y8, y9, y10, y11, y12, y13, y14, y15;
	reg [7:0]xout;
	reg [6:0]yout;
	
	
	always @(posedge clk)
	begin
		if (resetn == 0)
			begin
				counter <= 0;
				block <= 0;
				x <= 0;
				y <= 0;
				number <= numbers[3:0];
			end				
		else if (enable == 1'b1)
			begin
				if (counter == 8'd199 && block == 4'd15)
					begin
						counter <= 0;
						block <= 4'd0;
						x <= 0;
						y <= 0;
						number <= numbers[3:0];
					end						
				else if (counter == 8'd199 && block == 4'd0)
					begin
						counter <= 0;
						block <= 4'd1;
						x <= 8'd29;
						y <= 0;
						number <= numbers[7:4];
					end
				else if (counter == 8'd199 && block == 4'd1)
					begin
						counter <= 0;
						block <= 4'd2;
						x <= 8'd58;
						y <= 0;
						number <= numbers[11:8];
					end
				else if (counter == 8'd199 && block == 4'd2)
					begin
						counter <= 0;
						block <= 4'd3;
						x <= 8'd87;
						y <= 0;
						number <= numbers[15:12];
					end
				else if (counter == 8'd199 && block == 4'd3)
					begin
						counter <= 0;
						block <= 4'd4;
						x <= 8'd0;
						y <= 7'd29;
						number <= numbers[19:16];
					end
				else if (counter == 8'd199 && block == 4'd4)
					begin
						counter <= 0;
						block <= 4'd5;
						x <= 8'd29;
						number <= numbers[23:20];
					end
				else if (counter == 8'd199 && block == 4'd5)
					begin
						counter <= 0;
						block <= 4'd6;
						x <= 8'd58;
						number <= numbers[27:24];
					end
				else if (counter == 8'd199 && block == 4'd6)
					begin
						counter <= 0;
						block <= 4'd7;
						x <= 8'd87;
						number <= numbers[31:28];
					end
				else if (counter == 8'd199 && block == 4'd7)
					begin
						counter <= 0;
						block <= 4'd8;
						x <= 0;
						y <= 7'd58;
						number <= numbers[35:32];
					end
				else if (counter == 8'd199 && block == 4'd8)
					begin
						counter <= 0;
						block <= 4'd9;
						x <= 8'd29;
						number <= numbers[39:36];
					end
				else if (counter == 8'd199 && block == 4'd9)
					begin
						counter <= 0;
						block <= 4'd10;
						x <= 8'd58;
						number <= numbers[43:40];
					end
				else if (counter == 8'd199 && block == 4'd10)
					begin
						counter <= 0;
						block <= 4'd11;
						x <= 8'd87;
						number <= numbers[47:44];
					end
				else if (counter == 8'd199 && block == 4'd11)
					begin
						counter <= 0;
						block <= 4'd12;
						x <= 0;
						y <= 7'd87;
						number <= numbers[51:48];
					end
				else if (counter == 8'd199 && block == 4'd12)
					begin
						counter <= 0;
						block <= 4'd13;
						x <= 8'd29;
						number <= numbers[55:52];
					end
				else if (counter == 8'd199 && block == 4'd13)
					begin
						counter <= 0;
						block <= 4'd14;
						x <= 8'd58;
						number <= numbers[59:56];
					end
				else if (counter == 8'd199 && block == 4'd14)
					begin
						counter <= 0;
						block <= 4'd15;
						x <= 8'd87;
						number <= numbers[63:60];
					end
				else
					counter <= counter + 1;
			end
	end
	
	number1 n1(
		.xIn(x),
		.yIn(y),
		.clk(clk),
		.enable(enable),
		.resetn(resetn),
		.xOut(x1),
		.yOut(y1)
	);
	
	number2 n2(
		.xIn(x),
		.yIn(y),
		.clk(clk),
		.enable(enable),
		.resetn(resetn),
		.xOut(x2),
		.yOut(y2)
	);
	
	number3 n3(
		.xIn(x),
		.yIn(y),
		.clk(clk),
		.enable(enable),
		.resetn(resetn),
		.xOut(x3),
		.yOut(y3)
	);
	
	number4 n4(
		.xIn(x),
		.yIn(y),
		.clk(clk),
		.enable(enable),
		.resetn(resetn),
		.xOut(x4),
		.yOut(y4)
	);
	
	number5 n5(
		.xIn(x),
		.yIn(y),
		.clk(clk),
		.enable(enable),
		.resetn(resetn),
		.xOut(x5),
		.yOut(y5)
	);
	
	number6 n6(
		.xIn(x),
		.yIn(y),
		.clk(clk),
		.enable(enable),
		.resetn(resetn),
		.xOut(x6),
		.yOut(y6)
	);
	
	number7 n7(
		.xIn(x),
		.yIn(y),
		.clk(clk),
		.enable(enable),
		.resetn(resetn),
		.xOut(x7),
		.yOut(y7)
	);
	
	number8 n8(
		.xIn(x),
		.yIn(y),
		.clk(clk),
		.enable(enable),
		.resetn(resetn),
		.xOut(x8),
		.yOut(y8)
	);
	
	number9 n9(
		.xIn(x),
		.yIn(y),
		.clk(clk),
		.enable(enable),
		.resetn(resetn),
		.xOut(x9),
		.yOut(y9)
	);
	
	number10 n10(
		.xIn(x),
		.yIn(y),
		.clk(clk),
		.enable(enable),
		.resetn(resetn),
		.xOut(x10),
		.yOut(y10)
	);
	
	number11 n11(
		.xIn(x),
		.yIn(y),
		.clk(clk),
		.enable(enable),
		.resetn(resetn),
		.xOut(x11),
		.yOut(y11)
	);
	
	number12 n12(
		.xIn(x),
		.yIn(y),
		.clk(clk),
		.enable(enable),
		.resetn(resetn),
		.xOut(x12),
		.yOut(y12)
	);
	
	number13 n13(
		.xIn(x),
		.yIn(y),
		.clk(clk),
		.enable(enable),
		.resetn(resetn),
		.xOut(x13),
		.yOut(y13)
	);
	
	number14 n14(
		.xIn(x),
		.yIn(y),
		.clk(clk),
		.enable(enable),
		.resetn(resetn),
		.xOut(x14),
		.yOut(y14)
	);
	
	number15 n15(
		.xIn(x),
		.yIn(y),
		.clk(clk),
		.enable(enable),
		.resetn(resetn),
		.xOut(x15),
		.yOut(y15)
	);
	
	always @(*)
	begin
		case (number)
			4'd1: begin
						xout = x1;
						yout = y1;
					end
			4'd2: begin
						xout = x2;
						yout = y2;
					end
			4'd3: begin
						xout = x3;
						yout = y3;
					end
			4'd4: begin
						xout = x4;
						yout = y4;
					end
			4'd5: begin
						xout = x5;
						yout = y5;
					end
			4'd6: begin
						xout = x6;
						yout = y6;
					end
			4'd7: begin
						xout = x7;
						yout = y7;
					end
			4'd8: begin
						xout = x8;
						yout = y8;
					end
			4'd9: begin
						xout = x9;
						yout = y9;
					end
			4'd10: begin
						xout = x10;
						yout = y10;
					end
			4'd11: begin
						xout = x11;
						yout = y11;
					end
			4'd12: begin
						xout = x12;
						yout = y12;
					end
			4'd13: begin
						xout = x13;
						yout = y13;
					end
			4'd14: begin
						xout = x14;
						yout = y14;
					end
			4'd15: begin
						xout = x15;
						yout = y15;
					end
			default: begin
						xout = 0;
						yout = 0;
					end
		endcase
	end
	
	assign xOut = xout;
	assign yOut = yout;
	assign colorOut = 3'b111;
endmodule