module movementCounter(resetn, clk, enable, countOut);
	input resetn, clk, enable;
	output reg [11: 0] countOut;
	
	always @(posedge clk)
	begin
		if (resetn == 1'b0 || countOut == 12'b111111111111)
			countOut <= 0;
		else if (enable == 1)
			countOut <= countOut + 1;
	end
endmodule
			