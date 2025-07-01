# POP-ANR_MTR

## Overview

The goal of this project is to design a hardware system that can detect hardware attacks. Example of hardware attacks would be glitch attacks (on the reference clock `clk_s`, detected by the `Detector` module), or thermal attacks (on the output of the ring oscillator `ro_out`, detected by the `ATM` module). When an attack is detected, an alarm is triggered (`Alarm_Detector` or/and `Alarm_ATM`). The system is structured for FPGA implementation, with support for simulation and synthesis using Xilinx Vivado or compatible tools.

## Directory Structure

The project is structured as follows:

- `Heatmaps` — Heatmaps of the simulation results
- `Miscellaneous` — Miscellaneous files
- `New_Full_MTR_Campaign` — Campaign files for Xilinx Vivado
    - `New_Full_MdR.srcs/sources_1/new/` — Main VHDL source files:
      - `MdR.vhd` (top-level)
        - `ATM.vhd`
            - `Alarm_Manage_ATM.vhd`, `Comparator_ATM.vhd`, `Counter_ATM.vhd`, `Counter_Edges_ATM.vhd`, `Storing_ATM.vhd`
        - `Detector.vhd`
            - `Comparator_Detector.vhd`, `Counter_Detector.vhd`, `Storing_Detector.vhd`, `Falling_Edge_Detector.vhd`
        - `RO_SIRO.vhd`
            - `RO.vhd`, `SIRO.vhd`
    - `New_Full_MdR.srcs/constrs_1/new/` — Constraints files for different FPGA boards:
      - `New_Full_MdR_Basys3.xdc` (Basys3)
      - `New_Full_MdR_CMODS7.xdc` (CMODS7)
      - `New_Full_MdR_S7.xdc` (S7)
    - `New_Full_MdR.srcs/sim_1/new/` — VHDL testbenches for simulation:
      - `MdR_TB.vhd`, `MdR_TB_SIMPLE_ATM.vhd`, `MdR_TB_SIMPLE_D.vhd`, `MdR_TB_SIMPLE_FULL.vhd`, `RO_SIRO_TB.vhd`
- `Old_Code` — Old code files
- `Project_Overviews` — Project presentation and report
- `Simulation_Results` — Simulation results
- `State_of_the_Art` — State of the Art reports
- `Heatmap_Generation.ipynb` — Jupyter notebook for heatmap generation
- `MTR_Latest_Simulation_Results.png` — Latest simulation results from `MdR_TB.vhd`

## Main Components

Here is a list of the main components of the system:

- **MdR.vhd**: Top-level entity integrating submodules for signal processing and alarm generation.
    - **ATM.vhd**: Auto Test Module to detect POTAs.
        - `Alarm_Manage_ATM.vhd`, `Comparator_ATM.vhd`, `Counter_ATM.vhd`, `Counter_Edges_ATM.vhd`, `Storing_ATM.vhd`
    - **Detector.vhd**: Module for detecting clock glitch attacks.
        - `Comparator_Detector.vhd`, `Counter_Detector.vhd`, `Storing_Detector.vhd`, `Falling_Edge_Detector.vhd`
    - **RO_SIRO.vhd**: Ring Oscillator and SIRO module for generating clock signals.
        - `RO.vhd`, `SIRO.vhd`

## Constraints

The constraints files are used to define the pin assignments, clock settings, and special properties for synthesis. Provided for multiple FPGA boards:
- `New_Full_MdR_Basys3.xdc`: Basys3 board
- `New_Full_MdR_CMODS7.xdc`: CMODS7 board
- `New_Full_MdR_S7.xdc`: S7 board

These files configure:
- Voltage and IO standards
- Pin mapping for inputs/outputs (reset, enable, alarms, stored values, etc.)
- Clock and combinatorial loop allowances for ring oscillators

## Testbenches

The testbenches provide simulation environments for verifying correct operation:
- `MdR_TB.vhd`: Full system testbench
    - This will be used to generate a CSV file in the `Simulation_Results` folder that will be used to generate a heatmap of the simulation results (see `Heatmap_Generation.ipynb` and chapter "Heatmap generation")
- `MdR_TB_SIMPLE_ATM.vhd`: Simplified ATM module testbench
- `MdR_TB_SIMPLE_D.vhd`: Simplified Detector module testbench
- `MdR_TB_SIMPLE_FULL.vhd`: Simplified full system testbench
- `RO_SIRO_TB.vhd`: Ring Oscillator & SIRO testbench

They instantiate the top-level and submodules, apply stimulus to inputs (clock, reset, enable, etc.), and observe outputs (alarms, stored values, etc.).

## How to Build and Simulate

To build and simulate the system, follow these steps:

1. **Clone the repository** to your local machine.
2. **Open Vivado or your preferred VHDL tool.**
3. **Open the project** `New_Full_MTR/New_Full_MdR.xpr`.
4. **Enable the appropriate constraints file** from `constrs_1/new/` for your target FPGA board.
5. **Select the appropriate testbench file as top module** from `sim_1/new/` for your target FPGA board.
6. **Run simulation** to verify functionality.
7. **Synthesize and implement** the design for your FPGA.
8. **Program the FPGA** and observe outputs (LEDs, etc.) as defined in the constraints.

## Requirements

The system requires the following tools:

- Xilinx Vivado (recommended) or compatible VHDL synthesis/simulation tool
- Supported FPGA board (e.g., Basys3, CMODS7, S7)

## Heatmap generation

It is possible to generate heatmaps of the simulations results done by the `MdR_TB.vhd` testbench. The heatmap generation is done using a Jupyter notebook `Heatmap_Generation.ipynb`. Some examples of simulation results are provided in the `Simulation_Results` folder. The generated heatmaps are saved in the `Heatmaps` folder.

## Campaign

The goal of the campaign is to test the robustness of the `ATM` module. The campaign is done by using a GBF, an oscilloscope, breadboards, an USB Hub, wires, and oscilloscope probes.

### Campaign steps

1. 

## Notes

- Ensure the correct `.xdc` file is used for your board.
- Some signals are disabled in the constraints for unused outputs.
- The design uses combinatorial loops for ring oscillators; simulation settings in the constraints are critical for correct behavior.