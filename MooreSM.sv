module MooreSM
(
	// Input Ports
	input clk,
	input reset,
	input start,

	// Output Ports
	output Load,
	output Shift	
);



enum logic [2:0] {IDLE, LOAD, SHIFT, READY} state; /* DEFINICIÓN DE ESTADOS DE LA MÁQUINA */


logic enable_load;
logic enable_shift;


always_ff@(posedge clk or negedge reset) begin
				
		if (reset == 0) 							/* RESET GENERAL DEL SISTEMA*/
			state <= IDLE;										/* SE REINICIA LA MÁQUINA AL ESTADO INICIAL */
		else begin					
			case(state)	
					IDLE: 
							if(start == 1'b1)
									state <= IDLE;
							else if(start == 1'b0)
									state <= LOAD;
					
					LOAD: 
							state <= SHIFT;
					SHIFT:
							state <= READY;
											
					READY: 
							state <= IDLE;																		 

					default:
							state <= IDLE;
			endcase
		end
end // end always

//--------------------------------------------------------------------------------------------

		/*Asignación de salidas,proceso combintorio*/

	
always_comb 
begin

	Ready = 0;
	enable_load = 0;
	enable_shift = 0;

	
		case(state)
 
				IDLE: 
				begin
					
					Ready = 0;
					enable_load = 0;
					enable_shift = 0;

				end
			
				LOAD: 
				begin
					
					Ready = 0;
					clear_data = 1;
					enable_load = 1;
					enable_shift = 0;
					

				end
				
				SHIFT:
				begin
					
					Ready = 0;
					enable_load = 0 ;
					enable_shift = 1;
				

				end	
		
				READY:
				begin
					
					Ready = 1;
					enable_load = 0;
					enable_shift = 0;
					
					
				end
		endcase
		
end// end always_comb


assign ready = Ready;
assign Load = enable_load;
assign Shift = enable_shift;


endmodule 