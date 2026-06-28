module tx_parity(din,parity_check);
input [7:0]din;
output reg parity_check;

always @(*) begin
    
    parity_check = ^din; 
   
end
endmodule
