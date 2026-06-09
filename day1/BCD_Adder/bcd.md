# Assignment: 4-Bit BCD Adder

## 🎯 Problem Statement
Design, implement, and simulate a 4-bit Binary Coded Decimal (BCD) adder using structural Verilog modeling. The design must correctly add two BCD digits and output a valid BCD sum, utilizing a standard 4-bit Ripple Carry Adder as a foundational sub-module.

## 🧠 Logic & Theoretical Operation
A BCD adder performs binary addition on two 4-bit inputs but must ensure the output remains within the valid BCD range ($0000_2$ to $1001_2$, or $0$ to $9$ in decimal). 

When two BCD digits are added, the initial binary sum can exceed 9. To correct an invalid BCD sum, a value of 6 ($0110_2$) must be added to the result.

A correction is required if any of the following conditions are met:
1. The initial binary addition produces a carry out ($C_{out1} = 1$).
2. The initial sum is $\ge 10$ ($1010_2, 1011_2, 1100_2, etc.$). This is detected using the Boolean expression: $S_3 \cdot S_2 + S_3 \cdot S_1$.

The final correction logic for generating the BCD carry out ($C_{OUT}$) is:
$$C_{OUT} = C_{out1} + (S_3 \cdot S_2) + (S_3 \cdot S_1)$$

If $C_{OUT} = 1$, the correction vector `0110` is added to the initial sum. If $C_{OUT} = 0$, the correction vector `0000` is added.

## 💻 Implementation Details
* **Dependencies:** This module structurally instantiates a separate `ripplecarry4bit` module. Ensure `ripplecarry4bit.v` is included in the Vivado project hierarchy.
* **`BCDadder.v`**: The design uses structural instantiation for the addition. It uses a first `ripplecarry4bit` block to find the initial sum, primitive logic gates (`and`, `or`) to calculate the correction condition, and a second `ripplecarry4bit` block to add the dynamic `temp` correction vector (`{1'b0, COUT, COUT, 1'b0}`).
* **`bcdadder_tb.v`**: The testbench manually steps through edge cases, including valid sums under 9 ($2+3$, $5+4$) and invalid sums requiring BCD correction ($6+7$, $8+8$).

## 📊 Simulation Results
* **Status:** Passed Behavioral Simulation.
* **Verification Notes:** The dynamic correction vector correctly asserts `0110` when the binary sum exceeds 9, resulting in the proper BCD carry and sum.
* **Waveform:** <img width="1092" height="748" alt="Screenshot 2026-06-09 222114" src="https://github.com/user-attachments/assets/a55523eb-539e-47ac-9a54-21b99a4c646e" />

