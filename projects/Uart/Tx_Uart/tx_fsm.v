module tx_fsm (
    input wire baud_clk,
    input wire rst,
    input wire tx_start,
    output reg tx_load_en,
    output reg tx_busy
);
    reg [3:0] count;
    reg [1:0] state;

    // Define states
    localparam IDLE  = 2'b00;
    localparam SHIFT = 2'b01;

    always @(posedge baud_clk) begin
        if (rst) begin
            state <= IDLE;
            tx_load_en <= 1'b0;
            tx_busy <= 1'b0;
            count <= 4'b0;
        end else begin
            case (state)
                IDLE: begin
                   count <= 1'b0;
                    tx_load_en <= 1'b1;
                    //tx_busy <= 1'b0;
                    if (tx_start==1'b1) begin
                        state <= SHIFT;
                        tx_busy <= 1'b1;
                    end else begin
                        tx_busy <= 1'b0;
                        state <= IDLE;
                    end
                end


                SHIFT: begin
                    tx_load_en <= 1'b0;
                    if (count == 4'd11) begin
                        count <= 4'b0;
                        tx_busy <= 1'b0;
                        state <= IDLE;
                    end else begin
                        count <= count + 1'b1;
                        tx_busy <= 1'b1;
                    end
                end
                
                 /*SHIFT: begin
                    tx_load_en <= 1'b0;
                    if (count <= 4'd11) begin
                        count <= count + 1'b1;
                        tx_busy <= 1'b1;
                    end else begin
                        count <= 4'b0;
                        tx_busy <= 1'b0;
                        state <= IDLE;
                        
                    end
                end*/

                
                default: begin
            
                    state <= IDLE;
                end
            endcase
        end
    end
endmodule
