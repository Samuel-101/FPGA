module pulse16(
    input pulse,
    input baud_clk,
    input rst,
    output reg q
);
    reg [3:0] count; // 4-bit counter
    reg state;
    always @(posedge baud_clk) begin

    if (rst) begin
            q <= 1'b0;          // Reset q to 0 (1-bit)
            count <= 4'b0000;   // Reset the counter to 0                
            state <= 1'b0;

        end 
    else begin
        
    case (state)
        1'b0:if (pulse) begin
                state <= 1'b1;
                q<= 1'b1;
              end     
              else begin
                state <= 1'b0;
              end
        1'b1:if (count == 4'hE) begin
                count <= 4'b0000; // Reset counter after reaching 15
                q <= 1'b0;    
                state <=1'b0;      // Set q to 1 when pulse is active                         // Set q to 0 after 16 pulses
                end else begin
                    count <= count + 1'b1; // Increment the counter
                    q <= 1'b1;     
                    state <=1'b1; 
                end      
         
                       
    endcase
    end
  
    end
endmodule