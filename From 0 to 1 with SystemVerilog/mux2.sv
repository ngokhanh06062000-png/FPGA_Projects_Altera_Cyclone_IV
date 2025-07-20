module mux2
(
input logic [3:0] d0, d1,
input logic s,
output logic [3:0] y
);

	assign y = s ? d1 : d0;
	/*
	 Если s = 1, то y = d1
		  s = 0, то y = d0
	Оператор ? - тернарный оператор, так как он имеет 3 входа
	*/

endmodule