# Day 5: BCD Adder Verification using SystemVerilog Interfaces

## 📌 Overview
This assignment demonstrates the implementation of a modern verification setup using **SystemVerilog Interfaces** for a 4-bit BCD (Binary Coded Decimal) Adder. The goal was to transition from standard Verilog port connections to a clean, bundled interface layout.

---

## 🛠️ The Core Concept: Interfaces as Structs
Instead of declaring separate, individual wires for every input and output, this testbench wraps all connections inside a single `interface` block.
* **The Analogy:** This approach works exactly like a **`struct` in C programming**. It bundles independent signals (`A`, `B`, `CIN`, `S`, `COUT`) into a single named container.
* This eliminates repetitive wiring and allows the testbench to communicate with the design module through a single interface bundle using simple dot-notation.

---

## 📂 Repository Structure & Dependencies

The design utilizes the existing 4-bit structural BCD Adder module.

* **BCD Adder Design File:** Already uploaded and available here: 
  [day1/BCD_Adder/Design/BCDadder.v](./day1/BCD_Adder/Design/BCDadder.v)
* **New Testbench File:** `bcdadderinterfac.sv` (Contains both the `interface bcd_if` and the top-level testbench module).

---

## 🧪 Test Bench Stimulus Flow
Since the BCD Adder is a purely combinatorial circuit, the testbench directly drives values to test specific addition boundaries:
1. **Zero Initialization:** Sets all input signal combinations to zero at time 0.
2. **Normal BCD Addition:** Validates basic addition cases where the output sum is less than or equal to 9 ($2 + 3$ and $5 + 4$).
3. **BCD Correction Logic:** Validates cases greater than 9 ($6 + 7$ and $8 + 8$) to ensure the design accurately adds the $+6$ correction factor and asserts the `COUT` flag.
4. **Monitoring:** Uses the `$monitor` task to dynamically log input transitions and expected output changes in the console window.

---

## 📊 Simulation Waveform

The behavioral simulation was successfully executed using **Vivado Simulator (XSim)**. Below is the verified simulation waveform capturing the signal evaluations across the interface ports:

![BCD Adder Interface Simulation Waveform](YOUR_IMAGE_LINK_HERE)
