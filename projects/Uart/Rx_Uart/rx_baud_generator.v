module rx_baud_generator (
  input wire clk,      // Input clock (e.g., 50 MHz)
  input wire rst,      // Reset signal
  output reg baud_clk16  // Output baud clock (9600 Hz)
);

  parameter CLK_FREQ = 50000000;  // Input clock frequency (50 MHz)
  parameter BAUD_RATE = 9600;     // Desired baud rate

  localparam integer DIVISOR = CLK_FREQ / (BAUD_RATE * 16*2); // Divider for oversampling by 16
  reg [15:0] counter;  // Counter for clock division

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      counter <= 0;
      baud_clk16 <= 0;
    end else begin
      if (counter >= DIVISOR - 1) begin
        counter <= 0;
        baud_clk16 <= ~baud_clk16; // Toggle the baud clock
      end else begin
        counter <= counter + 1;
      end
    end
  end

endmodule