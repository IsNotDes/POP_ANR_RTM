set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]

## EXTREMEMENT IMPORTANT POUR AVOIR DES SIMULATIONS CORRECTES EN POST-IMPLEMENTATION AVEC LES ROs
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets RO_SIRO_UUT/UUT_RO/Inverters[*]]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets RO_SIRO_UUT/UUT_RO/Nand_out]

# Allow combinatorial loops for the oscillator
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets RO_SIRO_UUT/GENERATE_SIRO[*].UUT_SIRO/Invertersattack]

set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets clk_s_IBUF]

create_clock -name ro_out -period 250 -waveform {0 125} [get_nets ro_out]

## Sch name = BTNC (Center Button)
set_property PACKAGE_PIN U18 [get_ports reset]					
    set_property IOSTANDARD LVCMOS33 [get_ports reset]

## Enable RO and SIRO
set_property PACKAGE_PIN V17 [get_ports enable_ro]
    set_property IOSTANDARD LVCMOS33 [get_ports enable_ro]
set_property PACKAGE_PIN V16 [get_ports enable_siro]
	set_property IOSTANDARD LVCMOS33 [get_ports enable_siro]

## Alarms Outputs (LED)
set_property PACKAGE_PIN U16 [get_ports Alarm_ATM]					
    set_property IOSTANDARD LVCMOS33 [get_ports Alarm_ATM]
set_property PACKAGE_PIN E19 [get_ports Alarm_Detector]					
	set_property IOSTANDARD LVCMOS33 [get_ports Alarm_Detector]

set_property IS_ENABLED false [get_ports {q_str_d[4]}]
set_property IS_ENABLED false [get_ports {q_str_d[3]}]
set_property IS_ENABLED false [get_ports {q_str_d[2]}]
set_property IS_ENABLED false [get_ports {q_str_d[1]}]
set_property IS_ENABLED false [get_ports {q_str_d[0]}]

set_property IS_ENABLED false [get_ports {q_str_atm[7]}]
set_property IS_ENABLED false [get_ports {q_str_atm[6]}]
set_property IS_ENABLED false [get_ports {q_str_atm[5]}]
set_property IS_ENABLED false [get_ports {q_str_atm[4]}]
set_property IS_ENABLED false [get_ports {q_str_atm[3]}]
set_property IS_ENABLED false [get_ports {q_str_atm[2]}]
set_property IS_ENABLED false [get_ports {q_str_atm[1]}]
set_property IS_ENABLED false [get_ports {q_str_atm[0]}]

set_property IS_ENABLED false [get_ports {edge_count[2]}]
set_property IS_ENABLED false [get_ports {edge_count[1]}]
set_property IS_ENABLED false [get_ports {edge_count[0]}]
set_property IS_ENABLED false [get_ports edges_done]

##Pmod Header JB
##Sch name = JB1
set_property PACKAGE_PIN A14 [get_ports clk_s]					
	set_property IOSTANDARD LVCMOS33 [get_ports clk_s]
##Sch name = JB2
set_property PACKAGE_PIN A16 [get_ports ro_out]					
	set_property IOSTANDARD LVCMOS33 [get_ports ro_out]
##Sch name = JB3
set_property PACKAGE_PIN B15 [get_ports gbf_out]					
	set_property IOSTANDARD LVCMOS33 [get_ports gbf_out]