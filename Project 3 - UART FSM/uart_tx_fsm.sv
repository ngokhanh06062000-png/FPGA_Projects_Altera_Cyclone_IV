module uart_tx_fsm
#(
  parameter F_SIZE = 8,
	    BC_SIZE = $clog2(F_SIZE) + 1
)
(
  input  logic 			clk,
  input  logic			rst,
  input  logic 			start_i,
  input  logic [F_SIZE - 1:0]	tx_data,

  output logic			tx,
  output logic 			end_o
);

logic [BC_SIZE - 1:0] 		bit_cnt;

typedef enum {
  IDLE,
  START,
  TRANSMIT,
  STOP
} state_t;

state_t state, next_state;

always_ff @ (posedge clk or posedge rst)
  if (rst)
    state <= IDLE;
  else 
    state <= next_state;

always_ff @ (posedge clk or posedge rst)
  if (rst)
    bit_cnt <= 'b0;
  else 
    if (state != TRANSMIT)
	bit_cnt <= 'b0;
    else 
	bit_cnt <= bit_cnt + 1'b1;

always_comb begin
  case (state)
	IDLE: 
		if (start_i)
			next_state = START;
		else 
			next_state = IDLE;

	START:
		next_state = TRANSMIT;

	TRANSMIT:
		if (bit_cnt == (F_SIZE - 1))
			next_state = STOP;
		else 
			next_state = TRANSMIT;

	STOP:
		next_state = IDLE;
	
	default:
		next_state = IDLE;

  endcase
end

/* tx */
always_comb begin
  case (state)
	IDLE:
		tx = 'b1;

	START:
		tx = 'b0;

	TRANSMIT:
		tx = tx_data[bit_cnt];
	
	STOP:
		tx = 'b1;
	
	default:
		tx = 'b1;
  endcase 
end

assign end_o = (state == STOP);
	
