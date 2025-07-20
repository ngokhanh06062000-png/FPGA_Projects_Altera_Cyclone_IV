module fulladder
(
input logic a, b, cin,
output logic s, cout
);
	
	logic p, g;
	
	assign p = a ^ b;
	assign g = a & b;
	
	assign s = p ^ cin;
	assign cout = g | (p & cin);
	/*
	cout = S = А xor B xor Cin - полный сумматор
	p = A xor B
	g = А and B
	s = p xor Cin
	cout = g or (p and cin)
	*/
endmodule

/* Числа в systemverilog */
/*
Запись   кол. битов				основание		значение		представление
3'b101 =     3						2				5				101
'b11		 ?						2				3				0000011
8'b11		 8						2 				3				00000011
8'b1010_1011 8						2				171				10101011
3'd6		 3						10				6				110
6'o42		 6						8				34				100010
8'hAB		 8						16				171				10101011
42			 ?						10				42				000101010
*/
