module rx_uart(
input sys_clk,
input rst,
input rx_in,
input rx_ready,
input rx_baud_clk,
input baud_clk16,
output [7:0]fifo_in_data,
output wire rx_parity_check,
output fifo_wren,
output [7:0] rx_fifo_out,
output rx_fifo_empty,
output sys,
output ready,
output read_ack,
output [1:0] state,
output [3:0]count

); 
    wire parity_out;
	 wire [10:0] rsr_data_out;
	 assign sys=sys_clk;
    wire wr_en;
	 wire q;
	 wire first_bit;
    wire rx_fifo_full;
	 assign ready=rx_ready;
    assign wr_en = (q & ~rx_fifo_full);

	 /*pLL9600 baud (
		.inclk0(sys_clk),
	   .c0(rx_baud_clk)
	 );
	 
	 pLL9600X16 my_pll (
        .inclk0(sys_clk), 
        .c0(baud_clk16) 
    );*/
	 
	 pulse16 pulse_uut(
        .baud_clk(baud_clk16),
        .rst(rst),
        .pulse(fifo_wren),
        .q(q)
    );
	 

//	rx_baud_generator baud16 (
//		.clk(rx_baud_clk),      // Input clock (e.g., 50 MHz)
//		.rst(rst),      // Reset signal
//		.baud_clk16(baud_clk16)  // Output baud clock (9600 Hz)
//   );

  
	     // Shift register instance
    rx_shift_register rsr_uut (
        .baud_clk(rx_baud_clk),
        .rst(rst),
        .data_in(rx_in),
        .data_out(rsr_data_out),
		  .first_bit(first_bit)
    );


    // Parity checker instance
    rx_parity rx_parity_uut (
        .din(rsr_data_out),
        .rx_parity_check(rx_parity_check)
    );

    // FIFO instance
    rx_fifo rx_fifo_uut (
        .sys_clk(sys_clk),
        .baud_clk(rx_baud_clk),
        .rst(rst),
        .wr_en(wr_en),
        .rd_en(rx_ready),
        .din(fifo_in_data),
        .dout(rx_fifo_out),
        .full(rx_fifo_full),
        .empty(rx_fifo_empty),
		  .read_ack(read_ack)
    );

    // FSM instance
   
	 rx_fsm rx_fsm_uut (
        .baud_clk16(baud_clk16),
        .rst(rst),
        .rx_in(first_bit),
        .rx_parity_in(rx_parity_check),
        .fifo_wren(fifo_wren),
        .data_fsm(rsr_data_out),
        .temp_data(fifo_in_data),
		  .state(state),
		  .count(count)
    );
  
endmodule
