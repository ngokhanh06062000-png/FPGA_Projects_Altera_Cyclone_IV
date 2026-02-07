module tb;

logic clk;
logic rst_n;
logic rx;
logic tx;
logic start_d, slow_clk_d, end_d;
logic [3:0] bit_cnt_d;
logic [1:0] state_d, next_state_d;
logic [1:0] f_cnt_d;
logic [7:0] tx_data_d;
logic [3:0] led;

uart_top #(.FREQ(12500000))
  dut (.*);
  
always begin
  clk = ~clk;
  #1;
end

logic rst;
assign rst_n = ~rst; 

initial begin
  clk = 'b0;
  rst = 'b0;
  
  #2;
  
  rst = 'b1;
  
  #2;
  
  rst = 'b0;
  
  #2;
  
  #600;
  $finish;
end

endmodule