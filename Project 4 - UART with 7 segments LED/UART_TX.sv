module UART_TX 
  #(parameter CLKS_PER_BIT = 217)
  (
   input  logic       i_Rst_L,       // Active-low reset
   input  logic       i_Clock,       // System clock
   input  logic       i_TX_DV,       // Data valid signal, starts transmission
   input  logic [7:0] i_TX_Byte,     // Byte to transmit
   output logic       o_TX_Active,   // Indicates on going transmission
   output logic       o_TX_Serial,   // UART serial output
   output logic       o_TX_Done      // Indicates transmission completed
   );
 
  // State definitions for state machine
  typedef enum logic [1:0] {
    IDLE         = 2'b00,
    TX_START_BIT = 2'b01,
    TX_DATA_BITS = 2'b10,
    TX_STOP_BIT  = 2'b11
  } state_t;

  state_t r_SM_Main;                                 // State machine current state
  logic [$clog2(CLKS_PER_BIT)-1:0] r_Clock_Count;    // Clock cycle counter
  logic [2:0] r_Bit_Index;                           // Index for data bits transmission
  logic [7:0] r_TX_Data;                             // Data byte storage during transmission

  // State machine handling UART transmission logic
  always_ff @(posedge i_Clock or negedge i_Rst_L) begin
    if (!i_Rst_L) begin
      r_SM_Main      <= IDLE;
      o_TX_Serial    <= 1'b1;                        // Idle UART line high
      o_TX_Active    <= 1'b0;
      o_TX_Done      <= 1'b0;
      r_Clock_Count  <= '0;
      r_Bit_Index    <= '0;
      r_TX_Data      <= '0;
    end else begin
      o_TX_Done <= 1'b0;

      case (r_SM_Main)
        IDLE : begin
          o_TX_Serial <= 1'b1;                       // UART line idle state
          r_Clock_Count <= '0;
          r_Bit_Index <= '0;

          if (i_TX_DV) begin                         // Start bit triggered by data valid signal
            o_TX_Active <= 1'b1;
            r_TX_Data <= i_TX_Byte;
            r_SM_Main <= TX_START_BIT;
          end
        end

        TX_START_BIT : begin
          o_TX_Serial <= 1'b0;                       // Start bit is logic low
          if (r_Clock_Count < CLKS_PER_BIT - 1) begin
            r_Clock_Count <= r_Clock_Count + 1;
          end else begin
            r_Clock_Count <= '0;
            r_SM_Main <= TX_DATA_BITS;
          end
        end

        TX_DATA_BITS : begin
          o_TX_Serial <= r_TX_Data[r_Bit_Index];     // Transmit each data bit sequentially
          if (r_Clock_Count < CLKS_PER_BIT - 1) begin
            r_Clock_Count <= r_Clock_Count + 1;
          end else begin
            r_Clock_Count <= '0;
            if (r_Bit_Index < 7) begin               // Continue transmitting remaining bits
              r_Bit_Index <= r_Bit_Index + 1;
            end else begin                           // All bits transmitted, move to stop bit
              r_Bit_Index <= '0;
              r_SM_Main <= TX_STOP_BIT;
            end
          end
        end

        TX_STOP_BIT : begin
          o_TX_Serial <= 1'b1;                       // Stop bit is logic high
          if (r_Clock_Count < CLKS_PER_BIT - 1) begin
            r_Clock_Count <= r_Clock_Count + 1;
          end else begin
            o_TX_Done <= 1'b1;                       // Transmission completed
            r_Clock_Count <= '0;
            r_SM_Main <= IDLE;                       // Return to idle state
            o_TX_Active <= 1'b0;
          end
        end

        default : r_SM_Main <= IDLE;
      endcase
    end
  end
endmodule