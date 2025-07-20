module Debounce_Switch 
(
input logic i_Clk,
input logic i_Switch,
output logic o_Switch
);

parameter int unsigned c_DEBOUNCE_LIMIT = 250_000;

logic [17:0] r_Count = '0;
logic 		 r_State = 1'b0;

always_ff @(posedge i_Clk) begin
	// Switch is changing -> Start counting debounce interval
	if (i_Switch !== r_State && r_Count < c_DEBOUNCE_LIMIT) begin
		r_Count <= r_Count + 1;
	end
	
	// Debounce period expired -> accept new state
	else if (r_Count == c_DEBOUNCE_LIMIT) begin
		r_State <= i_Switch;
		r_Count <= '0;
	end
	
	// Stable state -> reset counter
	else begin
		r_Count <= '0;
	end
	
end

assign o_Switch = r_State;


endmodule

	