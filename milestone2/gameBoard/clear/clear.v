module clear(clk, enable, resetn, colorOut, xOut, yOut);
	input clk, enable, resetn;
	output [2: 0] colorOut;
	output [7: 0] xOut;
	output [6: 0] yOut;
	
	reg [7:0]x;
	reg [6:0]y;
	
	always @(posedge clk)
	begin
		if (resetn == 0)
			begin
				x <= 0;
				y <= 0;
			end
		else if (enable == 1'b1)
			begin
				if (y == 7'd116 && x != 8'd116)
					begin
						y <= 0;
						x <= x + 1;
					end
				else if (y == 7'd116 && x == 8'd116)
					begin
						x <= 0;
						y <= 0;
					end
				else
					y <= y + 1;
			end
	end
	
	assign xOut = x;
	assign yOut = y;
	assign colorOut = 3'b000;
	
endmodule