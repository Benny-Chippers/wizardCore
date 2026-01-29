# WizardCore

WizardCore is a SystemVerilog CPU implementation targeting the **RISC-V RV32I** base integer ISA.

## Status

- **ISA target**: **RV32I** (base integer instructions)
- **Current microarchitecture**: **not yet pipelined** (single-flow / staged design while functionality is validated)
- **Roadmap**:
  - **5-stage pipeline** (IF/ID/EX/MEM/WB)
  - **Out-of-order issue** using **Tomasulo’s algorithm** (future work)

## Repository layout

- `src/1_IF/` — Instruction Fetch stage
- `src/2_ID/` — Instruction Decode stage
- `src/3_EX/` — Execute stage
- `src/4_MEM/` — Memory stage
- `src/5_WB/` — Writeback stage
- `src/TOP/` — Top-level wiring
- `src/COM/` — Common/shared components
- `src/testBench.sv` — Top-level testbench used by the Makefile

## Simulate (before synthesis) using the Makefile

This project uses **Verilator** for fast, pre-synthesis simulation.

### Prerequisites

- Install Verilator (and a C++ toolchain).
- Optional: GTKWave for waveform viewing.

### Common commands

- **Build** (compile SystemVerilog into a runnable simulator):

```bash
make build
```

- **Simulate** (runs the built simulator; produces `output/dump.vcd`):

```bash
make sim
```

- **View waveforms** (opens the VCD with GTKWave):

```bash
make view
```

- **Run + view**:

```bash
make simview
```

- **Clean**:

```bash
make clean
```

### Notes

- The Makefile selects the top-level testbench via `TESTBENCH` (currently `src/testBench.sv`).
- Simulation output is written to `output/` (including `dump.vcd`).

## AI usage policy (Spellbook / Wizard Core)

- **Project codenames**:
  - **Spellbook**: test/code-generation utilities and RISC-V test programs
  - **Wizard Core**: the CPU RTL / SystemVerilog implementation
- **AI-assisted work (allowed in Spellbook)**:
  - AI tools may be used to help **write or refactor code in Spellbook**, including scripts and test code that generate/validate RV32I test programs.
  - When AI is used, the expectation is that outputs are reviewed, tested, and adjusted by a human before merging.
- **No-AI guarantee (Wizard Core RTL)**:
  - **AI is not used to generate the Wizard Core CPU Verilog/RTL.**
  - The CPU implementation is written and maintained by humans to preserve authorship clarity and reduce the risk of subtle functional/corner-case errors from generated RTL.
- **Scope note**:
  - This policy is about *authorship of code*. Using AI for high-level brainstorming or documentation is fine, but **generated Verilog for Wizard Core is explicitly out of scope / not accepted**.
