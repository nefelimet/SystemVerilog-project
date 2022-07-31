module dut(data_in, rst_, ld_cnt, updn_cnt, count_enb, clk, data_out);

input logic [15:0] data_in;
input wire rst_, ld_cnt, updn_cnt, count_enb, clk; 
output logic [15:0] data_out;

always_ff@(posedge clk, negedge rst_) begin
	
//If reset is active, data out is zero. Reset is active low.
	if(!rst_) begin
		data_out <= 16'b0;
	end

//If ld_cnt (load counter) is active, load input data to output. ld_cnt is active low.
//Load counter has a higher priority than count enable.
	if(!ld_cnt) begin
		data_out <= data_in;
	end

//If count enable is active, count up or down, according to updn_cnt's value.
	else if(count_enb) begin
		if(updn_cnt) begin
			data_out = data_out + 1;
		end

		else begin
			data_out = data_out - 1;
		end
	end
end



endmodule 
