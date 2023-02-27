module DDS_top(
	input					sys_clk			,
	input					sys_rst_n		,
	input					key0_in		,
	input					key1_in		,
	input					key2_in		,
 
	output	wire	[11:0]	dac_data	
	);
 
	wire	[1:0]	wave_c		;
	wire	[16:0]	f_word		;
	wire	[4:0]	amplitude	;
    
   DDS DDS_inst(
	.sys_clk	(sys_clk),
	.sys_rst_n	(sys_rst_n),
	.f_word		(f_word),
	.wave_c		(wave_c),
	.p_word		(12'd0),
	.amplitude	(amplitude),
	.dac_data	(dac_data)
	);
    
	F_word_set F_word_set_inst(          
	.sys_clk   (sys_clk	),
	.sys_rst_n (sys_rst_n),
	.key1_in   (key1_in),
	.f_word    (f_word)
	);
    
	wave_set wave_set_inst(
	.sys_clk   (sys_clk),
	.sys_rst_n (sys_rst_n),
	.key0_in   (key0_in),
	.wave_c    (wave_c)
	);
    
	amplitude_set amplitude_set_inst(
	.sys_clk   (sys_clk),
	.sys_rst_n (sys_rst_n),
	.key2_in   (key2_in),
	.amplitude (amplitude)
	);
endmodule