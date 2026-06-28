
module tx_shift_register (
    input baud_clk,
    input rst,
    input [7:0] data_in,
    input tx_load_en,
    input parity_bit,
    output reg data_out
);

    reg [10:0] q;

    always @(posedge baud_clk) begin
        if (rst) begin
            q <= 11'b0;
        end else begin
            if (tx_load_en) begin
                q[0] <= 1'b0;
                q[8:1] <= data_in;
                q[9] <= parity_bit;
                q[10] <= 1'b1;
            end else begin
                data_out <= q[0];
                q <= {1'b1, q[10:1]};
            end
        end
    end
endmodule
