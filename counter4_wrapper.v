module counter4_wrapper (
  input  wire        clk,
  input  wire        rst_n,
  input  wire        en,
  output wire [3:0]  count_out
);

  // Gọi module DUT (counter4) trực tiếp, không register lại tín hiệu clock/reset/en
  counter4 dut (
    .clk       (clk),
    .rst_n     (rst_n),
    .en        (en),
    .count_out (count_out)
  );

endmodule
