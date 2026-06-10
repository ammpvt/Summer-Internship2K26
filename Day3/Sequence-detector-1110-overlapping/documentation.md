# 1110 Sequence Detector (Mealy FSM)

**Project:** Advanced VLSI Design Internship @ TKM College of Engineering  
**Language:** Verilog HDL  
**EDA Tool:** Xilinx Vivado  

## Overview
This project implements a digital sequence detector designed to identify the binary pattern `1110` from a continuous serial data stream. The design utilizes a Mealy Finite State Machine (FSM) architecture, where the output is determined by both the current state and the current input. 

## Module Interface

| Port Name  | Direction | Width | Description                                      |
| :--------- | :-------- | :---- | :----------------------------------------------- |
| `clk`      | Input     | 1-bit | System clock signal                              |
| `rst`      | Input     | 1-bit | Active-high synchronous reset                    |
| `din`      | Input     | 1-bit | Serial data input stream                         |
| `detected` | Output    | 1-bit | Asserts High (1) when sequence '1110' is detected|

## FSM Architecture & Working Principle

The core of the design is a 4-state FSM that tracks the progression of incoming `1`s. The states are encoded using 2-bit parameters (`idle`, `s1`, `s2`, `s3`). The logic is split into two `always` blocks: a sequential block for state registers and a combinational block for next-state and output decoding.

### State Transition Logic
The system progresses through the following states to detect the `1110` pattern:

* **`idle` (00):** The reset state. The FSM waits for the first `1`. 
  * If `din = 1`, it registers the first bit of the sequence and moves to `s1`. 
  * If `din = 0`, it remains in `idle`.
* **`s1` (01):** One `1` has been detected. 
  * If `din = 1`, the sequence is now `11`; the FSM moves to `s2`. 
  * If `din = 0`, the sequence is broken, and the FSM resets to `idle`.
* **`s2` (10):** Two consecutive `1`s (`11`) have been detected. 
  * If `din = 1`, the sequence is now `111`; the FSM moves to `s3`. 
  * If `din = 0`, the sequence is broken, and it resets to `idle`.
* **`s3` (11):** Three consecutive `1`s (`111`) have been detected. This is the critical evaluation state:
  * **Sequence Completion:** If `din = 0`, the full `1110` sequence is realized. Because this is a Mealy machine, `detected` is immediately driven High (1) during this clock cycle, and the next state (`ns`) routes back to `idle`.
  * **Sequence Continuation:** If `din = 1`, the FSM receives a fourth `1` (making the stream `1111...`). Instead of resetting, the logic intelligently holds the state at `s3`. This ensures that any trailing `0` after a long string of `1`s (e.g., `111110`) will still successfully trigger a detection.

## Testbench & Verification Strategy

The testbench (`seqdet_1110_tb`) verifies the FSM's behavior using two distinct input scenarios to ensure robust edge-case handling. 

1. **Standard Detection:** After asserting and de-asserting the reset (`rst_tb`), the testbench injects the exact sequence `1 -> 1 -> 1 -> 0`. This verifies the standard `idle -> s1 -> s2 -> s3 -> idle` transition path.
2. **Consecutive '1's Detection:** The testbench then injects an extended sequence of `1 -> 1 -> 1 -> 1 -> 0`. This is a crucial verification step to test the self-loop in state `s3`. It proves that the FSM does not drop the sequence if more than three `1`s arrive consecutively before the terminating `0`.

## Simulation Waveform

<img width="1577" height="810" alt="seqdet1110" src="https://github.com/user-attachments/assets/661ef037-2fc9-4d09-badf-691a581df7aa" />


---

## 🛠 Design Notes
* **Mealy Advantage:** By using a Mealy machine, the system saves one clock cycle of latency compared to a Moore machine, as the `detected` output asserts the exact moment the final `0` of the `1110` sequence is sampled on the input line.
* **Code Optimization Note:** In standard Verilog practice, combinational `always @(*)` blocks should utilize blocking assignments (`=`). Ensure that assignments like `detected <= 0;` are updated to `detected = 0;` in your final RTL to prevent potential simulation-synthesis mismatches.<
