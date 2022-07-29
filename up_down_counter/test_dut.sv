module test_dut;

bit [15:0] sys_data_in;
bit sys_rst_, sys_ld_cnt, sys_updn_cnt, sys_count_enb, sys_clk;
bit [15:0] sys_data_out;

dut my_dut(.data_in(sys_data_in), .rst_(sys_rst_), .ld_cnt(sys_ld_cnt), .updn_cnt(sys_updn_cnt), .count_enb(sys_count_enb), .clk(sys_clk), .data_out(sys_data_out));

bind dut dut_property dutbound(data_in, rst_, ld_cnt, updn_cnt, count_enb, clk, data_out);

always @(posedge sys_clk)
	$display($stime,,,"data_in = %b, rst=%b, ld_cnt=%b, updn_cnt=%b, count_enb=%b, clk=%b, data_out=%b", sys_data_in, sys_rst_, sys_ld_cnt, sys_updn_cnt, sys_count_enb, sys_clk, sys_data_out);
always #10 sys_clk = !sys_clk;

initial
begin

	sys_rst_ = 1'b1;
	sys_data_in = 16'b0;
	sys_ld_cnt = 0;
	sys_updn_cnt = 0;
	sys_count_enb = 0;
	#60;

	sys_data_in = 7;
	#60;

	sys_ld_cnt = 1;
	sys_updn_cnt = 1;
	sys_count_enb = 1;
	#60;

	sys_updn_cnt = 0;
	#60;

end

endmodule
