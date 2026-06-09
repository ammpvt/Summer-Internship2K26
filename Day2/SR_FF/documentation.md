# Assignment: SR Flip-Flop

## 🎯 Problem Statement
Design, implement, and verify a synchronous Set-Reset (SR) Flip-Flop with an active-high asynchronous reset using behavioral Verilog modeling.

## 🧠 Logic & Theoretical Operation
The SR Flip-Flop is a fundamental 1-bit memory element with two distinct control inputs: Set ($S$) and Reset ($R$). 

* **Hold ($S=0, R=0$):** Retains the current state.
* **Reset ($S=0, R=1$):** Forces output $Q = 0$.
* **Set ($S=1, R=0$):** Forces output $Q = 1$.
* **Invalid ($S=1, R=1$):** In standard SR logic, driving both inputs high causes a race condition. In this RTL implementation, the output is explicitly driven to an unknown state (`1'bx`).

The characteristic equation for the SR Flip-Flop (assuming $S$ and $R$ are never $1$ simultaneously) is:
$$Q_{next} = S + \overline{R}Q$$

## 💻 Implementation Details
* **`srff.v`**: The module utilizes a single sequential `always @(posedge clk or posedge rst)` block to ensure the reset operates asynchronously. An `if-else` ladder evaluates the $S$ and $R$ inputs on every rising clock edge and updates the $Q$ and $\overline{Q}$ registers using non-blocking (`<=`) assignments. 
* **`srff_tb.v`**: The testbench verifies the logic by generating a continuous clock and stepping through all four possible combinations of $S$ and $R$ at 10ns intervals.

## 📊 Simulation Results
* **Status:** Passed Behavioral Simulation. 
* **Synthesis Notes:** Successfully inferred a register. Invalid state logic correctly maps to uninitialized/unknown values during simulation.
* **Waveform:** <img width="877" height="746" alt="Screenshot 2026-06-09 221124" src="https://github.com/user-attachments/assets/dabe113b-6729-4e7d-a58e-e356fd71ece7" />
