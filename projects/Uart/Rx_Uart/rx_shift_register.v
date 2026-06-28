module rx_shift_register (
    input baud_clk,
    input rst,
    input data_in,
    output [10:0] data_out,
	output first_bit
);
assign first_bit=data_out[10];
    reg [10:0] q;

    // Assign outputs from the shift register
    assign data_out = q[10:0];

    // Shift operation
    always @(posedge baud_clk or posedge rst ) begin
        if (rst) begin
            q <= 11'b11111111111; // Set q to all 1s immediately on reset
        end else begin
            q <= {data_in, q[10:1]}; // Shift in the new bit
           
        end
    end

endmodule