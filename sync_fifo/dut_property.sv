module dut_property(pfifo_data_in, prst_, pfifo_write, pfifo_read, pclk, pfifo_data_out, pfifo_full, pfifo_empty);

input wire [] pfifo_data_in, pfifo_data_out;
input wire prst_, pfifo_write, pfifo_read, pclk, pfifo_full, pfifo_empty;

//Property 1:
property pr1;
	@(posedge pclk) !prst_ |-> (pfifo_write == 0 && pfifo_read == 0 && pfifo_full == 0 && pfifo_empty == 1 && pcnt == 0);
endproperty

assert property (pr1) $display($stime,,,"\t\t Property 1 PASS.");
	else $display($stime,,,"\t\t Property 1 FAIL.");


//Property 2:
property pr2 disable iff (!prst_);
	@(posedge pclk) !pcnt |-> pfifo_empty;
endproperty

assert property (pr2) $display($stime,,,"\t\t Property 2 PASS.");
	else $display($stime,,,"\t\t Property 2 FAIL.");


//Property 3:
property pr3 disable iff (!prst_);
	@(posedge pclk) (pcnt >= 16) |-> pfifo_full;
endproperty

assert property (pr3) $display($stime,,,"\t\t Property 3 PASS.");
	else $display($stime,,,"\t\t Property 3 FAIL.");


//Property 4:
property pr4;
	@(posedge pclk) (pfifo_full && 
endproperty


endmodule
