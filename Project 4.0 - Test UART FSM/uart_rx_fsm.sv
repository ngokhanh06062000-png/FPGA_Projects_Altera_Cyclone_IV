module uart_rx_fsm
#(
  parameter F_SIZE   = 8,
            BC_SIZE  = $clog2(F_SIZE) + 1,
            FREQ     = 9600,
				MAX_VAL  = 50000000/FREQ,
            DC_WIDTH = $clog2(MAX_VAL) + 1
)
(
  input  logic                clk,
  input  logic                rst,
  input  logic                rx,
  
  output logic [F_SIZE - 1:0] rx_data,
  output logic                end_o
  
  // for debug
  ,
  output logic [1:0]           next_state_d, state_d,
  output logic [DC_WIDTH - 1:0] div_cnt_d,
  output logic [BC_SIZE - 1:0] bit_cnt_d,
  output logic                 zero_flag_d, slow_clk_d
);



typedef enum {
  IDLE,
  CHECK,
  //START,
  TRANSMIT,
  STOP
} state_t;

state_t state, next_state;


always_ff @ (posedge clk or posedge rst)
  if (rst)
    state <= IDLE;
  else
    state <= next_state;



// dividing sysclock to get needed baudrate in slow_clk;
// starting the slow_clk when the zero_flag == 'b0
// (to sample rx bits in the middle of their cycle)
logic [DC_WIDTH - 1:0] div_cnt;
logic                  slow_clk, zero_flag;

always_ff @ (posedge clk or posedge rst)
  if (rst)
    div_cnt <= 'b0;
	 
  else if (div_cnt == MAX_VAL)
	 div_cnt <= 'b0;
	 
  else if (zero_flag)
	 div_cnt <= 'b0;

  else
    div_cnt <= div_cnt + 1'b1;


assign slow_clk = (div_cnt == MAX_VAL);



// rx bits counter
logic [BC_SIZE - 1:0] bit_cnt;
always_ff @ (posedge slow_clk or posedge rst)
  if (rst)
    bit_cnt <= 'b0;
	 
  else if (state != TRANSMIT)
	 bit_cnt <= 'b0;
	 
  else
    bit_cnt <= bit_cnt + 1'b1;

	 

always_comb begin
  case (state)
    IDLE:
	   begin
			if (~rx)
			  begin
				  zero_flag  = 'b1;    // if rx becomes 0, reset the slck counter
				  next_state = CHECK;
			  end
			else
			  begin
				  zero_flag  = 'b1;
				  next_state = IDLE;
			  end
		end
		
    CHECK:                          // zero_flag goes down,
	   begin                         // div_cnt counts till the middle			
			if (div_cnt == MAX_VAL/2)  // of possible "start" signal
			  if (~rx)
			    begin
					 zero_flag  = 'b1;
					 next_state = TRANSMIT;
				 end
			  else
			    begin
					 zero_flag  = 'b1;
					 next_state = IDLE;
				 end
			else
			  begin
				  zero_flag = 'b0;
				  next_state = CHECK;
			  end
		end
   
	TRANSMIT:
	  begin
	    zero_flag  = 'b0;
		 
	    if (bit_cnt == F_SIZE)
		   next_state = STOP;
		 else
		   next_state = TRANSMIT;
	  end
	 
    STOP:
	   begin
		  zero_flag  = 'b0;
		  next_state = IDLE;
		end
	 
    default:
	   begin
		  zero_flag  = 'b1;
	     next_state = IDLE;
		end
  endcase
end



always_ff @ (posedge slow_clk or posedge rst)
  if (rst)
    rx_data          <= 'b0;
  else
    rx_data[bit_cnt] <= rx;


	 
assign end_o = (state == STOP);


// for debug
assign next_state_d = next_state;
assign state_d      = state;
assign bit_cnt_d    = bit_cnt;
assign zero_flag_d  = zero_flag;
assign slow_clk_d   = slow_clk;
assign div_cnt_d    = div_cnt;

endmodule	 