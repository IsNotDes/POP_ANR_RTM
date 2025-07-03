# S7 Constraints File

## S7 Voltage configuration
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

## Enable RO and reset
set_property PACKAGE_PIN H14 [get_ports enable_ro_and_siro]
    set_property IOSTANDARD LVCMOS33 [get_ports enable_ro_and_siro]
set_property PACKAGE_PIN H18 [get_ports reset]
    set_property IOSTANDARD LVCMOS33 [get_ports reset]

## Alarms Outputs (LED)
set_property PACKAGE_PIN E18 [get_ports Alarm_OMM]					
    set_property IOSTANDARD LVCMOS33 [get_ports Alarm_OMM]
set_property PACKAGE_PIN F13 [get_ports Alarm_Detector]					
    set_property IOSTANDARD LVCMOS33 [get_ports Alarm_Detector]

## Pmod Header JA
set_property -dict { PACKAGE_PIN L17   IOSTANDARD LVCMOS33 } [get_ports {q_str_d[4]}]
set_property -dict { PACKAGE_PIN L18   IOSTANDARD LVCMOS33 } [get_ports {q_str_d[3]}]
set_property -dict { PACKAGE_PIN M14   IOSTANDARD LVCMOS33 } [get_ports {q_str_d[2]}]
set_property -dict { PACKAGE_PIN N14   IOSTANDARD LVCMOS33 } [get_ports {q_str_d[1]}]
set_property -dict { PACKAGE_PIN M16   IOSTANDARD LVCMOS33 } [get_ports {q_str_d[0]}]

## Pmod Header JB
set_property -dict { PACKAGE_PIN P17   IOSTANDARD LVCMOS33 } [get_ports {q_str_omm[7]}]
set_property -dict { PACKAGE_PIN P18   IOSTANDARD LVCMOS33 } [get_ports {q_str_omm[6]}]
set_property -dict { PACKAGE_PIN R18   IOSTANDARD LVCMOS33 } [get_ports {q_str_omm[5]}]
set_property -dict { PACKAGE_PIN T18   IOSTANDARD LVCMOS33 } [get_ports {q_str_omm[4]}]
set_property -dict { PACKAGE_PIN P14   IOSTANDARD LVCMOS33 } [get_ports {q_str_omm[3]}]
set_property -dict { PACKAGE_PIN P15   IOSTANDARD LVCMOS33 } [get_ports {q_str_omm[2]}]
set_property -dict { PACKAGE_PIN N15   IOSTANDARD LVCMOS33 } [get_ports {q_str_omm[1]}]
set_property -dict { PACKAGE_PIN P16   IOSTANDARD LVCMOS33 } [get_ports {q_str_omm[0]}]

## Pmod Header JC
set_property -dict { PACKAGE_PIN U18   IOSTANDARD LVCMOS33 } [get_ports {edges_done}]

## Pmod Header JD
set_property -dict { PACKAGE_PIN V15   IOSTANDARD LVCMOS33 } [get_ports {clk_s}]
set_property -dict { PACKAGE_PIN U12   IOSTANDARD LVCMOS33 } [get_ports {ro_out}]
set_property -dict { PACKAGE_PIN V13   IOSTANDARD LVCMOS33 } [get_ports {gbf_out}]