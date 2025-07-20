module sevenseg 
(
input logic [3:0] data,
output logic [6:0] segments
);
	always_comb 
		case (data)	// case проверяет значение 'data'
		//							  abc_defg
			0: 				segments = 7'b111_1110;  // data = 0
			1:				segments = 7'b011_0000;	 // data = 1
			2:				segments = 7'b110_1101;  // data = 2
			3:				segments = 7'b111_1001;  // data = 3
			4: 				segments = 7'b011_0011;  // data = 4
			5:				segments = 7'b101_1011;  // data = 5
			6: 				segments = 7'b101_1111;  // ....
			7:				segments = 7'b111_0000;  // ....
			8: 				segments = 7'b111_1111;  // ....
			9:				segments = 7'b111_0011;  // ....
			default:		segments = 7'b000_0000;  // ....
		endcase
	// операторы 'case' обязаны находиться внутри операторов 'always'
endmodule
	