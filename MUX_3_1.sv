module MUX_3_1
#(
	
	parameter selector_size = 2
)

(
	input DATA_0,
	input DATA_1,
	input DATA_2,
	input DATA_3,
	input [selector_size - 1:0] selector,
	
	output MUX_OUT	
);

logic Mux_Output_log;

always_comb begin
	
	case(selector)
		
		2'b00:
			Mux_Output_log = DATA_0;
		
		2'b01:
			Mux_Output_log = DATA_1;
		
		2'b10:
			Mux_Output_log = DATA_2;
			
		2'b11:
			Mux_Output_log = DATA_3;
		
		default:
			Mux_Output_log = 0;
	
	endcase

end

assign MUX_OUT = Mux_Output_log;

endmodule 