module countDown(clk, resetn, enable, minuteIn, secondIn, minuteOut, secondOut);
	input resetn, clk, enable;
	input [3: 0] minuteIn;
	input [5: 0] secondIn;
	output reg [3: 0] minuteOut; // from 0 to 9
	output reg [5: 0] secondOut; // from 0 to 59. 59 = 6'b111011
	
	wire secondClk; // the cycle is 1, instead of 50000000
	
	rateDivider r0(
		.load(26'd49999999),
		.enable(enable),
		.clk(clk),
		.resetn(resetn),
		.out(secondClk)
	);
	
	always @(clk)
	begin
		if (resetn == 1'b0)
			begin
				minuteOut <= minuteIn;
				secondOut <= minuteOut;
			end
		else if (enable == 1'b1 && secondClk == 1'b1)
			begin
				if (secondOut > 0)
					secondOut <= secondOut - 1;
				else if (secondOut == 0 && minuteOut > 0)
					begin
						secondOut <= 6'd59;
						minuteOut <= minuteOut - 1;
					end
			end
	end
	
endmodule
	
module rateDivider(load, enable, clk, resetn, out);
	input enable, clk, resetn;
	input [25: 0] load;
	output out;
	
	reg [25: 0] cnt;
	
	
	always @(posedge clk)
	begin
		if (resetn == 1'b0)
			cnt <= load;
		else if (enable == 1'b1)
			begin
				if (cnt == 0)
					cnt <= load;
				else
					cnt <= cnt - 1;
			end
	end
	assign out = (cnt == 0)? 1: 0;
endmodule
	