# UART (Verilog) — Intel MAX 10 / DE10-Lite

A UART (Universal Asynchronous Receiver/Transmitter) implemented in Verilog for the Intel MAX 10 FPGA (DE10-Lite board), built with Quartus Prime Lite.

## Overview

The top-level `uart` module instantiates a transmitter, a receiver, and a baud-rate PLL:

- **`tx_uart/`** — Transmit path: FIFO buffer, finite-state machine, parity generation, and shift register for serial output.
- **`rx_uart/`** — Receive path: FIFO buffer, FSM, parity check, shift register, and 16x oversampling pulse generator for clock recovery.
- **`pll_baud.v`** — PLL-based baud rate generator (produces a 16x oversample clock and a 9600 baud clock from the system clock).
- **`uart.v`** — Top-level module wiring TX/RX paths together.

## Module Hierarchy

```
uart
├── pll_baud        (baud rate clock generation)
├── tx_uart
│   ├── tx_fifo
│   ├── tx_fsm
│   ├── tx_parity
│   └── tx_shift_register
└── rx_uart
    ├── rx_baud_generator
    ├── pulse16
    ├── rx_fifo
    ├── rx_fsm
    ├── rx_parity
    └── rx_shift_register
```

## Top-Level Ports

| Port | Direction | Description |
|---|---|---|
| `rx_in` | input | Serial data in |
| `sys_clk` | input | System clock |
| `rst` | input | Reset |
| `tx_fifo_en` | input | Write-enable for TX FIFO |
| `rx_ready` | input | Read-enable for RX FIFO |
| `tx_out` | output | Serial data out |
| `rx_fifo_empty` | output | RX FIFO empty flag |
| `tx_fifo_full` | output | TX FIFO full flag |

## Toolchain

- **Quartus Prime Lite** (Intel/Altera)
- Target device: MAX 10 (DE10-Lite)
- Project files: `uart.qpf`, `uart.qsf`

## Build Outputs

The `output_files/` directory includes the generated programming files and summary reports from the most recent compile:

- `uart.sof` — SRAM Object File (for JTAG programming)
- `uart.pof` — Programmer Object File (for flash programming)
- `uart.pin` — Pin assignments report
- `*.summary` — Fit, map, and timing analysis summaries

## Notes

This repo intentionally excludes Quartus's generated build cache (`db/`, `incremental_db/`, `greybox_tmp/`, simulation cache files) since these are regenerated automatically on compile and aren't useful to track in version control.
