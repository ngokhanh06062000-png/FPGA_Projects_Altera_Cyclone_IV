module tb_rx;

parameter F_SIZE  = 8;
localparam BC_SIZE = 4;
parameter FREQ    = 1000000;


logic                clk;
logic                rst;
logic                rx;

logic [F_SIZE - 1:0] rx_data;
logic                end_o;

logic [2:0]           next_state_d, state_d;
logic [BC_SIZE - 1:0] bit_cnt_d;
logic                 zero_flag_d, slow_clk_d;
logic [6:0] div_cnt_d;


uart_rx_fsm #(.FREQ(FREQ), .F_SIZE(F_SIZE)) 
  dut (.*);

always begin
  clk = ~clk;
  #1;
end

logic [7:0] tx_byte;
assign tx_byte = 'haa;


initial begin
  clk = 'b0;
  rst = 'b0;
  rx  = 'b1;
  
  #1;
  rst = 'b1;
  #1;
  rst = 'b0;
  
  #2;
  rx = 'b0;
  #100;
  rx = tx_byte[0];
  #100;
  rx = tx_byte[1];
  #100;
  rx =  tx_byte[2];
  # 100;
  rx =  tx_byte[3];
  # 100;
  rx =  tx_byte[4];
  # 100;
  rx =  tx_byte[5];
  # 100;
  rx =  tx_byte[6];
  # 100;
  rx =  tx_byte[7];
  # 100;
  rx = 1'b1;
  
  #1000000;
  $finish;
  
end
  
  
  
endmodule
  