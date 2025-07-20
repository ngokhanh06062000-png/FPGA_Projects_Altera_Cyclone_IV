module Debounce_switch_project 
(
input logic i_Clk,
input logic i_Switch_1,
output logic o_LED_1
);

	logic r_LED_1 = 1'b0;
	logic r_Switch_1 = 1'b0;
	logic w_Switch_1;
	
	// Instantiate Debounce module
	Debounce_switch Debounce_Inst (
	.i_Clk (i_Clk),
	.i_Switch (i_Switch_1),
	.o_Switch (w_Switch_1)
	);
	
	// Purpose: Toggle LED output when w_Switch_1
	// is released (falling edge)
	always_ff @(posedge i_Clk) begin
		r_Switch_1 <= w_Switch_1;
		
		if (w_Switch_1 == 1'b0 && r_Switch_1 == 1'b1) begin
			r_LED_1 <= ~r_LED_1;
		end
	end
	
	assign o_LED_1 = r_LED_1;
	
endmodule
	