module sillyfunction 
(
input logic a, b, c,	// Входы с типом logic: 0 or 1

output logic y			// Выход с типом logic: 0 or 1
); 
	assign y = ~a & ~b & ~c | a & ~b & ~c | a & ~b & c;  // Описание комбинационную логику
	/*
	~ - NOT (НЕ)
	& - AND (И)
	| - OR  (ИЛИ)
	*/
	
endmodule
