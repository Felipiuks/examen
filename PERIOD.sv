module PERIOD
(
	input freq,
	output period
);

bit period_logic;

always_comb begin:
	
	period_logic = 1/freq;

end 
assign period = period_logic;
endmodule 