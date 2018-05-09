module WAVE
#(
 parameter WORD_LENGTH = 8
 )
(
	input period,
	input[WORD_LENGTH - 1:0] DC,
	output wave_lenght
);

bit wave_logic;
bit duty = 4'b1000;

always_comb begin:
	case(DC)
		8'b0000_0001:
			wave_logic = duty*period;
		8'b0000_0010:
			wave_logic = 2*duty*period;
		8'b0000_0100:
			wave_logic = 3*duty*period;
		8'b0000_1000:
			wave_logic = 4*duty*period;
		8'b0001_0000:
			wave_logic = 5*duty*period;
		8'b0010_0000:
			wave_logic = 6*duty*period;
		8'b0100_0000:
			wave_logic = 7*duty*period;
		8'b1000_0000:
			wave_logic = 7'b1100100*period;
		default:
			wave_logic = 0;
	endcase
end 
assign wave_lenght = wave_logic;
endmodule 