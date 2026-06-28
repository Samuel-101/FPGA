# tx_uart — UART Transmitter

Verilog implementation of the UART transmit path. Takes parallel data in, buffers it in a FIFO, and serializes it out one bit at a time at the configured baud rate, with parity.

## Files

| File | Description |
|---|---|
| `tx_uart.v` | Top-level transmitter module — wires together the FIFO, FSM, parity, and shift register. |
| `tx_fifo.v` | Buffers parallel data written in by the user logic before it's serialized and transmitted. |
| `tx_fsm.v` | Controls the transmit sequence (idle → load → shift out start/data/parity/stop bits) and asserts `tx_busy` while transmitting. |
| `tx_parity.v` | Computes the parity bit for the byte about to be sent. |
| `tx_shift_register.v` | Shifts the byte (plus parity bit) out serially on `tx_out`, synchronized to the baud clock. |

## Top-Level Ports (`tx_uart`)

| Port | Direction | Width | Description |
|---|---|---|---|
| `tx_fifo_en` | input | 1 | Write-enable; pushes `fifo_in` into the TX FIFO. |
| `fifo_in` | input | 8 | Parallel data byte to transmit. |
| `baud_clk9600` | input | 1 | Baud-rate clock (9600 baud) from the PLL. |
| `rst` | input | 1 | Reset. |
| `sys_clk` | input | 1 | System clock. |
| `tx_out` | output | 1 | Serial transmit line. |
| `tx_fifo_full` | output | 1 | High when the TX FIFO can't accept more data. |
| `bd` | output | 1 | Passthrough of `baud_clk9600` (debug). |

## How It Works

1. User logic writes a byte into `fifo_in` with `tx_fifo_en` asserted; it's stored in `tx_fifo`.
2. As soon as the FIFO isn't empty and the transmitter isn't busy (`tx_start`), `tx_fsm` begins a transmission.
3. `tx_fsm` drives `tx_load_en` to load the byte (with its parity bit, computed by `tx_parity`) into `tx_shift_register`.
4. `tx_shift_register` shifts the start bit, 8 data bits, parity bit, and stop bit out on `tx_out`, one bit per baud clock edge.
5. `tx_busy` stays high until the frame finishes, after which the FSM checks the FIFO for the next byte.
