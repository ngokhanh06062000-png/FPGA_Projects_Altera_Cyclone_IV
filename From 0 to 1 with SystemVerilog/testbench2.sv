module testbench2();

	logic a, b, c, y;
	// задание (определение) тестируемого устройства
	sillyfunction dut(a, b, c, y);
	// активировать входы пошагово, 
	// с интервалом для проверки результатов 
	initial begin
		a = 0; b = 0; c = 0; #10;
		assert (y === 1) else $error("000 failed.");
		c = 1; #10;
		assert (y === 0) else $error("001 failed.");
		b = 1; c = 0; #10;
		assert (y === 0) else $error("011 failed.");
		c = 1; #10;
		assert (y === 0) else $error("011 failed.");
		a = 1; b = 0; c = 0; #10;
		assert (y === 1) else $error("100 failed.");
		c = 1; #10;
		assert (y === 1) else $error("101 failed.");
		b = 1; c = 0; #10;
		assert (y === 0) else $error("110 failed.");
		c = 1; #10;
		assert (y === 0) else $error("111 failed.");
	end
	/*
	Оператор 'assert' проверяет указанное условие, 
	если нет то выполняет оператор 'else'
	
	Системная процедура $error - печает сообщение об ошибке с указанием
	нарушенного условия
	
	В Systemverilog сравнение с помощью == и != работает для сигналов, 
	которые не принимает значения x и z.
	А Тестбенч использует операторы '===' и '!==' для сравнений на равенство 
	и неравенство, потому что эти операторы работают также с операндами = x или z
	*/
endmodule
		