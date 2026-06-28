
module tx_fifo #(
    parameter DATA_WIDTH = 8,        // Width of the data
    parameter FIFO_DEPTH = 8     // Depth of the FIFO
)(
    input  wire                 sys_clk,   // Write clock
    input  wire                 baud_clk,   // Read clock
    input  wire                 rst,      // Reset signal
    input  wire                 wr_en,    // Write enable
    input  wire                 rd_en,    // Read enable
    input  wire [DATA_WIDTH-1:0] din, // Data to write
    output reg  [DATA_WIDTH-1:0] dout, // Data to read
    output reg                  full,     // FIFO full flag
    output reg                  empty     // FIFO empty flag
);

    // Calculate address width based on FIFO depth
    localparam ADDR_WIDTH = $clog2(FIFO_DEPTH);

    // Memory array for storing data
    reg [DATA_WIDTH-1:0] mem [0:FIFO_DEPTH-1];

    // Write and read pointers
    reg [ADDR_WIDTH:0] wr_ptr, rd_ptr;      // Pointers include one extra bit for full/empty status
    reg [ADDR_WIDTH:0] wr_ptr_gray, rd_ptr_gray;  // Gray-coded pointers
    reg [ADDR_WIDTH:0] wr_ptr_gray_sync, rd_ptr_gray_sync; // Synchronized Gray pointers

    // Convert binary to Gray code
    function [ADDR_WIDTH:0] bin2gray;
        input [ADDR_WIDTH:0] bin;
        begin
            bin2gray = bin ^ (bin >> 1);
        end
    endfunction

    // Write clock domain logic
    always @(posedge sys_clk or posedge rst) begin
        if (rst) begin
            wr_ptr <= 0;
            wr_ptr_gray <= 0;
        end else if (wr_en && !full) begin
            mem[wr_ptr[ADDR_WIDTH-1:0]] <= din;
            wr_ptr <= wr_ptr + 1;
            wr_ptr_gray <= bin2gray(wr_ptr + 1);
        end
    end

    // Read clock domain logic
    always @(posedge baud_clk or posedge rst) begin
        if (rst) begin
            rd_ptr <= 0;
            rd_ptr_gray <= 0;
        end else if (rd_en && !empty) begin
            dout <= mem[rd_ptr[ADDR_WIDTH-1:0]];
            rd_ptr <= rd_ptr + 1;
            rd_ptr_gray <= bin2gray(rd_ptr + 1);
        end
    end

    // Synchronize write pointer to read clock domain
    always @(posedge baud_clk or posedge rst) begin
        if (rst) begin
            wr_ptr_gray_sync <= 0;
        end else begin
            wr_ptr_gray_sync <= wr_ptr_gray;
        end
    end

    // Synchronize read pointer to write clock domain
    always @(posedge sys_clk or posedge rst) begin
        if (rst) begin
            rd_ptr_gray_sync <= 0;
        end else begin
            rd_ptr_gray_sync <= rd_ptr_gray;
        end
    end

    // Generate full and empty flags
    always @(*) begin
        if (rst) begin
            full <= 0;
        end else begin
            full <= (bin2gray(wr_ptr) == {~rd_ptr_gray_sync[ADDR_WIDTH:ADDR_WIDTH-1], rd_ptr_gray_sync[ADDR_WIDTH-2:0]});
        end
    end

    always @(*) begin
        if (rst) begin
            empty <= 1;
        end else begin
            empty <= (wr_ptr_gray_sync == rd_ptr_gray);
        end
    end

endmodule
