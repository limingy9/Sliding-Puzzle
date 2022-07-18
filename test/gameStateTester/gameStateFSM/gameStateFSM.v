module gameStateFSM(
    input clk,
    input resetn,
    input [2: 0] go,
	input win, lose,
	output reg drawGrid, drawEZ, drawNORMAL, drawHARD, inGame, drawNum, gameOver, clear
);
	 
	reg [3: 0] current_state, next_state;
	reg [7:0] counter;
	reg [3:0] slc; // slower counter
	reg [2:0] stc; // slowest counter
	reg [6:0] flag;

    
    localparam DRAW_GRID_WAIT = 4'd0,
					DRAW_GRID = 4'd1,
					SELECT = 4'd2,
					DRAW_EZ_WAIT = 4'd3,
					DRAW_EZ = 4'd4,
					DRAW_NORMAL_WAIT = 4'd5,
					DRAW_NORMAL = 4'd6,
					DRAW_HARD_WAIT = 4'd7,
					DRAW_HARD = 4'd8,
					GAME_START = 4'd9,
					IN_GAME = 4'd10,
					DRAW_NUM_WAIT = 4'd11,
					DRAW_NUM = 4'd12,
					GAME_OVER = 4'd13,
					CLEAR_WAIT = 4'd14,
					CLEAR = 4'd15;
					
	always @(posedge clk)
	begin
		if (resetn == 0 || flag != {drawGrid, drawEZ, drawNORMAL, drawHARD, inGame, drawNum, clear})
			begin
				counter <= 0;
				slc <= 0;
				stc <= 0;
				flag <= {drawGrid, drawEZ, drawNORMAL, drawHARD, inGame, drawNum, clear};
			end
		else
			begin
				if (counter == 8'd200 && slc != 4'd15)
					begin
						counter <= 0;
						slc <= slc + 1;
					end
				else if (counter == 8'd200 && slc == 4'd15)
					begin
						counter <= 0;
						slc <= 0;
						stc <= stc + 1;
					end
				else
					begin
						counter <= counter + 1;
					end
			end
	end
	
	always@(*)
   begin
		case (current_state)
			DRAW_GRID_WAIT: next_state = DRAW_GRID;
			DRAW_GRID:
				begin
					if (slc == 4'd15 && inGame == 0)
						next_state = SELECT;
					else if (slc == 4'd15 && inGame == 1)
						next_state = DRAW_NUM_WAIT;
					else
						next_state = DRAW_GRID;
				end
			SELECT:
				begin
					if (go == 3'b001)
						begin
							next_state = DRAW_EZ_WAIT;
						end
					else if (go == 3'b010)
						begin
							next_state = DRAW_NORMAL_WAIT;
						end
					else if (go == 3'b100)
						begin
							next_state = DRAW_HARD_WAIT;
						end
					else
						next_state = SELECT;						
				end
			DRAW_EZ_WAIT: next_state = DRAW_EZ;
			DRAW_EZ:
				begin
					if (slc == 4'd15)
						next_state = GAME_START;
					else
						next_state = DRAW_EZ;
				end
			DRAW_NORMAL_WAIT: next_state = DRAW_NORMAL;
			DRAW_NORMAL:
				begin
					if (slc == 4'd15)
						next_state = GAME_START;
					else
						next_state = DRAW_NORMAL;
				end
			DRAW_HARD_WAIT: next_state = DRAW_HARD;
			DRAW_HARD:
				begin
					if (slc == 4'd15)
						next_state = GAME_START;
					else
						next_state = DRAW_HARD;
				end
			GAME_START:
				begin
					if (go == 3'b000)
						next_state = IN_GAME;
					else
						next_state = GAME_START;
				end
			IN_GAME: 
				begin
					if (win == 1 || lose == 1)
						next_state = GAME_OVER;
					else if (go != 3'b000)
						next_state = CLEAR_WAIT;
					else
						next_state = IN_GAME;
				end
			DRAW_NUM_WAIT: next_state = DRAW_NUM;
			DRAW_NUM:
				begin
					if (slc == 4'd15 && go == 3'b000)
						next_state = IN_GAME;
					else
						next_state = DRAW_NUM;
				end
					
			GAME_OVER:
				begin
					if (go != 3'b000)
						begin
							next_state = CLEAR_WAIT;
						end
					else
						next_state = GAME_OVER;
				end
			CLEAR_WAIT: next_state = CLEAR;
			CLEAR:
				begin
					if (stc == 3'd5)
						begin
							next_state = DRAW_GRID_WAIT;
						end
					else
						next_state = CLEAR;
				end
		endcase
	end
	
	always@(posedge clk)
		begin
			if(!resetn)
				current_state <= CLEAR;
			else
				current_state <= next_state;
		end
	
	always @(*)
		begin
			if (resetn == 0)
				begin
					drawGrid = 1'b0;
					drawEZ = 1'b0;
					drawNORMAL = 1'b0;
					drawHARD = 1'b0;
					inGame = 1'b0;
					drawNum = 1'b0;
					clear = 1'b0;
				end
			else
				begin
					case (current_state)
						DRAW_GRID_WAIT:
							begin
								clear = 1'b0;
								drawGrid = 1'b1;
							end
						SELECT:
							begin
								drawGrid = 1'b0;
							end
						DRAW_EZ_WAIT:
							begin
								drawEZ = 1'b1;
							end
						DRAW_NORMAL_WAIT:
							begin
								drawNORMAL = 1'b1;
							end
						DRAW_HARD_WAIT:
							begin
								drawHARD = 1'b1;
							end
						GAME_START:
							begin
								drawEZ = 1'b0;
								drawNORMAL = 1'b0;
								drawHARD = 1'b0;
							end
						IN_GAME:
							begin
								inGame = 1'b1;
							end
						DRAW_NUM_WAIT:
							begin
								drawGrid = 1'b0;
								drawNum = 1'b1;
							end
						GAME_OVER:
							begin
								inGame = 1'b0;
							end
						CLEAR_WAIT:
							begin
								drawNum = 1'b0;
								clear = 1'b1;
							end
				endcase
			end
		end
endmodule