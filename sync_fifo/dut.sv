module dut #(parameter depth = 16, width = 16) (fifo_data_in, rst_, fifo_write, fifo_read, clk, fifo_data_out, fifo_full, fifo_empty);

//Inputs and outputs
input logic [width-1 : 0] fifo_data_in;
input wire rst_, fifo_write, fifo_read, clk;
output logic [width-1 : 0] fifo_data_out;
output wire fifo_full, fifo_empty;

//Internal variables
wire wr_pnt;
wire rd_pnt;
logic [width-1 : 0] mem [0 : depth - 1];

always_ff@(posedge clk, negedge rst_) begin

	//Active low reset
	if (!rst_) begin
		fifo_data_out <= 0;
	end

	//Write operation
	if (fifo_write && !fifo_full) begin
		
	end

	//Read operation
	if (fifo_read && !fifo_empty) begin

	end


end




endmodule
