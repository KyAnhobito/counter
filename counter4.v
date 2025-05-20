module counter4 (
    input  wire        clk,      // clock
    input  wire        rst_n,    // reset ngược (active low)
    input  wire        en,       // enable đếm
    output wire [3:0]  count_out // giá trị đếm ra
);

  // Stage 1 register: tính count_next = count_stage1 + 1 khi en=1
  reg [3:0] count_stage1;
  wire [3:0] count_next = count_stage1 + 4'd1;

  // Stage 2 register: giữ kết quả từ stage1
  reg [3:0] count_stage2;

  // Giai đoạn reset / cập nhật
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      count_stage1 <= 4'd0;
      count_stage2 <= 4'd0;
    end else begin
      // Stage 1: tính và ghi vào reg
      if (en)
        count_stage1 <= count_next;
      else
        count_stage1 <= count_stage1;

      // Stage 2: pipeline – chỉ lấy giá trị đã được tính ở stage1
      count_stage2 <= count_stage1;
    end
  end

  // Xuất ra ngoài từ stage2
  assign count_out = count_stage2;

endmodule
