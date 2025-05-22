# POP-ANR_MDR

## Overview

The goal of this project is to design a hardware system that can detect hardware attacks such as glitch attacks (on the reference clock `clk_s`, detected by the `Detector` module) or POTAs (on the output of the ring oscillator `ro_out`, detected by the `ATM` module) and trigger alarms based on the detected events.
The system is structured for FPGA implementation, with support for simulation and synthesis using Xilinx Vivado or compatible tools.

## Directory Structure

- `New_Full_MdR/New_Full_MdR.srcs/sources_1/new/` — Main VHDL source files (e.g., `MdR.vhd`, `ATM.vhd`, `Detector.vhd`, etc.)
- `New_Full_MdR/New_Full_MdR.srcs/constrs_1/new/` — Constraints files for different FPGA boards (e.g., `New_Full_MdR_Basys3.xdc`)
- `New_Full_MdR/New_Full_MdR.srcs/sim_1/new/` — VHDL testbenches for simulation (e.g., `MdR_TB.vhd`)

## Main Components

- **MdR.vhd**: Top-level entity integrating submodules for signal processing and alarm generation.
- **Detector.vhd**: Module for detecting specific signal events and triggering alarms.
- **ATM.vhd**: Auto Test Module for automated signal analysis.
- **RO_SIRO.vhd**: Ring Oscillator and SIRO module for generating clock signals.

## Constraints

Constraints files (`.xdc`) define pin assignments, clock settings, and special properties for synthesis. For example, `New_Full_MdR_Basys3.xdc` configures:
- Voltage and IO standards
- Pin mapping for inputs/outputs (e.g., reset, enable, alarms, stored values)
- Clock and combinatorial loop allowances for ring oscillators

## Testbenches

Testbenches (e.g., `MdR_TB.vhd`) provide simulation environments for:
- Instantiating the top-level and submodules
- Applying stimulus to inputs (clock, reset, enable, etc.)
- Observing outputs like alarms and stored values
- Verifying correct operation through simulation tools

## How to Build and Simulate

1. **Clone the repository** to your local machine.
2. **Open Vivado or your preferred VHDL tool.**
3. **Open the project** `New_Full_MdR/New_Full_MdR.xpr`.
4. **Enable the appropriate constraints file** from `constrs_1/new/` for your target FPGA board.
5. **Select the appropriate testbench file as top module** from `sim_1/new/` for your target FPGA board.
6. **Run simulation** to verify functionality.
7. **Synthesize and implement** the design for your FPGA.
8. **Program the FPGA** and observe outputs (LEDs, etc.) as defined in the constraints.

## Requirements

- Xilinx Vivado (recommended) or compatible VHDL synthesis/simulation tool
- Supported FPGA board (e.g., Basys3, CMODS7, S7)

## Notes

- Ensure the correct `.xdc` file is used for your board.
- Some signals are disabled in the constraints for unused outputs.
- The design uses combinatorial loops for ring oscillators; simulation settings in the constraints are critical for correct behavior.