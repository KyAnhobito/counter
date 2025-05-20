`timescale 1ns/10ps

module counter4_tb;

  // Tín hiệu kiểm tra
  reg        clk;
  reg        rst_n;
  reg        en;
  wire [3:0] count_out;

  // Khởi tạo module cần test (DUT)
  counter4 dut (
    .clk       (clk),
    .rst_n     (rst_n),
    .en        (en),
    .count_out (count_out)
  );

  // Tạo clock 10ns
  always #5 clk = ~clk;

  initial begin
    // Khởi tạo giá trị
    clk    = 0;
    rst_n  = 0;
    en     = 0;

    // Reset toàn cục
    #12 rst_n = 1;

    // Bật enable và bắt đầu đếm
    #10 en = 1;

    // Cho đếm trong vài chu kỳ
    #100;

    // Tắt enable
    en = 0;

    // Quan sát giữ giá trị
    #40;

    // Reset lại
    rst_n = 0;
    #10 rst_n = 1;

    // Bật enable lại
    #10 en = 1;

    // Đếm tiếp
    #60;

    // Kết thúc mô phỏng
    $finish;
  end

  // Ghi log ra màn hình
  initial begin
    $display("Time\tclk\trst_n\ten\tcount_out");
    $monitor("%0t\t%b\t%b\t%b\t%h", $time, clk, rst_n, en, count_out);
  end

endmodule
