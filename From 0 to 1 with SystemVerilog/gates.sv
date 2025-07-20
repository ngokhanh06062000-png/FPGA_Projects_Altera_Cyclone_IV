module gates 
(
input logic [3:0] a, b,
output logic [3:0] y1, y2, y3, y4, y5
);

/* 5 разных двухвходовых ЛЭ на 4-битных шинах */
	assign y1 = a & b;			// AND 
	assign y2 = a | b;			// OR
	assign y3 = a ^ b;			// XOR
	assign y4 = ~(a & b);		// NAND
	assign y5 = ~(a | b);		// NOR
	/* 
	a & b или ~(a | b) - это выражение
	assign y4 = ~(a & b) - это оператор
	assign out = in1 op in2 - оператор непрерывного присваивания
	Когда правая часть меняется тогда левая часть тоже меняется
	Таким образом - непрерывное присваивание является комбинационной логикой
	*/
endmodule 