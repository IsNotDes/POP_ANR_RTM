set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]

## EXTREMEMENT IMPORTANT POUR AVOIR DES SIMULATIONS CORRECTES EN POST-IMPLEMENTATION AVEC LES ROs
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets RO_SIRO_UUT/UUT_RO/Inverters[*]]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets RO_SIRO_UUT/UUT_RO/Nand_out]

# Allow combinatorial loops for the oscillator
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets RO_SIRO_UUT/GENERATE_SIRO[*].UUT_SIRO/Invertersattack]

set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets clk_s_IBUF]

create_clock -name clk_s -period 1538.46 -waveform {0 769.23} [get_nets clk_s_IBUF] # 1538.46 ns period
create_clock -name ro_out -period 38.46 -waveform {0 19.23} [get_nets ro_out] # 38.46 ns period

## Enable RO and SIRO
set_property PACKAGE_PIN D2 [get_ports enable_ro_and_siro]
set_property IOSTANDARD LVCMOS33 [get_ports enable_ro_and_siro]
# set_property PACKAGE_PIN D1 [get_ports reset]
# set_property IOSTANDARD LVCMOS33 [get_ports reset]

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
set_property -dict { PACKAGE_PIN A2    IOSTANDARD LVCMOS33 } [get_ports {edge_count[2]}]
set_property -dict { PACKAGE_PIN B2    IOSTANDARD LVCMOS33 } [get_ports {edge_count[1]}]
set_property -dict { PACKAGE_PIN B1    IOSTANDARD LVCMOS33 } [get_ports {edge_count[0]}]
set_property -dict { PACKAGE_PIN C1    IOSTANDARD LVCMOS33 } [get_ports {edges_done}]

set_property -dict { PACKAGE_PIN A4    IOSTANDARD LVCMOS33 } [get_ports {reset}]

##Pmod Header JB
##Sch name = JB1
set_property PACKAGE_PIN J2 [get_ports clk_s]					
set_property IOSTANDARD LVCMOS33 [get_ports clk_s]
##Sch name = JB2
set_property PACKAGE_PIN H2 [get_ports ro_out]					
set_property IOSTANDARD LVCMOS33 [get_ports ro_out]
##Sch name = JB3
set_property PACKAGE_PIN H4 [get_ports gbf_out]					
set_property IOSTANDARD LVCMOS33 [get_ports gbf_out]