module fulladder
(
input logic a, b, cin,
output logic s, cout
);

	logic p, q;
	
	always_comb
		begin
			p = a ^ b;				// блокирующее
			g = a & b;				// блокирующее
			s = p ^ cin;			// блокирующее
			cout = g | (p & cin);	// блокирующее
		end
endmodule