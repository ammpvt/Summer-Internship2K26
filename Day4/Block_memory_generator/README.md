# Custom 8x8 Block Memory Generator (RAM) in Verilog

This repository contains a structural and behavioral Verilog implementation of a basic **8x8 Single-Port RAM module**, designed to mimic the core behavior of a hardware Block Memory Generator (BMG). It includes the synthesizable RAM module and a comprehensive testbench for simulation and verification.

---

## 📌 Features & Specifications

* **Memory Dimensions:** 8 depth x 8-bit width (8x8 bits total storage).
* **Addressing:** 3-bit addressing (`[2:0]`) uniquely mapping all 8 memory locations.
* **Clocking:** Synchronous, edge-triggered operations.
* **Reset Control:** Asynchronous active-low reset (`rstn`) that fully initializes all memory rows and the output register to `8'h00`.
* **Control Logic:** A single control pin (`wrenb`) handles the operational modes:
  * `wrenb = 1'b1` -> **Write Mode:** Writes data from `data_in` to the address specified by `wradd`.
  * `wrenb = 1'b0` -> **Read Mode:** Fetches data from the address specified by `rdadd` and drives it to `data_out` on the next clock edge.

---

## 📁 Repository Structure

* **`bmg_ram_8x8.v`** – The main design module containing the 8x8 memory array, asynchronous reset logic, and conditional read/write modes.
* **`bmg_ram_tb.v`** – The testbench file containing a 100 MHz clock generator and a stimulus sequence that verifies writing to multiple addresses and reading them back sequentially.

---

## 🚀 How to Run and Simulate

You can simulate this design using industry-standard EDA tools such as **AMD Vivado**, **ModelSim**, **QuestaSim**, or **Icarus Verilog**.

1. Clone or download this repository.
2. Add `bmg_ram_8x8.v` and `bmg_ram_tb.v` to your simulation project workspace.
3. Set `bmg_ram_tb` as the top-level simulation module.
4. Run the simulation for at least `150ns` to observe the full write and read cycles.

---

## 📊 Simulation Waveform

Below is the verification waveform showcasing the active-low reset initialization, consecutive synchronous write operations, and subsequent synchronous read-back cycles matching the testbench configuration.


<img width="1547" height="775" alt="Screenshot 2026-06-11 152847" src="https://github.com/user-attachments/assets/56d90f71-9770-4f55-9cd8-a308b68bedf9" />

