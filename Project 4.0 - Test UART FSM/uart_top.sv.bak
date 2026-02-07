module uart_top
#(
  parameter FREQ    = 9600,
            DC_SIZE = 50000000/FREQ, // dividing counter size
            F_NUM   = 13,            // number of tx frames
				F_SIZE  = 8,             // size of data in frame
				FC_SIZE = $clog2(F_NUM),  // size of frame counter frame
				RX_SIZE = 32,
				RC_SIZE = $clog2(RX_SIZE)
)
(
  input  logic clk,
  input  logic rst_n,
  input  logic rx,
  
  output logic [3:0] led,
  output logic tx
  
  /*
  //for debug
  ,
  output logic start_d,
  output logic slow_clk_d,
  output logic [FC_SIZE - 1:0] f_cnt_d,
  output logic [7:0] tx_data_d,
  output logic end_d,
  output logic [1:0] state_d, next_state_d,
  output logic [3:0] bit_cnt_d*/
);

logic                 end_o, rst, slow_clk, start_i, end_rx;
logic [3:0]           start_div_cnt;
logic [FC_SIZE - 1:0] f_cnt;
logic [RC_SIZE - 1:0] r_cnt;
logic [F_SIZE - 1:0]  tx_data, rx_data;

logic [F_SIZE - 1:0]  tx_mem [0:F_NUM - 1];   // bytes which will be transfered
logic [F_SIZE - 1:0]  rx_mem [0:RX_SIZE - 1]; // rx bytes


assign rst = ~rst_n;


//---------------TX LOGIC--------------------
	 
// slow clock for needed baud rate

custom_clk #(.FREQ(FREQ))
  sclk (
    clk,
	 rst,
	 
	 slow_clk
  );

  
// start of new frame signal
always_ff @ (posedge slow_clk or posedge rst)
  if (rst)
    start_div_cnt <= 'b0;
  else
    start_div_cnt <= start_div_cnt + 1'b1;
	 
assign start_i = (start_div_cnt == 'b0);



// transfered frames counter	 
always_ff @ (posedge slow_clk or posedge rst)
  if (rst)
    f_cnt <= 'b0;
  else if (end_o)
    f_cnt <= f_cnt + 1'b1;
	 
	 

uart_tx_fsm #( .F_SIZE(F_SIZE) )
  fsm_inst (
    slow_clk,
	 rst,
	 start_i,
	 tx_data,
	 
	 tx,
	 end_o
	 
	 /*
	 // for debug
	 ,
	 state_d, next_state_d, bit_cnt_d*/
  );


/*
assign tx_mem[0] = 'h66; // F
assign tx_mem[1] = 'h70; // P
assign tx_mem[2] = 'h67; // G
assign tx_mem[3] = 'h61; // A
*/

assign tx_mem[0] = 'h4f; // O
assign tx_mem[1] = 'h6e; // n
assign tx_mem[2] = 'h6c; // l
assign tx_mem[3] = 'h79; // y
assign tx_mem[4] = 'h20; //  
assign tx_mem[5] = 'h53; // S
assign tx_mem[6] = 'h63; // c
assign tx_mem[7] = 'h69; // i
assign tx_mem[8] = 'h65; // e
assign tx_mem[9] = 'h6e; // n
assign tx_mem[10] = 'h63; // c
assign tx_mem[11] = 'h65; // e
assign tx_mem[12] = 'h0a; // \n
  
  
// current tx frame
assign tx_data = tx_mem[f_cnt];

// led turns off when transmitting starts
assign led[0] = start_i;




//---------------RX LOGIC--------------------

// received frames counter	 
always_ff @ (posedge clk or posedge rst)
  if (rst)
    r_cnt <= 'b0;
  else if (end_rx)
    r_cnt <= r_cnt + 1'b1;
	 

// writing received frame into rx_mem
int i;
always_ff @ (posedge clk or posedge rst)
  if (rst) begin
    for (i = 0; i < RX_SIZE; i++)
	   rx_mem[i] <= 'b0;
  end
  
  else if (end_rx)
    rx_mem[r_cnt] <= rx_data;

	
// for debug	
logic [2:0] next_state_d, state_d;
logic [3:0] bit_cnt_d;
logic       zero_flag_d, slow_clk_d;

uart_rx_fsm #( .F_SIZE(F_SIZE), .FREQ(FREQ) )
  rx_fsm (
    clk,
	 rt,
	 rx,
	 
	 rx_data,
	 end_rx,
	 
	 // for debug
	 next_state_d, state_d,
	 bit_cnt_d,
	 zero_flag_d, slow_clk_d
  );
	 
	 
	 

assign led[3:1] = 3'b111;


/*
// for debug
assign start_d = start_i;
assign slow_clk_d = slow_clk;
assign f_cnt_d = f_cnt;
assign tx_data_d = tx_data;
assign end_d = end_o;
*/

endmodule