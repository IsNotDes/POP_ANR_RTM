# CMODS7 Constraints File

## CMODS7 Voltage configuration
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]

## Required for correct simulation results post implementation
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets RO_SIRO_UUT/UUT_RO/Inverters[*]]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets RO_SIRO_UUT/UUT_RO/Nand_out]

## Allow combinatorial loops for the oscillator
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets RO_SIRO_UUT/GENERATE_SIRO[*].UUT_SIRO/Invertersattack]

## Clock dedicated route
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets clk_s_IBUF]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets reset_IBUF]

## Enable RO and SIRO
#set_property PACKAGE_PIN D2 [get_ports enable_ro_and_siro]
#set_property IOSTANDARD LVCMOS33 [get_ports enable_ro_and_siro]
set_property PACKAGE_PIN D1 [get_ports reset]
set_property IOSTANDARD LVCMOS33 [get_ports reset]

## Alarms Outputs (LED)
set_property PACKAGE_PIN E2 [get_ports Alarm_ATM]					
set_property IOSTANDARD LVCMOS33 [get_ports Alarm_ATM]
set_property PACKAGE_PIN K1 [get_ports Alarm_Detector]					
set_property IOSTANDARD LVCMOS33 [get_ports Alarm_Detector]

## Dedicated Digital I/O on the PIO Headers

# q_str_d[7:0]
set_property -dict { PACKAGE_PIN L1    IOSTANDARD LVCMOS33 } [get_ports {q_str_d[7]}]
set_property -dict { PACKAGE_PIN M4    IOSTANDARD LVCMOS33 } [get_ports {q_str_d[6]}]
set_property -dict { PACKAGE_PIN M3    IOSTANDARD LVCMOS33 } [get_ports {q_str_d[5]}]
set_property -dict { PACKAGE_PIN N2    IOSTANDARD LVCMOS33 } [get_ports {q_str_d[4]}]
set_property -dict { PACKAGE_PIN M2    IOSTANDARD LVCMOS33 } [get_ports {q_str_d[3]}]
set_property -dict { PACKAGE_PIN P3    IOSTANDARD LVCMOS33 } [get_ports {q_str_d[2]}]
set_property -dict { PACKAGE_PIN N3    IOSTANDARD LVCMOS33 } [get_ports {q_str_d[1]}]
set_property -dict { PACKAGE_PIN P1    IOSTANDARD LVCMOS33 } [get_ports {q_str_d[0]}]

# q_str_atm[15:0]
set_property -dict { PACKAGE_PIN N1    IOSTANDARD LVCMOS33 } [get_ports {q_str_atm[15]}]
set_property -dict { PACKAGE_PIN P14   IOSTANDARD LVCMOS33 } [get_ports {q_str_atm[14]}]
set_property -dict { PACKAGE_PIN P15   IOSTANDARD LVCMOS33 } [get_ports {q_str_atm[13]}]
set_property -dict { PACKAGE_PIN N13   IOSTANDARD LVCMOS33 } [get_ports {q_str_atm[12]}]
set_property -dict { PACKAGE_PIN N15   IOSTANDARD LVCMOS33 } [get_ports {q_str_atm[11]}]
set_property -dict { PACKAGE_PIN N14   IOSTANDARD LVCMOS33 } [get_ports {q_str_atm[10]}]
set_property -dict { PACKAGE_PIN M15   IOSTANDARD LVCMOS33 } [get_ports {q_str_atm[9]}]
set_property -dict { PACKAGE_PIN M14   IOSTANDARD LVCMOS33 } [get_ports {q_str_atm[8]}]
set_property -dict { PACKAGE_PIN L15   IOSTANDARD LVCMOS33 } [get_ports {q_str_atm[7]}]
set_property -dict { PACKAGE_PIN L14   IOSTANDARD LVCMOS33 } [get_ports {q_str_atm[6]}]
set_property -dict { PACKAGE_PIN K14   IOSTANDARD LVCMOS33 } [get_ports {q_str_atm[5]}]
set_property -dict { PACKAGE_PIN J15   IOSTANDARD LVCMOS33 } [get_ports {q_str_atm[4]}]
set_property -dict { PACKAGE_PIN L13   IOSTANDARD LVCMOS33 } [get_ports {q_str_atm[3]}]
set_property -dict { PACKAGE_PIN M13   IOSTANDARD LVCMOS33 } [get_ports {q_str_atm[2]}]
set_property -dict { PACKAGE_PIN J11   IOSTANDARD LVCMOS33 } [get_ports {q_str_atm[1]}]
set_property -dict { PACKAGE_PIN C5    IOSTANDARD LVCMOS33 } [get_ports {q_str_atm[0]}]

# edge_count[2:0], edges_done
#set_property -dict { PACKAGE_PIN A2    IOSTANDARD LVCMOS33 } [get_ports {edge_count[2]}]
#set_property -dict { PACKAGE_PIN B2    IOSTANDARD LVCMOS33 } [get_ports {edge_count[1]}]
set_property -dict { PACKAGE_PIN B1    IOSTANDARD LVCMOS33 } [get_ports {edges_done}]

## Enable RO and SIRO
set_property -dict { PACKAGE_PIN C1    IOSTANDARD LVCMOS33 } [get_ports {enable_ro_and_siro}]

## GBF, System clock, output of RO
set_property -dict { PACKAGE_PIN B3    IOSTANDARD LVCMOS33 } [get_ports {gbf_out}]
set_property -dict { PACKAGE_PIN B4    IOSTANDARD LVCMOS33 } [get_ports {clk_s}] 
set_property -dict { PACKAGE_PIN A3    IOSTANDARD LVCMOS33 } [get_ports {ro_out}]