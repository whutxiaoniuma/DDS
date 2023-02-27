
module wave_set(
	input				sys_clk,
	input				sys_rst_n	,
	input				key0_in	,
	output	reg	[1:0]	wave_c		//wave_c oo~正弦波  01~三角波  10~锯齿波  11~方波
	);
 
	wire	key_flag	;
	key_filter key_filter_inst(
         .sys_clk    (sys_clk),
         .sys_rst_n  (sys_rst_n),
         .key_in     (key0_in),
         .key_flag   (key_flag)
		);
	always @(posedge sys_clk or negedge sys_rst_n) begin
		if (!sys_rst_n) begin
			wave_c <= 0; //默认正弦波
		end
		else if (key_flag) begin
			wave_c <= wave_c + 1'b1;
		end
	end
endmodule