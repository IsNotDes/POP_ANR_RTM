# POP-ANR_MTR

## Overview

The goal of this project is to design a hardware system that can detect hardware attacks. Example of hardware attacks would be glitch attacks (on the reference clock `clk_s`, detected by the `Detector` module), or thermal attacks (on the output of the ring oscillator `ro_out`, detected by the `OMM` module). When an attack is detected, an alarm is triggered (`Alarm_Detector` or/and `Alarm_OMM`). The system is structured for FPGA implementation, with support for simulation and synthesis using Xilinx Vivado or compatible tools.

## Directory Structure

The project is structured as follows:

- `Heatmaps` — Heatmaps of the simulation results
- `Miscellaneous` — Miscellaneous files
- `Final_RTM` — Code of the final version of the system
    - `Final_RTM.srcs/sources_1/imports/new/` — Main VHDL source files:
      - `RTM.vhd` (top-level)
        - `OMM.vhd`
            - `Alarm_Manage_OMM.vhd`, `Comparator_OMM.vhd`, `Counter_OMM.vhd`, `Counter_Edges_OMM.vhd`, `Storing_OMM.vhd`
        - `Detector.vhd`
            - `Comparator_Detector.vhd`, `Counter_Detector.vhd`, `Storing_Detector.vhd`, `Falling_Edge_Detector.vhd`
        - `RO_SIRO.vhd`
            - `RO.vhd`, `SIRO.vhd`
    - `Final_RTM.srcs/constrs_1/imports/new/` — Constraints files for different FPGA boards:
      - `Final_RTM_Basys3.xdc` (Basys3)
      - `Final_RTM_CMODS7.xdc` (CMODS7)
      - `Final_RTM_S7.xdc` (S7)
    - `Final_RTM.srcs/sim_1/imports/new/` — VHDL testbenches for simulation:
      - `RTM_TB.vhd`, `RTM_TB_SIMPLE_OMM.vhd`, `RTM_TB_SIMPLE_D.vhd`, `RTM_TB_SIMPLE_FULL.vhd`, `RO_SIRO_TB.vhd`
- `Old_Code` — Old code files
- `Project_Overviews` — Project presentation and report
- `Simulation_Results` — Simulation results
- `State_of_the_Art` — State of the Art reports
- `Example_Campaign_Setup.png` — Picture of the campaign setup
- `Heatmap_Generation.ipynb` — Jupyter notebook for heatmap generation
- `RTM_Latest_Simulation_Results.png` — Latest simulation results from `RTM_TB.vhd`

## Main Components

Here is a list of the main components of the system:

- **RTM.vhd**: Top-level entity integrating submodules for signal processing and alarm generation.
    - **OMM.vhd**: Online-Monitoring Mechanism to detect thermal attacks.
        - `Alarm_Manage_OMM.vhd`, `Comparator_OMM.vhd`, `Counter_OMM.vhd`, `Counter_Edges_OMM.vhd`, `Storing_OMM.vhd`
    - **Detector.vhd**: Detector Module for detecting clock glitch attacks.
        - `Comparator_Detector.vhd`, `Counter_Detector.vhd`, `Storing_Detector.vhd`, `Falling_Edge_Detector.vhd`
    - **RO_SIRO.vhd**: Ring Oscillator and SIRO Module for generating clock signals.
        - `RO.vhd`, `SIRO.vhd`

## Constraints

The constraints files are used to define the pin assignments, clock settings, and special properties for synthesis. Provided for multiple FPGA boards:
- `Final_RTM_Basys3.xdc`: Basys3 board
- `Final_RTM_CMODS7.xdc`: CMODS7 board
- `Final_RTM_S7.xdc`: S7 board

These files configure:
- Voltage and IO standards
- Pin mapping for inputs/outputs (reset, enable, alarms, stored values, etc.)
- Clock and combinatorial loop allowances for ring oscillators

## Testbenches

The testbenches provide simulation environments for verifying correct operation:
- `RTM_TB.vhd`: Full system testbench
    - This will be used to generate a CSV file in the `Simulation_Results` folder that will be used to generate a heatmap of the simulation results (see `Heatmap_Generation.ipynb` and chapter "Heatmap generation")
- `RTM_TB_SIMPLE_OMM.vhd`: Simplified OMM module testbench
- `RTM_TB_SIMPLE_D.vhd`: Simplified Detector module testbench
- `RTM_TB_SIMPLE_FULL.vhd`: Simplified full system testbench
- `RO_SIRO_TB.vhd`: Ring Oscillator & SIRO testbench

They instantiate the top-level and submodules, apply stimulus to inputs (clock, reset, enable, etc.), and observe outputs (alarms, stored values, etc.).

## How to Build, Simulate and Program the System

To build, simulate and program the system, follow these steps:

1. **Clone the repository** to your local machine.
2. **Open Vivado or your preferred VHDL tool.**
3. **Open the project** `Final_RTM/Final_RTM.xpr`.
4. **Enable the appropriate constraints file** from `constrs_1/` for your target FPGA board and disable the others.
5. **Select the appropriate testbench file as top module** from `sim_1/` for your target FPGA board.
6. **Run simulation** (Behavioral, Post-synthesis or Post-implementation) to verify functionality.
7. **Generate the bitstream** for your FPGA (if not done already).
8. **Program the FPGA** with the generated bitstream.
9. **Observe the outputs** (alarms, stored values, etc.) as defined in the constraints.

## Requirements

The system requires the following tools:

- Xilinx Vivado (recommended) or compatible VHDL synthesis/simulation tool
- Supported FPGA board (e.g., Basys3, CMODS7, S7)

For the campaign, the following tools are required:
- 1 GBF
- 1 Oscilloscope
- 4 Breadboards
- 8 FPGAs
- 1 USB Hub
- A lot of wires
- 3 Oscilloscope probes (not small probes, as they are not suitable for this purpose)
- 1 USB-A to USB-B cable
- 8 USB-A to Micro-USB cables
- Power outlet
- PC with Vivado installed

## Heatmap generation

It is possible to generate heatmaps of the simulations results done by the `RTM_TB.vhd` testbench. The heatmap generation is done using a Jupyter notebook `Heatmap_Generation.ipynb`. Some examples of simulation results are provided in the `Simulation_Results` folder. The generated heatmaps are saved in the `Heatmaps` folder.

## Programming FPGA EEPROM

This will allow your bitstream to persist even after any power-off incidents or if you disconnect the FPGAs. They should already be preprogrammed, but just in case, we will discuss the steps necessary here :

1. Generate the bitstream.

2. Generate directly or from Tools the Memory Configuration File.

3. Select Memory part, the model of your FPGA memory (mx25l3233f-spi-x1-x2-x4 for CMODS7) and put the filename that you want (ex. 0SIRO...).

4. Select Interface SPIx4.

5. Check load bitstream files.

6. Put your bitstream file (bitfile, which should be in .runs/impl1/*.bit).

7. Overwrite just in case you have to redo it. Press OK.

8. Add Configuration Memory File.

9. Select the model of your FPGA memory again (mx25l3233f-spi-x1-x2-x4 for CMODS7) for the Configuration Memory part.

10. Select your generated Memory Configuration File from step 2 to 7.

11. Don't put any PRM file. Press OK.

12. Program your FPGA as usual.

13. Repeat all steps when bitstream has to be changed, else you can skip to step 8.

## Campaign

The goal of the campaign is to test the robustness of the `OMM` module. The campaign is done by using a GBF, an oscilloscope, breadboards, an USB Hub, wires, and oscilloscope probes.

### Campaign protocol

Use the `Example_Campaign_Setup.png` picture as a reference for the campaign setup.

1. Ensure that the FPGAs and wires are properly placed.

The FPGAs and wires should be placed in the breadboard as shown in the picture. 

The green/yellow wires represent the system clock, and are connected to the `clk_s` pin of each FPGA. Be sure to use the right side of the breadboard for the green/yellow wires, as `clk_s` should be a global clock signal.

The orange/red wires represent the output from the GBF, and are connected to the `gbf_out` pin of each FPGA. These will be left floating, until the validation of the `OMM` module.

The purple/blue wires represent the output from the ring oscillator (internal ring oscillator or external ring oscillator from GBF), and are connected to the `ro_out` pin of each FPGA. These will be left floating, until the validation of the `OMM` module.

The grey/white wires represent the enable signal for the internal ring oscillator and SIROs. When this signal is low, the internal ring oscillator and SIROs are disabled. Instead, the external ring oscillator (from the GBF) is used. When the signal is high, the internal ring oscillator and SIROs are enabled. These are connected to the `enable_ro_and_siro` pin of each FPGA. As default, the internal ring oscillator and SIROs are enabled. This is done by putting the grey/white wire to the ground of each FPGA. This will be the case until the validation of the `OMM` module.

2. Ensure that the GBF is properly configured and connected to the FPGAs.

The first signal of the GBF will be `clk_s`, which is the system clock. It should be connected to the pin `clk_s` of each FPGA. The second signal of the GBF will be `gbf_out`, which is the output from the GBF used in validations. It will be connected to the pin `gbf_out` of each FPGA, one by one, during the validation of the `OMM` module.

Here are the parameters that should be used for these signals:
- `clk_s`
  - `Frequency`: 600 kHz
  - `Amplitude`: 3.3 V
  - `Offset`: 1.65 V
  - `Phase`: 0
  - `Duty Cycle`: 50%
- `gbf_out`
  - `Frequency`: 24 MHz
  - `Amplitude`: 3.3 V
  - `Offset`: 1.65 V
  - `Phase`: 0
  - `Duty Cycle`: 50%

Be sure to avoid using the small oscilloscope probes to transfer the signals from the GBF to the FPGAs, as they are not suitable for this purpose.

3. Ensure that the oscilloscope is properly connected to the FPGAs.

The oscilloscope will be used to measure the `ro_out` signal of the FPGAs during the validation of the `OMM` module, one by one (you will only need one oscilloscope probe for this purpose).

4. Ensure that the FPGAs are properly connected to the PC.

Connect the USB Hub with the USB-A to USB-B cable to a PC with Vivado installed, and the Vivado project `New_Full_MdR.xpr` opened. Connect the power cable from the USB Hub to a power outlet. You should have 8 USB ports available on the USB Hub, and 8 USB-A to Micro-USB cables. Connect each USB-A to Micro-USB cable to a Micro-USB port of each FPGA. For easier programming, you should do it in an ordered way, for example, first connect the lower FPGAs, then the upper FPGAs. The recommended way would be to first connect the lower FPGA of the first breadboard, then the upper FPGA of the first breadboard, then the lower FPGA of the second breadboard, then the upper FPGA of the second breadboard, and so on. After that, press the Power button of the USB Hub to power on the FPGAs.

5. Ensure that the right `.xdc` file is used for your boards. As default, it should be `Final_RTM_CMODS7.xdc`.

6. Ensure that the right top module is selected for the bitstream generation for the campaign. As default, it should be `RTM.vhd`.

7. Generate the bitstream for the campaign (not necessary if you already programmed the bitstream on the EEPROM of the FGPA, see section ).

8. Press the outputs buttons of the GBF so that the outputs are applied to the FPGAs.

9. Program the FPGAs with the generated bitstream. Again, it should be done in the same ordered way you connected the FPGAs to the PC, for example, first lower FPGAs, then upper FPGAs. The recommended way would be to first lower FPGA of the first breadboard, then upper FPGA of the first breadboard, then lower FPGA of the second breadboard, then upper FPGA of the second breadboard, and so on.

10. All the FPGAs should have no alarms raised yet (no LEDS lit up). If an alarm is raised, check that you followed the steps correctly.
   
11. Let the FPGAs run for a while (recommended duration is one day).
   
12. After the duration, check the frequency of the output of the oscillator `ro_out` with the oscilloscope for each FPGA. Write it down.
   
13. Put the grey/white wire of each FPGA to the ground. This will disable the internal ring oscillator and SIROs, and enable the external ring oscillator (from the GBF) which we'll use for the validations of the modules. Let them cool down for a while (until they are at room temperature, which would be around 50°C for them), then check if any alarms are raised on the FPGAs. Write it down.

14. Check if the `Detector`, and the `OMM` modules are working correctly. *When you change any frequency, you should ALWAYS use the reset button, to check if the alarms stay, as sometimes changing the frequencies too fast will cause false alarms.* Don't forget to put the oscilloscope probe on the `gbf_out` pin of each FPGA before following these next steps to verify the modules.

15. Before checking the `Detector` and `OMM` modules, be sure to, in this exact order, activate the external ring oscillator (from the GBF), and put the grey/white wire of each FPGA to the ground. This will disable the internal ring oscillator and SIROs, and enable the external ring oscillator (from the GBF) which we'll use for the validations of the modules.

16. Check if the `Detector` module is working correctly. To do this, position the GBF signals (if not already done) on the nominal frequencies, which were defined in the previous steps. Go above this nominal frequency by the margin in percentage defined for the `Detector` module. In this case, you should go above 780 kHz. Write down the results for the alarms. Go back to the nominal frequency for `clk_s`. Go below this nominal frequency by the margin in percentage defined for the `Detector` module. In this case, you should go below 420 kHz. Write down the results for the alarms. Go back to the nominal frequency for `clk_s`.

17. Check if the `OMM` module is working correctly. To do this, position the GBF signals (if not already done) on the nominal frequencies, which were defined in the previous steps. Go above this nominal frequency by the margin in percentage defined for the `OMM` module. In this case, you should go above 26.4 MHz. Write down the results for the alarms. Go back to the nominal frequency for `ro_out`. Go below this nominal frequency by the margin in percentage defined for the `OMM` module. In this case, you should go below 21.6 MHz. Write down the results for the alarms. Go back to the nominal frequency for `ro_out`.

18. After checking the `Detector` and `OMM` modules, be sure to, in this exact order, deactivate the external ring oscillator (from the GBF), and put the grey/white wire of each FPGA to the high (3.3 V, VDD, or VU for CMODS7). This will disable the external ring oscillator (from the GBF), and enable the internal ring oscillator and SIROs.

19. Repeat steps 11 to 18 until the end of the campaign.