module movementCounter(resetn, go, enable, countOut);
	input resetn, enable;
	input [2: 0] go;
	output reg [11: 0] countOut;
	
	always @(posedge go)
	begin
		if (resetn == 1'b0 || countOut == 12'b111111111111)
			countOut <= 0;
		else if (enable == 1)
			countOut <= countOut + 1;
	end
endmodule
			