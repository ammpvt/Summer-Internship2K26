# Assignment: 4-to-2 Encoder

## 🎯 Problem Statement
Design and verify a 4-to-2 Encoder using behavioral modeling in Verilog. The circuit must compress a 4-bit one-hot input vector into a 2-bit binary output.

## 🧠 Logic & Theoretical Derivation
A standard 4-to-2 encoder takes 4 input lines ($D_0, D_1, D_2, D_3$) and generates 2 output lines ($Y_0, Y_1$). In a strict one-hot encoder setup, only one input is actively driven high at any given time.

The Boolean expressions for the outputs are derived as:
$$Y_1 = D_2 + D_3$$
$$Y_0 = D_1 + D_3$$

## 💻 Implementation Details
* **`encoder4to2.v`**: Implements the encoder logic using a behavioral `always` block. A `case` statement evaluates the 4-bit input vector and maps it to the corresponding 2-bit encoded output, with a default state to prevent inferred latches during synthesis.
* **`encoder4to2_tb.v`**: The testbench utilizes a `for` loop to programmatically generate one-hot input stimuli. It shifts the active bit leftward ($1, 2, 4, 8$) and utilizes `$monitor` to log the output responses to the console.

## 📊 Simulation Results
* **Status:** Passed Behavioral Simulation.
* **Waveform:** <img width="1082" height="747" alt="Screenshot 2026-06-09 214834" src="https://github.com/user-attachments/assets/01381364-8d55-4a5e-961c-b74a247ef083" />

