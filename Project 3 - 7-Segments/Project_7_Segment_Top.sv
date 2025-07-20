module Project_7_Segment_Top
(
input  logic i_Clk,
input  logic i_Switch_1,
output logic o_Segment2_A,
output logic o_Segment2_B,
output logic o_Segment2_C,
output logic o_Segment2_D,
output logic o_Segment2_E,
output logic o_Segment2_F,
output logic o_Segment2_G,
output logic o_DIG1
);

// Internal signals
	logic 		w_Switch_1;
	logic			r_Switch_1 = 1'b0;
	logic [3:0]	r_Count 	  = 4'd0;
	
	logic w_Segment2_A, w_Segment2_B, w_Segment2_C;
	logic w_Segment2_D, w_Segment2_E, w_Segment2_F;
	logic w_Segment2_G;
	
// Instantiate Debounce Filter
	Debounce_Switch	Debounce_Switch_Inst (
		.i_Clk 		(i_Clk),
		.i_Switch	(i_Switch_1),
		.o_Switch	(w_Switch_1)
	);
	
// Counter Logic
	always_ff @(posedge i_Clk) begin
		r_Switch_1 <= w_Switch_1;
		
		if (w_Switch_1 && !r_Switch_1) begin
			if (r_Count == 4'd9)
				r_Count <= 4'd0;
			else 
				r_Count <= r_Count + 1;
		end
	end
	
// Instatiate Binary to 7-Segment Decoder

Binary_To_7Segment Binary_To_7Segment_Inst (
	.i_Clk		(i_Clk),
	.i_Binary_Num (r_Count),
	.o_Segment_A  (w_Segment2_A),
	.o_Segment_B  (w_Segment2_B),
	.o_Segment_C  (w_Segment2_C),
	.o_Segment_D  (w_Segment2_D),
	.o_Segment_E  (w_Segment2_E),
	.o_Segment_F  (w_Segment2_F),
	.o_Segment_G  (w_Segment2_G)
);

// Invert output (active-low common anode)
	assign o_Segment2_A = ~w_Segment2_A;
	assign o_Segment2_B = ~w_Segment2_B;
	assign o_Segment2_C = ~w_Segment2_C;
	assign o_Segment2_D = ~w_Segment2_D;
	assign o_Segment2_E = ~w_Segment2_E;
	assign o_Segment2_F = ~w_Segment2_F;
	assign o_Segment2_G = ~w_Segment2_G;
	assign o_DIG1 = 1'b0;

endmodule
