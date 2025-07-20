/* Регистры с сигналом разрешения */
module flopenr
(
input logic 				clk,
input logic					reset,
input logic					en,
input logic	 [3:0]			d,
input logic  [3:0]			q
);

	// Асинхронный сброс
	// регистр сохраняет предыдущее значение если reset и en принимают значени 'FALSE'
	always_ff @(posedge clk, posedge reset)
		if (reset) 		q <= 4'b0;
		else if (en)	q <= d;
		
endmodule