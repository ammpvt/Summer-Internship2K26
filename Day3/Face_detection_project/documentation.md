# Project Documentation: Face Detection Data Pipeline

## 1. Project Overview
This project implements a digital hardware pipeline in Verilog that captures, buffers, and paces external sensor data. It is designed to act as an interface for a face detection sensor, taking rapid sequential data, safely storing it, and then outputting it at a controlled, delayed pace. 

## 2. System Architecture
The system is integrated within a `Top_module` wrapper and consists of three distinct pipeline stages:

1. **Producer Stage:** `Face_detection_module.v` (Sensor Interface)
2. **Buffer Stage:** `FIFO.v` (Elastic Memory)
3. **Consumer Stage:** `Data_Out_FSM.v` (Pacing State Machine)

---

## 3. Module Breakdown

### 3.1. Face Detection Module (`Face_detection_module.v`)
- **Role:** Acts as the data ingress point (similar to a PISO/Parallel-In-Serial-Out module). 
- **Functionality:** On every positive clock edge, it samples 8-bit parallel data (`P_in`) from the face sensor. It pipes this data out via `P_out` and asserts a `wrenabler` (write enable) signal. 
- **Flow Control:** It monitors the `fifo_full` feedback signal. If the downstream memory is full, it pauses data writing to prevent data loss. It also includes a robust synchronous reset (`rst`) to prevent pushing invalid/garbage data into the pipeline during system startup.

### 3.2. FIFO Memory (`FIFO.v`)
- **Role:** Serves as a safe, elastic buffer between the fast sensor and the slower FSM.
- **Specifications:** 8 slots deep by 8 bits wide (Distributed RAM).
- **Functionality:** Uses independent 4-bit read and write pointers to safely store data and calculate `full` and `empty` status flags.
- **Optimization:** Features a zero-cycle initial lag bypass. If a write occurs to a completely empty FIFO, the `empty` flag drops combinationally, allowing the data to bypass the memory array directly to the output. This ensures downstream modules can access the first byte instantly.

### 3.3. Data Output FSM (`Data_Out_FSM.v`)
- **Role:** Extracts the data from the FIFO and controls the final output pacing.
- **Functionality:** Operates on a precise 3-state Finite State Machine:
  - **`IDLE`:** Polls the FIFO's `empty_flag`. If data is present, it signals a read (`rdenabler`) and moves to the delay states.
  - **`DELAY1`:** De-asserts the read signal and waits for 1 clock cycle.
  - **`DELAY2`:** Waits an additional clock cycle, and upon completion, latches the incoming data out to the final `d_out` pins.
- **Result:** This architectural pacing ensures the system outputs exactly one processed byte every 3 clock cycles.

---

## 4. Pipeline Timing & Latency

When tracking a byte from the initial `p_in` to the final `p_out`, the system exhibits a strict, expected **3-Clock Pipeline Latency**:
1. **Clock 1 (Sensor):** The Face Detection Module registers the incoming data.
2. **Clock 2 (FIFO + FSM IDLE):** The FIFO stores the data, and the FSM acknowledges the `empty` flag dropping.
3. **Clock 3 (FSM DELAY):** The FSM paces the output through its wait states before finally latching the result to `p_out`.



---

## 5. Simulation & Verification

The pipeline has been verified using a comprehensive testbench (`topmodule_tb.v`), validating both standard throughput and full-backpressure behaviors.

## 6. Reports

<img width="1272" height="155" alt="Screenshot 2026-06-10 212344" src="https://github.com/user-attachments/assets/4f920f5e-c2b0-4e99-832c-014387b40fb3" />

### Simulation Waveform

<img width="1565" height="733" alt="Screenshot 2026-06-10 212027" src="https://github.com/user-attachments/assets/867afee2-7018-4b77-baf7-806e5334f224" />

