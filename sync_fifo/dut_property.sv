module dut_property #(parameter depth = 16, width = 16) (pfifo_data_in, prst_, pfifo_write, pfifo_read, pclk, pfifo_data_out, pfifo_full, pfifo_empty, pcnt, pwr_ptr, prd_ptr);

input wire [width-1 : 0] pfifo_data_in, pfifo_data_out;
input wire prst_, pfifo_write, pfifo_read, pclk, pfifo_full, pfifo_empty;
input integer pcnt;
input wire [$clog2(depth) : 0] pwr_ptr, prd_ptr;

//Property 1:
//On reset, the read and write pointers are zero, empty and full indicators are ?1? and ?0?, respectively (since the memory is indeed empty), and the counter is zero as well. 
property pr1;
	@(posedge pclk) !prst_ |-> (pwr_ptr == 0 && prd_ptr == 0 && pfifo_full == 0 && pfifo_empty == 1 && pcnt == 0);
endproperty

assert property (pr1) $display($stime,,,"\t\t Property 1 PASS.");
	else $display($stime,,,"\t\t Property 1 FAIL.");


//Property 2:
//The fifo empty signal is asserted whenever cnt = 0. Disable this property if the reset is active.
property pr2;
	@(posedge pclk) disable iff (!prst_) !pcnt |-> pfifo_empty;
endproperty

assert property (pr2) $display($stime,,,"\t\t Property 2 PASS.");
	else $display($stime,,,"\t\t Property 2 FAIL.");


//Property 3:
//The fifo full signal is asserted whenever cnt >= 16. Disable this property if the reset is active.
property pr3;
	@(posedge pclk) disable iff (!prst_) (pcnt >= 16) |-> pfifo_full;
endproperty

assert property (pr3) $display($stime,,,"\t\t Property 3 PASS.");
	else $display($stime,,,"\t\t Property 3 FAIL.");


//Property 4:
//If the FIFO is full and there is write request (but not read), then the write pointer should not change.
property pr4;
	@(posedge pclk) (pfifo_full && pfifo_write) |=> (pwr_ptr == $past(pwr_ptr));
endproperty

assert property (pr4) $display($stime,,,"\t\t Property 4 PASS.");
	else $display($stime,,,"\t\t Property 4 FAIL.");


//Property 5:
//If the FIFO is empty and there is read request (but not write), then the read pointer should not change. 
property pr5;
	@(posedge pclk) (pfifo_empty && pfifo_read) |=> (prd_ptr == $past(prd_ptr));
endproperty

assert property (pr5) $display($stime,,,"\t\t Property 5 PASS.");
	else $display($stime,,,"\t\t Property 5 FAIL.");


endmodule
