# D Flip-Flop Verification using SystemVerilog UVM

## Overview

This project implements and verifies a positive-edge triggered D Flip-Flop using the Universal Verification Methodology (UVM). The verification environment was developed in SystemVerilog following a modular UVM architecture to ensure functional correctness through constrained-random testing, assertions, scoreboarding, and coverage-driven verification.

---

## Project Objectives

- Design a positive-edge triggered D Flip-Flop RTL.
- Build a reusable UVM verification environment.
- Verify functionality using constrained-random stimulus.
- Detect mismatches using a scoreboard.
- Validate protocol behavior using SystemVerilog Assertions (SVA).
- Measure verification completeness using code and functional coverage.

---

## Verification Environment

The UVM testbench consists of the following components:

- Transaction
- Sequence
- Sequencer
- Driver
- Monitor
- Agent
- Environment
- Scoreboard
- Test
- Interface
- Assertions
- Functional Coverage

---

## Verification Flow

```
Sequence
    │
    ▼
Sequencer
    │
    ▼
Driver
    │
    ▼
D Flip-Flop DUT
    │
    ▼
Monitor
    │
    ├────────────► Scoreboard
    │
    ├────────────► Functional Coverage
    │
    └────────────► Assertions
```

---

## Tools Used

| Tool | Version |
|------|---------|
| QuestaSim | 10.7c |
| Language | SystemVerilog |
| Methodology | UVM 1.1d |

---

## Verification Results

| Metric | Result |
|---------|---------|
| UVM Errors | 0 |
| Statement Coverage | 100% |
| Branch Coverage | 100% |
| Toggle Coverage | 100% |
| Expression Coverage | 100% |
| Functional Coverage | 95% |

---

## Functional Coverage Analysis

The uncovered functional coverage bin corresponds to:

```
rst_n = 0
D = 1
```

This scenario is not exercised because reset is asserted before stimulus generation begins. Since the D input is functionally ignored while reset is active, this combination does not affect DUT functionality.

Possible improvements include:

- Add a directed reset test.
- Add a dedicated reset sequence.
- Exclude the bin using `ignore_bins` if permitted by the verification plan.

---

## Repository Contents

```
.
├── dff_design.sv
├── dff_if.sv
├── dff_pkg.sv
├── dff_top.sv
├── run.do
├── README.md
├── LICENSE
└── .gitignore
```

---

## Key Features

- Positive-edge triggered D Flip-Flop RTL
- Complete UVM verification environment
- Constrained-random verification
- Functional coverage
- Code coverage
- Scoreboard-based checking
- SystemVerilog Assertions
- Coverage-driven verification
- QuestaSim simulation support

---

## Future Enhancements

- Multiple directed test cases
- Regression automation
- Makefile support
- Jenkins CI integration
- GitHub Actions for regression
- Parameterized D Flip-Flop
- Reset sequence library

---

## Author

**Chidanand Kumbalavati**

Electronics and Communication Engineering

VLSI Design & Verification Engineer (Aspiring)
