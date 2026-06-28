module rx_fsm(
    input wire baud_clk16,
    input wire rst,
    input wire rx_in,
    input wire rx_parity_in,
    input [10:0] data_fsm,
    output reg [7:0] temp_data,
    output reg fifo_wren,
	 output reg [1:0]state,
	 output reg [3:0]count
);

    reg rx_paritychk;
    reg rx_stopchk;
    reg [3:0] sample_counter;
    

    localparam IDLE   = 2'b00;
    localparam DATA   = 2'b01;
    localparam PARITY = 2'b10;
    localparam STOP   = 2'b11;

    always @(posedge baud_clk16 or posedge rst) begin
        if (rst) begin
            state <= IDLE;
            count <= 4'b0;
            sample_counter <= 3'b0;
            rx_paritychk <= 1'b0;
            fifo_wren <= 1'b0;
           temp_data <=7'b0;
        end else begin
            case (state)
                IDLE: begin
                    fifo_wren <= 1'b0;
                    if (~rx_in) begin
                        if (sample_counter == 4'b1000) begin
                            sample_counter <= 4'b0000;
                            state <= DATA;
                            count <= 4'b0;
                        end else begin
                            sample_counter <= sample_counter + 1'b1;
                        end
                    end else begin
                        sample_counter <= 4'b0;
                        state <= IDLE;
                    end
                end
                DATA: begin
                    if (sample_counter == 4'b1111) begin
                        sample_counter <= 4'b0000;
                        if (count == 4'd7) begin
                            count <= 4'b0;
                            state <= PARITY;
                        end else begin
                            count <= count + 1'b1;
                        end
                    end else begin
                        sample_counter <= sample_counter + 1'b1;
                    end
                end
                PARITY: begin
                    if (sample_counter == 4'b1111) begin
                        sample_counter <= 4'b0000;
                        if (rx_in == rx_parity_in) begin
                            state <= STOP;
                            rx_paritychk <= 1'b1;
                        end else begin
                            state <= STOP;
                            rx_paritychk <= 1'b0;
                        end
                    end else begin
                        sample_counter <= sample_counter + 1'b1;
                    end
                end
                STOP: begin
                    if (sample_counter == 4'b1111) begin
                        sample_counter <= 4'b0000;
                        if (rx_in) begin
                            state <= IDLE;
                            temp_data <= data_fsm[8:1];
                            fifo_wren <= rx_paritychk;
                        end else begin
                            fifo_wren <= 1'b0;
                            state <= IDLE;
                        end
								
                    end else begin
                        sample_counter <= sample_counter + 1'b1;
                    end
                end
                default: state <= IDLE; 
            endcase
        end
    end
endmodule
