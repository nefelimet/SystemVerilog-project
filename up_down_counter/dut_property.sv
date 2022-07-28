module dut_property(pdata_in, prst_, pld_cnt, pupdn_cnt, pcount_enb, pclk, pdata_out);
input logic [15:0] pdata_in;
input wire prst_, pld_cnt, pupdn_cnt, pcount_enb, pclk;
output logic [15:0] pdata_out;

//Property 1: when reset is asserted, the output of the counter is zero
property pr1;
	@(posedge pclk) prst_ |-> pdata_out == 0;
endproperty

assert property (pr1) else $display("Property 1 FAIL.");


//Property 2: if ld_cnt is deasserted and count_enb is not enabled the counter output does not change. Disabled when rst_ is active (low).
property pr2;
	@(posedge pclk) disable iff(!prst_)
	pld_cnt && !pcount_enb |-> pdata_out == $past(pdata_out);
endproperty

assert property (pr2) else $display("Property 2 FAIL.");


//Property 3: if ld_cnt is deasserted and count_enb is enabled then if updn_cnt is high, the counter increments. Disabled when rst_ is active (low).

property pr3;
	@(posedge pclk) disable iff(!prst_)
	pld_cnt && pcount_enb && pupdn_cnt |-> pdata_out == $past(pdata_out) + 1;
endproperty

assert property (pr3) else $display("Property 3 FAIL.");


//Property 4: if ld_cnt is deasserted and count_enb is enabled then if updn_cnt is low, the counter decrements. Disabled when rst_ is active (low).

property pr4;
	@(posedge pclk) disable iff(!prst_)
	pld_cnt && pcount_enb && !pupdn_cnt |-> pdata_out == $past(pdata_out) - 1;
endproperty

assert property (pr4) else $display("Property 4 FAIL.");

endmodule
