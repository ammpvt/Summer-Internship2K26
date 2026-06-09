# Assignment: 4-Bit Universal Shift Register

## 🎯 Problem Statement
Design and simulate a 4-bit Universal Shift Register using Verilog. The module must support all four standard register operations: Serial-In/Serial-Out (SISO), Serial-In/Parallel-Out (SIPO), Parallel-In/Serial-Out (PISO), and Parallel-In/Parallel-Out (PIPO), governed by a 2-bit mode selection control.

## 🧠 Logic & Theoretical Operation
A universal shift register routes data depending on the selected operating mode ($mod$). The data shifts rightward from the Most Significant Bit (MSB) to the Least Significant Bit (LSB). 

The 2-bit mode selector dictates the active data path:
* **Mode 00 (SISO):** Serial data enters the MSB. Output is read sequentially from the LSB.
  $$temp[3] \leftarrow sin, \quad temp[2:0] \leftarrow temp[3:1]$$
* **Mode 01 (SIPO):** Serial data is shifted in, but the output is read as a parallel 4-bit bus.
  $$pout = temp[3:0]$$
* **Mode 10 (PISO):** A 4-bit parallel word is loaded into the register synchronously, then shifted out serially via the LSB.
  $$S_{out} = temp[0]$$
* **Mode 11 (PIPO):** A 4-bit parallel word is loaded into the register and immediately available on the parallel output bus.
  $$temp \leftarrow pin \quad \implies \quad pout = temp$$

## 💻 Implementation Details
* **`universal.v`**: The design separates the sequential logic (shifting/loading) from the combinational logic (output routing). 
  * The sequential `always @(posedge clk or posedge rst)` block handles asynchronous resets and manages the internal 4-bit state register (`temp`).
  * The combinational `always @(*)` block multiplexes the outputs (`sout` and `pout`) based on the active mode. Default values are initialized at the top of the block to prevent inferred latches during Vivado synthesis.
* **`universal_tb.v`**: The testbench generates a 10ns clock cycle and sequentially walks through all four modes (`2'b11` PIPO $\rightarrow$ `2'b10` PISO $\rightarrow$ `2'b01` SIPO $\rightarrow$ `2'b00` SISO), asserting the `shift` and `load` control signals appropriately for each state.

## 📊 Simulation Results
* **Status:** Passed Behavioral Simulation. All four register modes function according to the control signal logic.
* **Synthesis Notes:** RTL elaborated cleanly with zero inferred latches due to strict combinational block defaults.
* **Waveform:** <img width="1552" height="786" alt="Screenshot 2026-06-09 215145" src="https://github.com/user-attachments/assets/f1cdd037-c19c-4908-9447-2759e126f204" />
