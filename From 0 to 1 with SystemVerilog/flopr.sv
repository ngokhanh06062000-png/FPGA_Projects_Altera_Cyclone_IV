/* Регистр со сбросом */
module flopr
(
input logic 			clk,
input logic 			reset,
input logic [3:0] 		d,
output logic [3:0] 		q
);

// Асинхронный сброс: Есть в списке чувствительности сигнал posedge reset, 
// поэтому триггер с асинхронным сбросом реагирует на передний фронт reset немедленно
	always_ff @(posedge clk, posedge reset) // = posedge clk or posedge reset
		if(reset) 	q <= 4'b0;
		else		q <= d;

endmodule

module flopr
(
input logic 			clk,
input logic 			reset,
input logic [3:0]		d,
output logic [3:0] 		q
);

// Синхронный сброс: нет сигнала posedge reset
// поэтому триггер с синхронным сбросом реагирует только по переднему фронту такта
	always_ff @(posedge clk)
		if(reset)	q <= 4'b0;
		else 		q <= d;

endmodule

// 2 модуля имеют одно и тоже имя flopr, поэтому в схеме можно использовать либо один либо другой модуль