module test_dut #(parameter sys_depth = 16, sys_width = 16);

bit [sys_width-1 : 0] sys_fifo_data_in;
bit sys_rst_, sys_fifo_write, sys_fifo_read, sys_clk, sys_fifo_full, sys_fifo_empty;
integer sys_cnt;
bit [sys_width-1 : 0] sys_fifo_data_out;
bit [$clog2(sys_depth) : 0] sys_wr_ptr, sys_rd_ptr;

dut #(.width(16), .depth(16)) my_dut   (.fifo_data_in(sys_fifo_data_in), .rst_(sys_rst_), .fifo_write(sys_fifo_write), .fifo_read(sys_fifo_read), .clk(sys_clk), .fifo_data_out(sys_fifo_data_out), .fifo_full(sys_fifo_full), .fifo_empty(sys_fifo_empty));

bind dut dut_property #(.depth(16), .width(16)) dutbound(fifo_data_in, rst_, fifo_write, fifo_read, clk, fifo_data_out, fifo_full, fifo_empty, dut.cnt, dut.wr_ptr, dut.rd_ptr);

always @(posedge sys_clk)
	$display($time,,,"wr_ptr=%b, rd_ptr=%b, fifo_full=%b, fifo_empty=%b, mem[0]=%b, mem[1]=%b, mem[2]=%b, mem[3]=%b, mem[4]=%b, mem[5]=%b, mem[6]=%b, mem[7]=%b, mem[8]=%b, mem[9]=%b, mem[10]=%b, mem[11]=%b, mem[12]=%b, mem[13]=%b, mem[14]=%b, mem[15]=%b", my_dut.wr_ptr, my_dut.rd_ptr, my_dut.fifo_full, my_dut.fifo_empty, my_dut.mem[0], my_dut.mem[1], my_dut.mem[2], my_dut.mem[3], my_dut.mem[4], my_dut.mem[5], my_dut.mem[6], my_dut.mem[7], my_dut.mem[8], my_dut.mem[9], my_dut.mem[10], my_dut.mem[11], my_dut.mem[12], my_dut.mem[13], my_dut.mem[14], my_dut.mem[15]);
always #10 sys_clk = !sys_clk;

initial begin


	sys_rst_ = 0;
	sys_fifo_data_in = 7;
	sys_fifo_write = 1;
	sys_fifo_read = 0;

	#20;

	sys_rst_ = 1;
	#20;

	sys_fifo_write = 0;
	#20;
	sys_fifo_read = 1;
	#20;

	sys_fifo_read = 0;
	#20;
	sys_fifo_write = 1;
	sys_fifo_data_in = 0;
	#20;
	sys_fifo_data_in = 1;
	#20;
	sys_fifo_data_in = 2;
	#20;
	sys_fifo_data_in = 3;
	#20;
	sys_fifo_data_in = 4;
	#20;
	sys_fifo_data_in = 5;
	#20;
	sys_fifo_data_in = 6;
	#20;
	sys_fifo_data_in = 7;
	#20;
	sys_fifo_data_in = 8;
	#20;
	sys_fifo_data_in = 9;
	#20;
	sys_fifo_data_in = 10;
	#20;
	sys_fifo_data_in = 11;
	#20;
	sys_fifo_data_in = 12;
	#20;
	sys_fifo_data_in = 13;
	#20;
	sys_fifo_data_in = 14;
	#20;
	sys_fifo_data_in = 15;
	#20;
	sys_fifo_write = 0;
	#60;

	sys_fifo_read = 1;
	#20;
	#20;
	#20;
	#20;
	#20;
	#20;
	#20;
	#20;
	#20;
	#20;
	#20;
	#20;
	#20;
	#20;
	#20;
	#20;
end

endmodule
