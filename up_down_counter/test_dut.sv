module test_dut;

logic [15:0] sys_data_in;
wire sys_rst_, sys_ld_cnt, sys_updn_cnt, sys_count_enb, sys_clk;
logic [15:0] sys_data_out;

dut my_dut(.data_in(sys_data_in), .rst_(sys_rst_), .ld_cnt(sys_ld_cnt), .updn_cnt(sys_updn_cnt), .count_enb(sys_count_enb), .clk(sys_clk));

bind dut dut_property dutbound(data_in, rst_, ld_cnt, updn_cnt, count_enb, clk, data_out);

always @(posedge sys_clk)
	$display($stime,,,"data_in = %b, rst=clk=%b req=%b gnt=%b",sys_clk,sys_req,sys_gnt);
always #10 sys_clk = !sys_clk;

initial
begin

	sys_rst_ = 1'b0;
	@(posedge sys_clk) $finish(2);

end

endmodule
