# Allow combinatorial loops for the oscillator (adapted for Spartan 7)
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets GENERATE_RO[*].UUT_RO/Inverters[*]]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets GENERATE_SIRO[*].UUT_SIRO/Invertersattack]

# Set configuration voltage and CFGBVS for Spartan 7
set_property CFGBVS GND [current_design]
set_property CONFIG_VOLTAGE 1.8 [current_design]

# Adjust DRC checks severity
set_property SEVERITY {Warning} [get_drc_checks LUTLP-1]
set_property SEVERITY {Warning} [get_drc_checks NSTD-1]
set_property SEVERITY {Warning} [get_drc_checks UCIO-1]

# Protect SIRO-related cells and nets from optimization
set_property DONT_TOUCH true [get_cells -hierarchical *UUT_SIRO*]
set_property DONT_TOUCH true [get_nets -hierarchical *activate_SIRO*]

# Optionally mark debug nets (commented out as per your original file)
# set_property MARK_DEBUG true [get_nets -hierarchical *ROattack_dummy_out*]

# Create PBlock for SIROs (adapted for Spartan 7 slice range)
create_pblock SIRO_Pblock
resize_pblock SIRO_Pblock -add {SLICE_X0Y50:SLICE_X20Y99}  ;# Adjust slice range based on Spartan 7 resources
add_cells_to_pblock SIRO_Pblock [get_cells -hierarchical -filter {NAME =~ "GENERATE_SIRO*"}]
set_property IS_SOFT FALSE [get_pblocks SIRO_Pblock]

# Create PBlock for ROs (adapted for Spartan 7 slice range)
create_pblock RO_Pblock
resize_pblock RO_Pblock -add {SLICE_X0Y0:SLICE_X20Y49}  ;# Adjust slice range based on Spartan 7 resources
add_cells_to_pblock RO_Pblock [get_cells -hierarchical -filter {NAME =~ "GENERATE_RO*"}]
set_property IS_SOFT FALSE [get_pblocks RO_Pblock]

# Map Enable to a switch and RO_OUT to an LED (adapted for Spartan 7 pinout)
set_property PACKAGE_PIN B11 [get_ports Enable]  ;# Pin B11 (IO_L1P_T0_D00_MOSI_14) for Enable
set_property IOSTANDARD LVCMOS33 [get_ports Enable]

# Map EnableROattack to a switch (updated pin assignment)
set_property PACKAGE_PIN D3 [get_ports EnableROattack]  ;# Pin D3 (IO_L1P_T0_34) for EnableROattack
set_property IOSTANDARD LVCMOS33 [get_ports EnableROattack]

# Map ROattack_dummy_out to a pin (adapted for Spartan 7 pinout)
set_property PACKAGE_PIN F3 [get_ports ROattack_dummy_out]  ;# Pin F3 (IO_L8P_T1_34) for ROattack_dummy_out
set_property IOSTANDARD LVCMOS33 [get_ports ROattack_dummy_out]