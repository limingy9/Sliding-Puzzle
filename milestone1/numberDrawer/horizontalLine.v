module horizontalLine(x, y, distance, clk, enable, resetn, xOut, yOut);
	input [4:0] x, y, distance;
	input clk, enable, resetn;
	output [4:0] xOut, yOut;
	
	reg ycounter;
	reg [4:0] xcounter;
	
	always @(posedge clk)
	begin
		if (resetn == 0)
			begin
				xcounter <= 0;
				ycounter <= 0;
			end	
		else if (enable == 1'b1)
			begin
				if (xcounter == distance)
					begin
						xcounter <= 0;
						ycounter <= ycounter + 1;
					end
				else 
					xcounter <= xcounter + 1;
			end
	end
	
	assign xOut = x + xcounter;
	assign yOut = y + ycounter;
endmodule 