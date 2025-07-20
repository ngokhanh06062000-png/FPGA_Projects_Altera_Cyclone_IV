module andN
	#(parameter width = 8)
	(
	input logic [width - 1: 0] a,
	output logic 			   y
	);
	
	genvar i;
	logic [width -1:0] x;
	
	generate 
		assign x[0] = a[0];
		for (i = 1; i<width; i = i+1) begin: forloop 
		// После 'begin' в цикле 'for' внутри 'generate'
		// должно быть двоеточие и произвольная метка (в данном - forloop)
		// объявление переменной цикла - i как genvar
			assign x[i] = a[i] & x[i-1];
		end
	endgenerate
	
	assign y = x[width - 1];
endmodule