module rx_parity(din,rx_parity_check);
input [10:0]din;
output reg rx_parity_check;

always @(*) begin

    rx_parity_check = ^din[9:2]; 

end
endmodule
