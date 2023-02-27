module F_word_set(          //频率选择
	input				sys_clk,
	input				sys_rst_n	,
	input        [2:0]    key1_in	,
	output	reg	[16:0]	f_word	
	);
	
	wire		key_flag	;
	reg	[3:0]	cnt			;
    key_filter key_filter_inst(
    .sys_clk  (sys_clk),
    .sys_rst_n(sys_rst_n),
    .key_in   (key1_in),
    .key_flag (key_flag)
    );
	
	always@(posedge sys_clk or negedge sys_rst_n) begin
        if(!sys_rst_n) begin
			cnt <= 4'd0;
            end
		else if (key_flag) begin
			if (cnt==4'd9) begin
				cnt <= 4'd0;
			end
			else begin
				cnt <= cnt + 1'b1;
			end
		end
	end
	always @(posedge sys_clk or negedge sys_rst_n) begin
		if (!sys_rst_n) begin
			f_word <= 0;
		end
		else begin
			case(cnt)
				4'd0:f_word = 17'd8590 ;
				4'd1:f_word = 17'd17180;
				4'd2:f_word = 17'd25770;
				4'd3:f_word = 17'd34360;
				4'd4:f_word = 17'd42950;
				4'd5:f_word = 17'd51540;
				4'd6:f_word = 17'd60130;
				4'd7:f_word = 17'd68720;
				4'd8:f_word = 17'd77310;
				4'd9:f_word = 17'd85900;
				default:;
			endcase
		end
	end
endmodule