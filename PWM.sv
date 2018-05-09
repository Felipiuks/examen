module PWM
#(
	parameter WORD_LENGTH = 8,
	parameter WORD_LENGTH_FREQ = 2
)

(
	// Input Ports
	input clk,
	input reset,
	input start,
	input [WORD_LENGTH-1:0] dutyCycle,
	input [WORD_LENGTH_FREQ-1:0] frequency,
	

	output pwm_output
);

wire clk_10k_out;
wire clk_20k_out;
wire clk_30k_out;
wire clk_40k_out;

wire mux_out_freq;
wire wire_period;
wire [WORD_LENGTH-1:0]wire_DC_SEL;

wire wave_out;

wire load_flag;
wire shift_flag;

Tarea4_CLOCK_GENERATOR CLK_10K(
	
	.clk_FPGA(clk),
	.reset(reset),
	.clk_salida(clk_10k_out)
);

Tarea4_CLOCK_GENERATOR_20K CLK_20K(
	
	.clk_FPGA(clk),
	.reset(reset),
	.clk_salida(clk_20k_out)
);

Tarea4_CLOCK_GENERATOR_30K CLK_30K(
	
	.clk_FPGA(clk),
	.reset(reset),
	.clk_salida(clk_30k_out)
);

Tarea4_CLOCK_GENERATOR_40K CLK_40K(
	
	.clk_FPGA(clk),
	.reset(reset),
	.clk_salida(clk_40k_out)
);

MUX_3_1 MULTIPLEXER(
	.DATA_0(clk_10k_out),
	.DATA_1(clk_20k_out),
	.DATA_2(clk_30k_out),
	.DATA_3(clk_40k_out),
	.selector(frequency),
	.MUX_OUT(mux_out_freq)	
);

PERIOD GET_PERIOD(
	.freq(mux_out_freq),
	.period(wire_period)
);

WAVE WAVE_SIZE (
	.period(wire_period),
	.DC(dutyCycle),
	.wave_lenght(wave_out)
);

MooreSM SM(
	// Input Ports
	.clk(clk),
	.reset(reset),
	.start(start),

	// Output Ports
	.Load(load_flag),
	.Shift(shift_flag)	
);

ShiftRegisterRight SHIFT_RIGHT(
	.clk(clk),
	.reset(reset),
	.load(load_flag),
	.shift(shift_flag),
	.parallelInput(wave_out),
	.parallelOutput(pwm_output)
	
);
endmodule 