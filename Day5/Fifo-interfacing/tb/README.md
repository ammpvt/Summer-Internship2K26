# FIFO Verification using SystemVerilog Interfaces

## 📌 Overview
Today's assignment focuses on modern hardware verification practices using **SystemVerilog**. The primary objective was to transition away from traditional, messy Verilog testbench connections and implement a clean, structured verification environment using **SystemVerilog Interfaces**.

---

## 🛠️ The Core Twist: Why Interfaces?
In the previous assignment, the FIFO was tested using a standard Verilog testbench where every single signal wire had to be mapped individually port-by-port. 

For this assignment, the testbench was completely rewritten in SystemVerilog to introduce a `fifo` interface. 
* **The Analogy:** An interface functions exactly like a **`struct` in C programming**. Instead of managing 8 separate standalone wires, the interface groups all related communication signals (`clk`, `rst`, `wrenb`, `rdenb`, `data_in`, `data_out`, `full`, `empty`) into a single named bundle.
* This bundle acts like a single "cable" connecting the testbench driver directly to the Design Under Test (DUT), making the code highly modular, readable, and scalable.

---

## 📂 Repository Structure & Dependencies

To avoid redundancy, this task utilizes the exact same FIFO hardware design previously implemented. 

* **FIFO Design File:** Already uploaded and available here: 
  [Day3/Face_detection_project/Design/FIFO.v](./Day3/Face_detection_project/Design/FIFO.v)
* **New Testbench File:** `fifo_tb_inf.sv` (Contains both the `interface fifo()` definition and the top-level testbench module `fifo_tb_inf`).

---

## 🧪 Test Bench Stimulus Flow
The SystemVerilog testbench executes a linear, step-by-step verification scenario via the interface bundle:
1. **System Initialization:** Initializes the interface clock and control lines safely to eliminate `X` (unknown) state replication.
2. **Reset Phase:** Asserts the reset signal line through the interface wrapper to clear internal pointers.
3. **Partial Write:** Pushes 3 distinct hexadecimal data items (`8'hAA`, `8'hBB`, `8'hCC`) onto the bus.
4. **Partial Read:** Pops 2 items from the FIFO to verify sequential pointer handling.
5. **Saturation Test:** Progressively writes 7 more items to intentionally stress the FIFO memory limits and force the `full` flag status high.
6. **Drain Phase:** Continuous reads to clear the FIFO down to zero until the `empty` flag asserts.

---

## 📊 Simulation Waveform

The behavioral simulation was successfully executed using **Vivado Simulator (XSim)**, running precisely to completion at `300 ns`. Below is the verified waveform capturing data transitions, clock cycles, and flag triggers handled through the interface wrapper:

<img width="1547" height="783" alt="Screenshot 2026-06-14 171215" src="https://github.com/user-attachments/assets/4ff71bb5-e79c-4933-ad14-544a68fd9d38" />


