module mux4
(
input logic [3:0] d0, d1, d2, d3,
input logic [1:0] s,
output logic [3:0] y
);

	assign y = s[1] ? (s[0] ? d3 : d2) : (s[0] ? d1 : d0);
	/*
		s[1] == 1 то выбирает первое выражение s[0] ? d3 : d2
		s[0] == 0 то выбирает второе выражение s[0] ? d1 : d0
		
		y = d3 если s[1] == 1 и s[0] == 1
	*/
	
endmodule