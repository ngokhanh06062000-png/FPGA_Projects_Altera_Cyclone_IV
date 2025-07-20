module decoder
	# (parameter N = 3)
	(input logic [N-1:0] a,
	output logic [2**N - 1 : 0] y);
	// 2**N означает 2^N
	always_comb
		begin 
			y = 0;
			y[a] = 1;
		end
endmodule 