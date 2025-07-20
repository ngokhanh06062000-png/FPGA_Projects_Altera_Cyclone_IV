module mux2
	#(parameter width = 8) // Определение оператора 'parameter' модуля
	(
	input logic [width - 1: 0] d0, d1,
	input logic 				s,
	output logic [width - 1: 0] y
	);
	
	assign y = s ? d1 : d0;
endmodule 

module mux4_8
	(
	input logic [7:0] d0, d1, d2, d3,
	input logic [1:0] s,
	output logic [7:0] y
	);	
	
	logic [7:0] low, hi;
	mux2 lowmux(d0, d1, s[0], low);
	mux2 himux(d2, d3, s[0], hi);
	mux2 outmux(low, hi, s[1], y);
endmodule
/* 
В 12-битном четырехразрядном мультиплексоре 
надо переопределить ширину входов с помощью конструкции '#'
здесь #(12) - параметр width = 12

Не путайте между:
- #12 : задержка 12
- #(12): параметр width = 12 
*/
module mux4_12
	(
	input logic [11:0] d0, d1, d2, d3,
	input logic [1:0] s,
	output logic [11:0] y
	);
	
	logic [11:0] low, hi;
	
	mux2 #(12) lowmux(d0, d1, s[0], low);
	mux2 #(12) himux(d2, d3, s[0], hi);
	mux2 #(12) outmux(low, hi, s[1], y);
endmodule

	