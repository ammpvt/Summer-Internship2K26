# APB Slave Design and Verification Using SystemVerilog

A SystemVerilog implementation of an **AMBA APB (Advanced Peripheral Bus) Slave** along with a complete object-oriented verification environment. The project demonstrates APB read and write transactions, protocol state transitions, memory operations, error handling, and functional verification using **Generator, Driver, Monitor, Scoreboard, Mailboxes, and Virtual Interface** in **Xilinx Vivado**.

---

## 📖 Overview

The **Advanced Peripheral Bus (APB)** is a simple, low-power bus protocol defined in the ARM AMBA specification. It is widely used to connect low-bandwidth peripherals such as GPIO, UART, Timers, SPI, I²C, and watchdog modules to processors.

This project implements an APB Slave containing a **32-word × 32-bit memory**. The slave supports read and write transactions, generates the appropriate APB handshake signals, detects invalid addresses, and reports slave errors.

To verify the design, a complete SystemVerilog verification environment was developed using object-oriented programming concepts including:

* Transaction
* Generator
* Driver
* Monitor
* Scoreboard
* Mailboxes
* Virtual Interface
* Environment

Behavioral simulation and verification were performed using **Xilinx Vivado**.

---

## ✨ Features

* APB Slave Protocol Implementation
* 32 × 32 Internal Memory
* Read and Write Transactions
* APB State Machine
* Ready Signal Generation
* Slave Error Detection
* Random Transaction Generation
* Object-Oriented Verification Environment
* Mailbox-Based Communication
* Virtual Interface
* Automatic Scoreboard Checking
* Xilinx Vivado Behavioral Simulation

---

## 🧠 Theory

The **Advanced Peripheral Bus (APB)** is a synchronous bus designed for low-bandwidth peripheral communication.

Each APB transaction consists of three phases:

### 1. IDLE

The bus remains inactive.

```text
PSEL = 0
PENABLE = 0
```

---

### 2. SETUP

The master selects the slave and places the address and control signals on the bus.

```text
PSEL = 1
PENABLE = 0
```

---

### 3. ACCESS

The transfer is completed when the slave asserts `PREADY`.

```text
PSEL = 1
PENABLE = 1
PREADY = 1
```

During this phase:

* Write transactions store data into memory.
* Read transactions return data from memory.
* Invalid addresses generate an error response.

---

## 🏗️ Architecture

```text
                +----------------------+
                |      APB Master      |
                +----------------------+
                          |
                          |
                          v
                +----------------------+
                |     APB Interface    |
                +----------------------+
                          |
                          |
                          v
                +----------------------+
                |      APB Slave       |
                |----------------------|
                | 32 × 32 Memory       |
                | APB State Machine    |
                | Address Decoder      |
                | Error Detection      |
                +----------------------+
                          |
                          |
                          v
                    Read / Write Data
```

---

## 📂 Inputs and Outputs

### Inputs

| Signal    |  Width | Description        |
| --------- | -----: | ------------------ |
| `pclk`    |  1-bit | APB Clock          |
| `presetn` |  1-bit | Active-low Reset   |
| `paddr`   | 32-bit | Address Bus        |
| `psel`    |  1-bit | Slave Select       |
| `penable` |  1-bit | Enable Signal      |
| `pwrite`  |  1-bit | Read/Write Control |
| `pwdata`  | 32-bit | Write Data         |

### Outputs

| Signal    |  Width | Description  |
| --------- | -----: | ------------ |
| `prdata`  | 32-bit | Read Data    |
| `pready`  |  1-bit | Ready Signal |
| `pslverr` |  1-bit | Slave Error  |

---

## 📄 Design Implementation

### Internal Memory

```systemverilog
logic [31:0] mem [0:31];
```

---

### APB State Machine

The slave controller operates through three states:

```text
IDLE
SETUP
ACCESS
```

---

### Write Operation

```systemverilog
if(pwrite)
    mem[paddr] <= pwdata;
```

---

### Read Operation

```systemverilog
prdata <= mem[paddr];
```

---

### Invalid Address Handling

Addresses greater than **31** generate an error response.

```systemverilog
pslverr <= 1;
prdata  <= 32'h600D_C0DE;
```

---

## 📡 SystemVerilog Interface

The APB interface groups all APB signals into a single reusable communication interface.

### Interface Declaration

```systemverilog
interface apb_if(input logic pclk,input logic presetn);

logic [31:0] paddr;
logic psel;
logic penable;
logic pwrite;
logic [31:0] pwdata;

logic pready;
logic pslverr;
logic [31:0] prdata;

endinterface
```

### Advantages

* Reduces port connections
* Improves readability
* Simplifies DUT connectivity
* Supports reusable verification environments

---

## 🧪 Verification Environment

The project follows a layered verification architecture.

```text
Generator
    │
    ▼
Mailbox
    │
    ▼
Driver
    │
Virtual Interface
    │
    ▼
APB Slave DUT
    │
    ▼
Monitor
    │
Mailbox
    │
    ▼
Scoreboard
```

### Generator

* Generates directed and random APB transactions.
* Sends transactions to the driver using a mailbox.

### Driver

* Drives APB protocol signals.
* Implements SETUP and ACCESS phases.
* Waits for `PREADY`.

### Monitor

* Observes completed APB transactions.
* Collects transaction information.
* Sends data to the scoreboard.

### Scoreboard

* Maintains a reference memory.
* Verifies write transactions.
* Compares read data with expected values.
* Detects invalid address accesses.
* Reports PASS or FAIL automatically.

### Environment

The environment instantiates and connects:

* Generator
* Driver
* Monitor
* Scoreboard
* Mailboxes
* Virtual Interface

All components execute concurrently using `fork...join_none`.

---

## 📁 Project Structure

```text
APB-Slave-SystemVerilog/
│
├── design/
│   └── apb_slave.sv
│
├── testbench/
│   └── tb_top.sv
│
└── README.md
```

---

## 🧪 Testbench Verification

The verification environment performs both directed and randomized testing.

### Directed Tests

* Write `0xAAAA_BBBB` to Address `4`
* Read Address `4`
* Verify returned data

### Random Tests

Twenty randomized transactions are generated using constrained randomization.

Address constraint:

```systemverilog
constraint addr_c
{
    paddr dist
    {
        [0:31]  :/ 80,
        [32:100]:/ 20
    };
}
```

This generates:

* 80% valid addresses
* 20% invalid addresses

### Scoreboard Verification

The scoreboard verifies:

* Correct write operations
* Correct read operations
* Memory consistency
* Invalid address detection
* PSLVERR generation
* Correct PRDATA values

---

## 📊 Simulation Results

Behavioral simulation was performed using **Xilinx Vivado**.
<img width="1543" height="702" alt="Screenshot 2026-06-17 203400" src="https://github.com/user-attachments/assets/c8151523-bc06-4153-8cef-ef31cb3f9c9b" />

### Waveform Analysis

The waveform confirms:

* Proper reset operation
* Correct APB state transitions
* IDLE → SETUP → ACCESS sequence
* Successful write transaction
* Successful read transaction
* Correct `PREADY` generation
* Memory update after write
* Correct read-back of stored data
* Proper slave error generation for invalid addresses

### Verification Summary

| Feature                 | Status |
| ----------------------- | ------ |
| Reset                   | PASS   |
| APB State Machine       | PASS   |
| Write Transaction       | PASS   |
| Read Transaction        | PASS   |
| Memory Operation        | PASS   |
| PREADY Generation       | PASS   |
| PSLVERR Generation      | PASS   |
| Scoreboard Verification | PASS   |

---


## 📈 Simulation Waveform

<img width="1543" height="702" alt="image" src="https://github.com/user-attachments/assets/9eede11a-7d35-40e1-b06a-d41127152e6a" />


## 🚀 How to Run

1. Open **Xilinx Vivado**.
2. Create a new RTL project.
3. Add the following files:

   * `apb_slave.sv`
   * `tb_top.sv`
4. Set `tb_top` as the simulation top module.
5. Run **Behavioral Simulation**.
6. Observe the waveform and verify APB transactions, state transitions, and scoreboard messages.

---



## 🛠️ Tools Used

* SystemVerilog
* Xilinx Vivado
* Behavioral Simulation
* Object-Oriented Verification (OOP)
* Mailboxes
* Virtual Interface
* Scoreboard-Based Verification
