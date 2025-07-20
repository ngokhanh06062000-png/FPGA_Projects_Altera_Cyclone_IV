/* Синхронизатор */
module sync 
(
input logic 		clk,
input logic			d,
output logic 		q
);

	logic n1;
	always_ff @(posedge clk)
		begin
			n1 <= d;  // неблокирующее присваивание
			q  <= n1; // неблокирующее присваивание
		end
	/* 
		Конструкция begin/end: Операторные скобки 
		для группы из нескольких операторов внутри оператора 'always'
	*/ 
endmodule