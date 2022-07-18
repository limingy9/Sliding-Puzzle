module gameBoardFSM(
    input clk,
    input resetn,
    input [2: 0] go,  //001 up, 010 down, 011 left, 100 right. default (no operation is 000)
	input [5: 0] initialState, // means which block is empty, e.g., 000001 means S_1 state.
    output reg [4: 0] moveTo,
	output reg [4: 0] moveFrom
	//output reg ifJustify // If we need to judge if the gamer wins
    );

	
    reg [5: 0] current_state, next_state, last_state, last_last_state; 
	
    
    localparam  S_1        	= 6'd1,
                S_2        	= 6'd2,
				S_3        	= 6'd3,
				S_4        	= 6'd4,
				S_5        	= 6'd5,
				S_6        	= 6'd6,
				S_7        	= 6'd7,
				S_8        	= 6'd8,
				S_9        	= 6'd9,
				S_10        = 6'd10,
				S_11        = 6'd11,
				S_12        = 6'd12,
				S_13        = 6'd13,
				S_14        = 6'd14,
				S_15        = 6'd15,
				S_16        = 6'd16, //010000
				S_1_WAIT   	= 6'd17,
                S_2_WAIT   	= 6'd18,
                S_3_WAIT   	= 6'd19,
                S_4_WAIT   	= 6'd20,
                S_5_WAIT   	= 6'd21,
				S_6_WAIT   	= 6'd22,
				S_7_WAIT   	= 6'd23,
				S_8_WAIT   	= 6'd24, 
				S_9_WAIT   	= 6'd25, 
				S_10_WAIT   = 6'd26, 
				S_11_WAIT   = 6'd27, 
				S_12_WAIT   = 6'd28, 
				S_13_WAIT   = 6'd29, 
				S_14_WAIT   = 6'd30, 
				S_15_WAIT   = 6'd31, 
				S_16_WAIT   = 6'd32, //100000
				UP			= 3'b001,
				DOWN		= 3'b010,
				LEFT		= 3'b011,
				RIGHT		= 3'b100;
				
    
    // Next state logic aka our state table
    always@(posedge clk)
    begin: state_table 
            case (current_state)
                S_1:begin
						//last_state = S_1;
						if (go == UP)
							next_state = S_5_WAIT;
						else if (go == DOWN)
							next_state = S_1_WAIT;
						else if (go == LEFT)
							next_state = S_2_WAIT;
						else if (go == RIGHT)
							next_state = S_1_WAIT;
						//else
						//	next_state = S_1_WAIT;
					end
                S_1_WAIT: next_state = (go != 3'b000) ? S_1_WAIT : S_1; 
                S_2:begin
						//last_state = S_2;
						if (go == UP)
							next_state = S_6_WAIT;
						else if (go == DOWN)
							next_state = S_2_WAIT;
						else if (go == LEFT)
							next_state = S_3_WAIT;
						else if (go == RIGHT)
							next_state = S_1_WAIT;
						//else
						//	next_state = S_2_WAIT;
					end
                S_2_WAIT: next_state = (go != 3'b000) ? S_2_WAIT : S_2; 
                S_3:begin
						//last_state = S_3;
						if (go == UP)
							next_state = S_7_WAIT;
						else if (go == DOWN)
							next_state = S_3_WAIT;
						else if (go == LEFT)
							next_state = S_4_WAIT;
						else if (go == RIGHT)
							next_state = S_2_WAIT;
						//else
						//	next_state = S_3_WAIT;
					end
                S_3_WAIT: next_state = (go != 3'b000) ? S_3_WAIT : S_3; 
                S_4:begin
						//last_state = S_4;
						if (go == UP)
							next_state = S_8_WAIT;
						else if (go == DOWN)
							next_state = S_4_WAIT;
						else if (go == LEFT)
							next_state = S_4_WAIT;
						else if (go == RIGHT)
							next_state = S_3_WAIT;
						//else
						//	next_state = S_4_WAIT;
					end
                S_4_WAIT: next_state = (go != 3'b000) ? S_4_WAIT : S_4; 
				S_5:begin
						//last_state = S_5;
						if (go == UP)
							next_state = S_9_WAIT;
						else if (go == DOWN)
							next_state = S_1_WAIT;
						else if (go == LEFT)
							next_state = S_6_WAIT;
						else if (go == RIGHT)
							next_state = S_5_WAIT;
						//else
						//	next_state = S_5_WAIT;
					end
				S_5_WAIT: next_state = (go != 3'b000) ? S_5_WAIT : S_5; 
				S_6:begin
						//last_state = S_6;
						if (go == UP)
							next_state = S_10_WAIT;
						else if (go == DOWN)
							next_state = S_2_WAIT;
						else if (go == LEFT)
							next_state = S_7_WAIT;
						else if (go == RIGHT)
							next_state = S_5_WAIT;
						//else
						//	next_state = S_6_WAIT;
					end
				S_6_WAIT: next_state = (go != 3'b000) ? S_6_WAIT : S_6; 
				S_7:begin
						//last_state = S_7;
						if (go == UP)
							next_state = S_11_WAIT;
						else if (go == DOWN)
							next_state = S_3_WAIT;
						else if (go == LEFT)
							next_state = S_8_WAIT;
						else if (go == RIGHT)
							next_state = S_6_WAIT;
						//else
						//	next_state = S_7_WAIT;
					end
				S_7_WAIT: next_state = (go != 3'b000) ? S_7_WAIT : S_7; 
				S_8:begin
						//last_state = S_8;
						if (go == UP)
							next_state = S_12_WAIT;
						else if (go == DOWN)
							next_state = S_4_WAIT;
						else if (go == LEFT)
							next_state = S_8_WAIT;
						else if (go == RIGHT)
							next_state = S_7_WAIT;
						//else
						//	next_state = S_8_WAIT;
					end
				S_8_WAIT: next_state = (go != 3'b000) ? S_8_WAIT : S_8; 
				S_9:begin
						//last_state = S_9;
						if (go == UP)
							next_state = S_13_WAIT;
						else if (go == DOWN)
							next_state = S_5_WAIT;
						else if (go == LEFT)
							next_state = S_10_WAIT;
						else if (go == RIGHT)
							next_state = S_9_WAIT;
						//else
						//	next_state = S_9_WAIT;
					end
				S_9_WAIT: next_state = (go != 3'b000) ? S_9_WAIT : S_9; 
				S_10:begin
						//last_state = S_10;
						if (go == UP)
							next_state = S_14_WAIT;
						else if (go == DOWN)
							next_state = S_6_WAIT;
						else if (go == LEFT)
							next_state = S_11_WAIT;
						else if (go == RIGHT)
							next_state = S_9_WAIT;
						//else
						//	next_state = S_10_WAIT;
					end
				S_10_WAIT: next_state = (go != 3'b000) ? S_10_WAIT : S_10; 
				S_11:begin
						//last_state = S_11;
						if (go == UP)
							next_state = S_15_WAIT;
						else if (go == DOWN)
							next_state = S_7_WAIT;
						else if (go == LEFT)
							next_state = S_12_WAIT;
						else if (go == RIGHT)
							next_state = S_10_WAIT;
						//else
						//	next_state = S_11_WAIT;
					end
				S_11_WAIT: next_state = (go != 3'b000) ? S_11_WAIT : S_11; 
				S_12:begin
						//last_state = S_12;
						if (go == UP)
							next_state = S_16_WAIT;
						else if (go == DOWN)
							next_state = S_8_WAIT;
						else if (go == LEFT)
							next_state = S_12_WAIT;
						else if (go == RIGHT)
							next_state = S_11_WAIT;
						//else
						//	next_state = S_12_WAIT;
					end
				S_12_WAIT: next_state = (go != 3'b000) ? S_12_WAIT : S_12;
				S_13:begin
						//last_state = S_13;
						if (go == UP)
							next_state = S_13_WAIT;
						else if (go == DOWN)
							next_state = S_9_WAIT;
						else if (go == LEFT)
							next_state = S_14_WAIT;
						else if (go == RIGHT)
							next_state = S_13_WAIT;
						//else
						//	next_state = S_13_WAIT;
					end				
				S_13_WAIT: next_state = (go != 3'b000) ? S_13_WAIT : S_13; 
				S_14:begin
						//last_state = S_14;
						if (go == UP)
							next_state = S_14_WAIT;
						else if (go == DOWN)
							next_state = S_10_WAIT;
						else if (go == LEFT)
							next_state = S_15_WAIT;
						else if (go == RIGHT)
							next_state = S_13_WAIT;
						//else
						//	next_state = S_14_WAIT;
					end
				S_14_WAIT: next_state = (go != 3'b000) ? S_14_WAIT : S_14; 
				S_15:begin
						//last_state = S_15;
						if (go == UP)
							next_state = S_15_WAIT;
						else if (go == DOWN)
							next_state = S_11_WAIT;
						else if (go == LEFT)
							next_state = S_16_WAIT;
						else if (go == RIGHT)
							next_state = S_14_WAIT;
						//else
						//	next_state = S_15_WAIT;
					end
				S_15_WAIT: next_state = (go != 3'b000) ? S_15_WAIT : S_15; 
				S_16:begin
						//last_state = S_16;
						if (go == UP)
							next_state = S_16_WAIT;
						else if (go == DOWN)
							next_state = S_12_WAIT;
						else if (go == LEFT)
							next_state = S_16_WAIT;
						else if (go == RIGHT)
							next_state = S_15_WAIT;
						//else
						//	next_state = S_16_WAIT;
					end
				S_16_WAIT: next_state = (go != 3'b000) ? S_16_WAIT : S_16; 
				default: next_state = initialState;
        endcase
    end // state_table
   

    // Output logic aka all of our datapath control signals
    always @(*)
    begin: enable_signals
        // By default make all our signals 0
      //  moveTo = 5'b00000;
		//moveFrom = 5'b00000;
		//ifJustify = 1'b0;
		//if (last_state[5] != 1'b1)
			moveTo = last_last_state[4: 0];      //the id of the block which we need to move to   
		//if (current_state[5] != 1'b1)
			moveFrom = current_state[4: 0];		// the id of the block which we move
		//if (current_state == S_16)
			//ifJustify = 1'b1;
    end // enable_signals
   
    // current_state registers
    always @(posedge clk)
    begin: state_FFs
        if(!resetn)
			begin
				current_state = initialState;
				last_state = initialState;
				last_last_state = initialState;
			end
        else
			begin
				if (current_state != next_state)
					begin
						last_state <= current_state;
						last_last_state <= last_state;
					end
				else
					last_state <= last_state;
				
				current_state <= next_state;
			end
    end // state_FFS
	
endmodule