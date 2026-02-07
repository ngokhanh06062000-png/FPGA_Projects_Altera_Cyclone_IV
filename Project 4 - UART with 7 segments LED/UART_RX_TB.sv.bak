`timescale 1ns/10ps

module UART_RX_TB();

	// config parameter for testbench

	parameter int c_CLOCK_PERIOD_NS = 20;
	parameter int c_CLKS_PER_BIT = 438;
	parameter int c_BIT_PERIOD = 8600;

	// Signals for testbench
	logic r_Clock = 0;
	logic r_RX_Serial = 1;
	logic [7:0] w_RX_Byte;
	logic       w_RX_DV;
	// Clock generator 
	always #(c_CLOCK_PERIOD_NS/2) r_Clock <= !r_Clock;

	// Task transmit 1 byte UART
	task automatic UART_WRITE_BYTE (input byte i_Data);
		// Transmit bit start (0)
		r_RX_Serial <= 0;
		#(c_BIT_PERIOD);
    
		// Transmit 8 bits of data (LSB first)
		foreach (i_Data[j]) begin
			r_RX_Serial <= i_Data[j];
			#(c_BIT_PERIOD);
		end
    
		// Transmit bit stop (1)
		r_RX_Serial <= 1;
		#(c_BIT_PERIOD);
	endtask

	// Connect with DUT (UART_RX)

	UART_RX #( 
	.CLKS_PER_BIT(c_CLKS_PER_BIT)
	) DUT (
		.i_Clock 		(r_Clock),
		.i_RX_Serial (r_RX_Serial),
		.o_RX_DV		(w_RX_DV),
		.o_RX_Byte	 (w_RX_Byte)
	);

	// Test logic
	initial begin
		// Wait 1 period of clock
		repeat (5) @(posedge r_Clock);
	
		// transmit 1 byte of data UART
		UART_WRITE_BYTE(8'h37); // Transmit '7'
	
		// Waiting for signal o_RX_DV = 1 from DUT
		wait (w_RX_DV == 1);
		@(posedge r_Clock);
	
		// Check result
		if (w_RX_Byte == 8'h37)
			$display ("Test passed - Correct Byte Received: %h", w_RX_Byte);
		else 
			$display ("Test failed - Incorrect Byte Received: %h", w_RX_Byte);
		
		$finish;
	end

	// DUMP signals
	initial begin 
		$dumpfile("uart_rx_tb.vcd");
		$dumpvars(0, UART_RX_TB);
	end

endmodule