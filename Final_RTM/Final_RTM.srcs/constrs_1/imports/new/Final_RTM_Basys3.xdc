# Basys3 Constraints File

# You will have to change the constraints for the counter outputs, since there isn't enough room for these outputs in LEDs.

## Basys3 Voltage configuration
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

## Sch name = BTNC (Center Button)
set_property PACKAGE_PIN U18 [get_ports reset]					
    set_property IOSTANDARD LVCMOS33 [get_ports reset]

## Enable RO and SIRO
set_property PACKAGE_PIN V17 [get_ports enable_ro_and_siro]
    set_property IOSTANDARD LVCMOS33 [get_ports enable_ro_and_siro]

## Alarms Outputs (LED)
set_property PACKAGE_PIN U16 [get_ports Alarm_OMM]					
    set_property IOSTANDARD LVCMOS33 [get_ports Alarm_OMM]
set_property PACKAGE_PIN E19 [get_ports Alarm_Detector]					
	set_property IOSTANDARD LVCMOS33 [get_ports Alarm_Detector]

##Pmod Header JA
#set_property -dict { PACKAGE_PIN J1   IOSTANDARD LVCMOS33 } [get_ports {q_str_d[4]}]
#set_property -dict { PACKAGE_PIN L2   IOSTANDARD LVCMOS33 } [get_ports {q_str_d[3]}]
#set_property -dict { PACKAGE_PIN J2   IOSTANDARD LVCMOS33 } [get_ports {q_str_d[2]}]
#set_property -dict { PACKAGE_PIN G2   IOSTANDARD LVCMOS33 } [get_ports {q_str_d[1]}]
#set_property -dict { PACKAGE_PIN H1   IOSTANDARD LVCMOS33 } [get_ports {q_str_d[0]}]

##Pmod Header JB
set_property -dict { PACKAGE_PIN A14   IOSTANDARD LVCMOS33 } [get_ports {q_str_omm[7]}]
set_property -dict { PACKAGE_PIN A16   IOSTANDARD LVCMOS33 } [get_ports {q_str_omm[6]}]
set_property -dict { PACKAGE_PIN B15   IOSTANDARD LVCMOS33 } [get_ports {q_str_omm[5]}]
set_property -dict { PACKAGE_PIN B16   IOSTANDARD LVCMOS33 } [get_ports {q_str_omm[4]}]
set_property -dict { PACKAGE_PIN A15   IOSTANDARD LVCMOS33 } [get_ports {q_str_omm[3]}]
set_property -dict { PACKAGE_PIN A17   IOSTANDARD LVCMOS33 } [get_ports {q_str_omm[2]}]
set_property -dict { PACKAGE_PIN C15   IOSTANDARD LVCMOS33 } [get_ports {q_str_omm[1]}]
set_property -dict { PACKAGE_PIN C16   IOSTANDARD LVCMOS33 } [get_ports {q_str_omm[0]}]

##Pmod Header JC
set_property -dict { PACKAGE_PIN P18   IOSTANDARD LVCMOS33 } [get_ports {edges_done}]

set_property -dict { PACKAGE_PIN M19   IOSTANDARD LVCMOS33 } [get_ports {clk_s}]
set_property -dict { PACKAGE_PIN P17   IOSTANDARD LVCMOS33 } [get_ports {ro_out}]
set_property -dict { PACKAGE_PIN R18   IOSTANDARD LVCMOS33 } [get_ports {gbf_out}]

set_property CONFIG_MODE SPIx4 [current_design]