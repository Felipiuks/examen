module Tarea4_CLOCK_GENERATOR_40K
#(
	// Parameter Declarations
	parameter FREQUENCY = 40000,
	parameter FREQUENCY_CALCULATOR = freq_calc(FREQUENCY),
	parameter NBITS_FOR_COUNTER = CeilLog2(FREQUENCY_CALCULATOR)
	
	
)

(
	// Input Ports
	input clk_FPGA,
	input reset,
	// Output Ports
	output clk_salida

);
logic [NBITS_FOR_COUNTER - 1 : 0] Count_logic;

bit MaxValue_Bit;
bit clk_output = 1'b0;


always_ff@(posedge clk_FPGA or negedge reset) begin
		if (reset == 1'b0)
		begin
				Count_logic <= {NBITS_FOR_COUNTER{1'b0}};
				clk_output <= 1'b0;
				
		end
		else begin
			if(MaxValue_Bit == 1'b1)
			begin
				clk_output <= ~clk_output;
				Count_logic <= 0;
			end
			else 
				Count_logic <= Count_logic + 1'b1;		
		end
	end
	
always_comb

	if(Count_logic == FREQUENCY_CALCULATOR - 1)
		MaxValue_Bit = 1;
	else
		MaxValue_Bit = 0;

assign clk_salida = clk_output;
/*--------------------------------------------------------------------*/
 /*--------------------------------------------------------------------*/
 /*--------------------------------------------------------------------*/
   
 /*Log Function*/
     function integer CeilLog2;
       input integer data;
       integer i,result;
       begin
          for(i=0; 2**i <= data; i=i+1)
             result = i + 1;
          CeilLog2 = result;
       end
    endfunction

/*--------------------------------------------------------------------*/
 /*--------------------------------------------------------------------*/
 /*--------------------------------------------------------------------*/
		function integer freq_calc;
			input integer freq_requerida;
			integer result;
			begin
				result = (50000000/freq_requerida)/2;
				freq_calc = result;
			end
		endfunction

endmodule 