module Register_With_Sync_Reset
#(
	parameter Word_Lenght = 65
)

(
	input clk,
	input reset,
	input enable,
	input Sync_Reset,
	input [Word_Lenght - 1:0] Data_Input,
	
	output [Word_Lenght - 1:0] Data_Output
	
);

logic [Word_Lenght - 1:0] Data_reg;

always_ff@(posedge clk or negedge reset) begin: REGISTER
	if(reset == 1'b0)
		Data_reg <= {Word_Lenght{1'b0}};
	else
		if(Sync_Reset == 1'b1) 
				Data_reg <= {Word_Lenght{1'b0}};
		else
			if(enable == 1'b1)
				Data_reg <= Data_Input;
			else
				Data_reg <= Data_reg;
				
end: REGISTER

assign Data_Output = Data_reg;

endmodule
