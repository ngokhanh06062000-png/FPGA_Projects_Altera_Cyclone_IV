'timescale 1ns/1ps			// Единица времени = 1 нс, и моделирование с точностью 1 пс

module example 
(
input logic a, b, c,
output logic y
);

	assign #1 {ab, bb, cb} = ~{a, b, c}; // Задержка 1 нс
	assign #2 n1 = ab & bb & cb;		 // Задержка 2 нс
	assign #2 n2 = a & bb & cb;			 // Задержка 2 нс
	assign #2 n3 = a & bb & c;			 // Задержка 2 нс
	assign #4 y = n1 | n2 | n3;			 // Задержка 4 нс

endmodule