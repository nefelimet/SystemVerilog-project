module dut_property(pdata_in, prst_, pld_cnt, pupdn_cnt, pcount_enb, pclk, pdata_out);

//Property 1: when reset is asserted, the output of the counter is zero
property pr1;
	@(posedge pclk) prst |-> pdata_out = 0;
endproperty

assert property (pr1) else $display("Property 1 FAIL.");


//Property 2: 
property pr2;
	@(posedge pclk) disable iff(prst_)
	!pld_cnt && !pcount_enb |-> pdata_out == $past(pdata_out);
endproperty

assert property (pr2) else $display("Property 2 FAIL.");


//Property 3:
property pr3;
	
endproperty

assert property (pr3) else $display("Property 3 FAIL.");

endmodule
