# Assignment: D Flip-Flop (Positive Edge-Triggered)

## 🎯 Problem Statement
Design, implement, and verify a positive edge-triggered D (Data) Flip-Flop with an active-high asynchronous reset using behavioral Verilog. 

## 🧠 Logic & Theoretical Operation
The D Flip-Flop is a fundamental synchronous memory element. It captures the value of the data input ($D$) at a specific point in time (the rising edge of the clock) and holds that state until the next clock edge.

The characteristic equation for a D Flip-Flop is straightforward:
$$Q_{next} = D$$

When the asynchronous reset ($rst$) is asserted high, the flip-flop immediately ignores the clock and forces the outputs to a known default state:
$$Q = 0, \quad \overline{Q} = 1$$

## 💻 Implementation Details
* **`dff.v`**: The design utilizes a single sequential `always @(posedge clk or posedge rst)` block. Placing `rst` in the sensitivity list ensures the reset acts asynchronously (it executes immediately when `rst` goes high, without waiting for the next clock edge). Non-blocking assignments (`<=`) are used, which is the standard protocol for modeling sequential logic.
* **`dff_tb.v`**: The testbench continuously generates a 10ns clock signal (`always #5 clk_tb = ~clk_tb;`). It asserts the reset signal high at $t=0$, deasserts it at $t=10ns$, and then applies logic $0$ and logic $1$ to the $D$ input across subsequent clock cycles to verify the sampling behavior.

## 📊 Simulation Results
* **Status:** Passed Behavioral Simulation.
* **Synthesis Notes:** Clean elaboration. The single `always` block correctly maps to a standard D-type flip-flop primitive in the target FPGA fabric.
* **Waveform:** <img width="882" height="786" alt="Screenshot 2026-06-09 215914" src="https://github.com/user-attachments/assets/8cb17ff2-7375-4c46-a4e1-4632ae455fa8" />
