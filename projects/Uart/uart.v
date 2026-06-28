module uart(
 input rx_in,
input sys_clk,
input rst,
input tx_fifo_en,
input rx_ready,
output tx_out,
output rx_fifo_empty,
output tx_fifo_full
);

 assign tx_wr_en = ~tx_fifo_full & tx_fifo_en;
 assign rx_rd_en = ~rx_fifo_empty & rx_ready;
 assign tx_fifo_in = rx_fifo_out;
 wire baud9600;
 wire baud_clk16;
 wire [7:0]tx_fifo_in;
 wire [7:0]rx_fifo_out;


	 pll_baud my_pll (
       .inclk0(sys_clk), 
       .c0(baud_clk16),
		 .c1(baud9600)

    );
	 
	tx_uart tx_uart_uut(
		 .fifo_in(tx_fifo_in),
		 .tx_out(tx_out),
		 .sys_clk(sys_clk),
		 .baud_clk9600(baud9600),
		 .tx_fifo_en(tx_wr_en),
		 .tx_fifo_full(tx_fifo_full),
		 .rst(rst)
	);
	
	rx_uart rx_uart_uut(
		 .rx_in(rx_in),
		 .sys_clk(sys_clk),
		 .rx_ready(rx_rd_en),
		 .rx_baud_clk(baud9600),
		 .baud_clk16(baud_clk16),
		 .rst(rst),
		 .rx_fifo_empty(rx_fifo_empty),
		 .rx_fifo_out(rx_fifo_out)

	);

//	end
endmodule