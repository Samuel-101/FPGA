# rx_uart — UART Receiver

Verilog implementation of the UART receive path. Samples an incoming serial line at 16x oversampling, recovers the byte and parity, and buffers received bytes in a FIFO for the user logic to read.

## Files

| File | Description |
|---|---|
| `rx_uart.v` | Top-level receiver module — wires together the oversampler, shift register, parity check, FSM, and FIFO. |
| `pulse16.v` | Generates a single-cycle pulse from the 16x oversample clock, used to time FIFO writes. |
| `rx_baud_generator.v` | Baud clock generation logic for the receiver (currently instantiated via the PLL at the top `uart` level instead — see notes below). |
| `rx_shift_register.v` | Samples and shifts in the incoming serial bit stream on `rx_in`, reconstructing the received word. |
| `rx_parity.v` | Checks the parity of the received data against the received parity bit. |
| `rx_fsm.v` | Controls the receive sequence — detects the start bit, tracks bit count, checks parity, and signals the FIFO to capture a completed byte. |
| `rx_fifo.v` | Buffers completed received bytes until the user logic reads them out via `rx_ready`. |

## Top-Level Ports (`rx_uart`)

| Port | Direction | Width | Description |
|---|---|---|---|
| `sys_clk` | input | 1 | System clock. |
| `rst` | input | 1 | Reset. |
| `rx_in` | input | 1 | Serial receive line. |
| `rx_ready` | input | 1 | Read-enable; pops a byte from the RX FIFO. |
| `rx_baud_clk` | input | 1 | Baud-rate clock (9600 baud) from the PLL. |
| `baud_clk16` | input | 1 | 16x oversample clock from the PLL, used for bit-timing recovery. |
| `fifo_in_data` | output | 8 | Data byte latched from the shift register, written into the FIFO. |
| `rx_parity_check` | output | 1 | Result of the parity check on the received byte. |
| `fifo_wren` | output | 1 | Write-enable pulse to the RX FIFO when a byte is ready. |
| `rx_fifo_out` | output | 8 | Received data byte read out of the FIFO. |
| `rx_fifo_empty` | output | 1 | High when the RX FIFO has no data available. |
| `state` | output | 2 | Current FSM state (debug). |
| `count` | output | 4 | Bit counter within the current frame (debug). |

## How It Works

1. `rx_in` is sampled by `rx_shift_register` at the baud clock rate, shifting bits into a word as they arrive.
2. `pulse16` (driven by `baud_clk16`) generates timing pulses used for oversampled bit-edge detection.
3. `rx_fsm` tracks where in the frame (start bit, data bits, parity bit, stop bit) the receiver currently is, using `count`/`state`.
4. Once a full byte has been received, `rx_parity` checks parity and the FSM asserts `fifo_wren` to write the byte into `rx_fifo`.
5. The user logic reads completed bytes from `rx_fifo_out` by asserting `rx_ready` whenever `rx_fifo_empty` is low.

## Notes

`rx_baud_generator.v` is included in this folder but is currently bypassed in `rx_uart.v` (commented out) in favor of generating both `rx_baud_clk` and `baud_clk16` from the shared PLL (`pll_baud`) at the top-level `uart` module.

