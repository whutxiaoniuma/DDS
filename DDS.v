 
module DDS(
	input				sys_clk			,
	input				sys_rst_n		,
	input		[16:0]	f_word		,
	input		[1:0]	wave_c		,
	input		[11:0]	p_word		,
	input		[4:0]	amplitude	,
	output	reg	[11:0]	dac_data	
	);
    
	reg		[11:0]	addr	 ;
	wire	[11:0]	dac_data0;
	wire	[11:0]	dac_data1;
	wire	[11:0]	dac_data2;
	
	//波形选择
	always @(posedge sys_clk or negedge sys_rst_n) begin
		if (!sys_rst_n) begin
			dac_data <= 12'd0; 
		end
		else begin
			case(wave_c)
				2'b00:dac_data <= dac_data0/amplitude;	//正弦波
				2'b01:dac_data <= dac_data1/amplitude;	//方波
				2'b10:dac_data <= dac_data2/amplitude;	//三角波
				2'b11:dac_data <= dac_data0/amplitude;	//正弦波
				default:;
			endcase
		end
	end
 
	//相位累加器
	reg	[31:0]	fre_acc;
	always @(posedge sys_clk or negedge sys_rst_n) begin
		if (!sys_rst_n) begin
			fre_acc <= 0;
		end
		else begin
			fre_acc <= fre_acc + f_word;
		end
	end
 
	//生成查找表地址
	always @(posedge sys_clk or negedge sys_rst_n) begin
		if (!sys_rst_n) begin
			addr <= 0;
		end
		else begin
			addr <= fre_acc[31:20] + p_word;
		end
	end
 
	//正弦波
	rom_wave_sin	rom_wave_sin_inst (
	.address ( addr ),
	.clock ( sys_clk ),
	.q ( dac_data0 )
	);
    //方波
 rom_wave_squ	rom_wave_squ_inst (
	.address ( addr ),
	.clock ( sys_clk ),
	.q ( dac_data1 )
	);
    //三角波
	rom_wave_tri	rom_wave_tri_inst (
	.address ( addr ),
	.clock ( sys_clk ),
	.q ( dac_data2 )
	);
 
endmodule
