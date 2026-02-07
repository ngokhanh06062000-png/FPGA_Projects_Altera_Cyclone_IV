module UART_RX_To_7_Seg_Top (
  input  logic i_Clk,        // Clock chính
  input  logic i_UART_RX,    // Tín hiệu UART RX
		
  // 7 đoạn LED cho chữ số hàng chục (upper digit)
  output logic o_Segment1_A,
  output logic o_Segment1_B,
  output logic o_Segment1_C,
  output logic o_Segment1_D,
  output logic o_Segment1_E,
  output logic o_Segment1_F,
  output logic o_Segment1_G,
  output logic o_DIG1

  // 7 đoạn LED cho chữ số hàng đơn vị (lower digit)
  output logic o_Segment2_A,
  output logic o_Segment2_B,
  output logic o_Segment2_C,
  output logic o_Segment2_D,
  output logic o_Segment2_E,
  output logic o_Segment2_F,
  output logic o_Segment2_G,
  output logic o_DIG2
);

  //===============================//
  // 1. Tín hiệu trung gian        //
  //===============================//
  logic        w_RX_DV;
  logic [7:0]  w_RX_Byte;

  logic w_Segment1_A, w_Segment2_A;
  logic w_Segment1_B, w_Segment2_B;
  logic w_Segment1_C, w_Segment2_C;
  logic w_Segment1_D, w_Segment2_D;
  logic w_Segment1_E, w_Segment2_E;
  logic w_Segment1_F, w_Segment2_F;
  logic w_Segment1_G, w_Segment2_G;

  //===============================//
  // 2. Kết nối UART Receiver       //
  //===============================//
  UART_RX #(
    .CLKS_PER_BIT(217)  // 25 MHz / 115200 baud
  ) UART_RX_Inst (
    .i_Clock     (i_Clk),
    .i_RX_Serial (i_UART_RX),
    .o_RX_DV     (w_RX_DV),
    .o_RX_Byte   (w_RX_Byte)
  );

  //===============================//
  // 3. Hiển thị hàng chục (digit 1) //
  //===============================//
  Binary_To_7Segment SevenSeg1_Inst (
    .i_Clk         (i_Clk),
    .i_Binary_Num  (w_RX_Byte[7:4]),  // nibble cao (digit hàng chục)
    .o_Segment_A   (w_Segment1_A),
    .o_Segment_B   (w_Segment1_B),
    .o_Segment_C   (w_Segment1_C),
    .o_Segment_D   (w_Segment1_D),
    .o_Segment_E   (w_Segment1_E),
    .o_Segment_F   (w_Segment1_F),
    .o_Segment_G   (w_Segment1_G)
  );

  // Đảo ngược từng bit để điều khiển LED âm cực chung
  assign o_Segment1_A = ~w_Segment1_A;
  assign o_Segment1_B = ~w_Segment1_B;
  assign o_Segment1_C = ~w_Segment1_C;
  assign o_Segment1_D = ~w_Segment1_D;
  assign o_Segment1_E = ~w_Segment1_E;
  assign o_Segment1_F = ~w_Segment1_F;
  assign o_Segment1_G = ~w_Segment1_G;

  //===============================//
  // 4. Hiển thị hàng đơn vị (digit 2) //
  //===============================//
  Binary_To_7Segment SevenSeg2_Inst (
    .i_Clk         (i_Clk),
    .i_Binary_Num  (w_RX_Byte[3:0]),  // nibble thấp (digit hàng đơn vị)
    .o_Segment_A   (w_Segment2_A),
    .o_Segment_B   (w_Segment2_B),
    .o_Segment_C   (w_Segment2_C),
    .o_Segment_D   (w_Segment2_D),
    .o_Segment_E   (w_Segment2_E),
    .o_Segment_F   (w_Segment2_F),
    .o_Segment_G   (w_Segment2_G)
  );

  // Đảo ngược từng bit để điều khiển LED âm cực chung
  assign o_Segment2_A = ~w_Segment2_A;
  assign o_Segment2_B = ~w_Segment2_B;
  assign o_Segment2_C = ~w_Segment2_C;
  assign o_Segment2_D = ~w_Segment2_D;
  assign o_Segment2_E = ~w_Segment2_E;
  assign o_Segment2_F = ~w_Segment2_F;
  assign o_Segment2_G = ~w_Segment2_G;

endmodule
