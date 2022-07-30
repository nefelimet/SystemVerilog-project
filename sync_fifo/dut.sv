module dut #(parameter depth = 16, width = 16) (fifo_data_in, rst_, fifo_write, fifo_read, clk, fifo_data_out, fifo_full, fifo_empty);

//Inputs and outputs
input logic [width-1 : 0] fifo_data_in;
input wire rst_, fifo_write, fifo_read, clk;
output logic [width-1 : 0] fifo_data_out;
output logic fifo_full, fifo_empty;

//Internal variables
logic [$clog2(depth) : 0] wr_ptr, rd_ptr;
logic cnt;
logic [width-1 : 0] mem [0 : depth-1];

//initial begin
//	wr_ptr <= 0;
//	rd_ptr <= 0;
//end

always_ff@(posedge clk, negedge rst_) begin

	//Active low reset
	if (!rst_) begin
		for(int i = 0; i < depth; i++) begin
			mem[i] <= 0;
		end
		cnt <= 0;
		fifo_full <= 0;
		fifo_empty <= 1;
		wr_ptr <= 0;
		rd_ptr <= 0;
	end
	
	else begin

	//Write operation
	if (fifo_write && !fifo_full) begin
		mem[wr_ptr] <= fifo_data_in;
		wr_ptr <= wr_ptr + 1;
		cnt <= cnt + 1;
	end

	//Read operation
	if (fifo_read && !fifo_empty) begin
		fifo_data_out <= mem[rd_ptr];
		rd_ptr <= rd_ptr + 1;
		cnt <= cnt - 1;
	end

	//Full FIFO assertion
	if ((wr_ptr >> (width-1) != rd_ptr >> (width-1)) && ((wr_ptr << 1) >> 1 == (rd_ptr << 1) >> 1)) begin
		fifo_full <= 1;
	end

	//Empty FIFO assertion
	if (wr_ptr == rd_ptr) begin
		fifo_empty <= 1;
	end

	end
end


endmodule
