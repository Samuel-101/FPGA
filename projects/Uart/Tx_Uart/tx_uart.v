
module tx_uart(
input tx_fifo_en,
input [7:0] fifo_in,
input baud_clk9600,
input rst,
input sys_clk,
output tx_out,
output tx_fifo_full,
output bd
);


assign bd = baud_clk9600;
wire txfifo_empty;
wire [7:0]fifo_out;
wire tx_start;
wire parity_out;
wire tx_busy;
wire tx_load_en;

assign tx_start = ~(txfifo_empty) & ~(tx_busy);

	 
tx_fifo tx_fifo_uut (
    .sys_clk(sys_clk),
    .baud_clk(baud_clk9600),
    .rst(rst),
    .rd_en(tx_start),
    .wr_en(tx_fifo_en),
    .din(fifo_in),
    .dout(fifo_out),
    .full(tx_fifo_full),
    .empty(tx_fifo_empty)
  );

tx_shift_register tsr_uut(

     .baud_clk(baud_clk9600),
        .rst(rst),
        .data_in(fifo_out),
        .tx_load_en(tx_load_en),
        .parity_bit(parity_out),
        .data_out(tx_out)
);

tx_parity parity_uut(

    .din(fifo_out),
    .parity_check(parity_out)
);

tx_fsm uut (
        .baud_clk(baud_clk9600),
        .rst(rst),
          .tx_start(tx_start),
          .tx_load_en(tx_load_en),
          .tx_busy(tx_busy)
    );



endmodule

