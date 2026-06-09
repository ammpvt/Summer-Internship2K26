# Assignment: 4-Bit Ripple Carry Adder

## 🎯 Problem Statement
Design, implement, and simulate a 4-bit Ripple Carry Adder using structural Verilog modeling. The architecture must be built by instantiating 1-bit Full Adder modules.

## 🧠 Logic & Theoretical Operation
A Ripple Carry Adder (RCA) cascades multiple 1-bit Full Adders to add $N$-bit numbers. The carry-out of the $i^{th}$ full adder acts as the carry-in for the $(i+1)^{th}$ full adder. 

The fundamental logic for each 1-bit Full Adder stage is:
$$Sum = A \oplus B \oplus C_{in}$$
$$C_{out} = (A \cdot B) + C_{in} \cdot (A \oplus B)$$

While structurally simple and hardware-efficient, the RCA suffers from propagation delay. The final sum and carry-out cannot be definitively resolved until the carry bit "ripples" sequentially through every preceding stage from the Least Significant Bit (LSB) to the Most Significant Bit (MSB).

## 💻 Implementation Details
* **Dependencies:** This module relies on a lower-level 1-bit Full Adder. Ensure `fulladd.v` is present in the project directory.
* **`ripplecarry4bit.v`**: The design structurally instantiates four `fulladd` primitives (`FA0` to `FA3`). Internal wires (`w1`, `w2`, `w3`) are declared to route the intermediate carry signals between the instantiated blocks.
* **`ripple_tb.v`**: The testbench applies various stimulus vectors, including a worst-case carry propagation scenario (`4'b1111 + 4'b1111 + 1`), and logs the output dynamically using `$monitor`.

## 📊 Simulation Results
* **Status:** Passed Behavioral Simulation. 
* **Synthesis Notes:** Clean structural elaboration. Vivado maps this to basic LUTs (Look-Up Tables) and carry-chain primitives (CARRY4) in the FPGA fabric.
* **Waveform:** <img width="1077" height="707" alt="Screenshot 2026-06-09 222716" src="https://github.com/user-attachments/assets/96014830-ff3f-4e24-b397-aec99a3dda26" />
