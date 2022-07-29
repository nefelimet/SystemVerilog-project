module dut #(parameter depth = 16, width = 16) (fifo_data_in, rst_, fifo_write, fifo_read, clk, fifo_data_out, fifo_full, fifo_empty);

//Inputs and outputs
input logic [width-1 : 0] fifo_data_in;
input wire rst_, fifo_write, fifo_read, clk;
output logic [width-1 : 0] fifo_data_out;
output wire fifo_full, fifo_empty;

//Internal variables
wire wr_ptr;
wire rd_ptr;
logic cnt;
logic [width-1 : 0] mem [0 : depth-1];

always_ff@(posedge clk, negedge rst_) begin

	//Active low reset
	if (!rst_) begin
		fifo_data_out <= 0;
	end

	//Write operation
	if (fifo_write && !fifo_full) begin
		mem[wr_ptr] = fifo_data_in;
		wr_ptr = wr_ptr + 1;
		cnt = cnt + 1;
	end

	//Read operation
	if (fifo_read && !fifo_empty) begin
		mem[rd_ptr] = fifo_data_in;
		rd_ptr = rd_ptr + 1;
		cnt = cnt - 1;
	end

	//Full FIFO assertion


	//Empty FIFO assertion


end


endmodule
