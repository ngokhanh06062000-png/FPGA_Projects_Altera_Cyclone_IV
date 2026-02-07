// FREQ  - desired clk frequency
// clk_o - clock with frequency = FREQ

module custom_clk #(
  parameter FREQ     = 1000,
            MAX_VAL  = 50000000/FREQ,
            WIDTH    = $clog2(MAX_VAL) + 1
)
(
  input  logic clk_i,
  input  logic rst,
  
  output logic clk_o 
);

logic [WIDTH - 1:0] cnt;

always_ff @ (posedge clk_i or posedge rst)
  if (rst)
    cnt <= 'b0;
  else if (cnt == MAX_VAL)
	 cnt <= 'b0;
  else
    cnt <= cnt + 1'b1;
		
assign clk_o = (cnt == MAX_VAL);


endmodule