module ShiftRegisterRight
#(
	parameter WORD_LENGTH = 8
)
(
	input clk,
	input reset,
	input load,
	input shift,
	input  parallelInput,
	output parallelOutput
	
);

logic [7:0]shiftRegister_logic;


always_ff@(posedge clk, negedge reset) begin: register
	
	if(reset == 1'b0)
		shiftRegister_logic <= 1'b0;
	else
		if(load == 1'b1) begin
			shiftRegister_logic <= parallelInput;
			end
	else if(shift == 1'b1) begin
			shiftRegister_logic <= (shiftRegister_logic >> 1'b1);
			end			
end: register
 
assign parallelOutput = (shiftRegister_logic[0]);

endmodule 