/* D-защелка */
module latch
(
input logic 			clk,
input logic  [3:0]		d,
output logic [3:0]		q
);

	always_latch
		if (clk) 	q <= d;
	/*
		always_latch = always @(clk, d) и оптимально для описания
		защелки на SystemVerilog.
		
		always_latch вычисляется при каждом изменении 'clk' или 'd'
		
		q принимает d при высоком уровне clk, в противном случае q сохраняет свое значение
	*/
endmodule