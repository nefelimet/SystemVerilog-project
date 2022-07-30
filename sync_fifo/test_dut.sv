module test_dut #(parameter sys_depth = 16, sys_width = 16);

bit [sys_width-1 : 0] sys_fifo_data_in;
bit sys_rst_, sys_fifo_write, sys_fifo_read, sys_clk, sys_fifo_full, sys_fifo_empty, sys_wr_ptr, sys_rd_ptr, sys_cnt;
bit [sys_width-1 : 0] sys_fifo_data_out;

dut #(.width(16), .depth(16)) my_dut   (.fifo_data_in(sys_fifo_data_in), .rst_(sys_rst_), .fifo_write(sys_fifo_write), .fifo_read(sys_fifo_read), .clk(sys_clk), .fifo_data_out(sys_fifo_data_out), .fifo_full(sys_fifo_full), .fifo_empty(sys_fifo_empty));

bind dut dut_property #(.depth(16), .width(16)) dutbound(fifo_data_in, rst_, fifo_write, fifo_read, clk, fifo_data_out, fifo_full, fifo_empty, dut.cnt, dut.wr_ptr, dut.rd_ptr);

always @(posedge sys_clk)
	$display($time,,,"");
always #10 sys_clk = !sys_clk;

initial begin
	sys_rst_ <= 1;

	sys_fifo_data_in = 7;
	sys_fifo_write = 1;
	sys_fifo_read = 0;

	#60;
end

endmodule
