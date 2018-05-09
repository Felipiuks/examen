
timeunit 1ps; //It specifies the time unit that all the delay will take in the simulation.
timeprecision 1ps;// It specifies the resolution in the simulation.

module Tarea4_CLOCK_GENERATOR_TB;

parameter FREQUENCY = 5000000;

 // Input Ports
reg clk_FPGA = 0;
reg reset;

wire clk_salida;
	

Tarea4_CLOCK_GENERATOR
#(
	.FREQUENCY(FREQUENCY)
)

DUT
(
	// Input Ports
	.clk_FPGA(clk_FPGA),
	.reset(reset),
	
	// Output Ports
	.clk_salida(clk_salida) 

);	

/*********************************************************/
initial // Clock generator
  begin
    forever #2 clk_FPGA = !clk_FPGA;
  end
/*********************************************************/
initial begin // reset generator
	#0 reset = 0;
	#5 reset = 1;
end

/*********************************************************/

endmodule