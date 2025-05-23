## This file is a general .xdc for the Basys3 rev B board
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project

#set_property SEVERITY {Warning} [get_drc_checks LUTLP-1]
#set_property SEVERITY {Warning} [get_drc_checks LUTLP-2]
#set_property SEVERITY {Warning} [get_drc_checks NSTD-1]
#set_property SEVERITY {Warning} [get_drc_checks UCIO-1]

set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]

## EXTREMEMENT IMPORTANT POUR AVOIR DES SIMULATIONS CORRECTES EN POST-IMPLEMENTATION AVEC LES ROs
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets RO_UUT/Inverters[*]]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets RO_UUT/Nand_out]

# De même pour les simulations uniques des ROs
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets Inverters[*]]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets Nand_out]

#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets ro_out_IBUF]

# Clock signal
#set_property PACKAGE_PIN W5 [get_ports clk_ro_internal]							
	#set_property IOSTANDARD LVCMOS33 [get_ports clk_ro_internal]
	#create_clock -add -name sys_clk_pin -period 33.3 -waveform {0 16.65} [get_ports clk_ro_internal]

## Sch name = BTNC (Center Button)
set_property PACKAGE_PIN U18 [get_ports reset]					
    set_property IOSTANDARD LVCMOS33 [get_ports reset]

## Enable Ring Oscillator (Switch)
set_property PACKAGE_PIN V17 [get_ports enable_ro]					
    set_property IOSTANDARD LVCMOS33 [get_ports enable_ro]

## Final Alarm Output (LED)
set_property PACKAGE_PIN U16 [get_ports Final_Alarm]					
    set_property IOSTANDARD LVCMOS33 [get_ports Final_Alarm]

## Stored Value Output (LEDs)
set_property PACKAGE_PIN V3 [get_ports {q_str[6]}]					
    set_property IOSTANDARD LVCMOS33 [get_ports {q_str[6]}]
set_property PACKAGE_PIN W3 [get_ports {q_str[5]}]					
    set_property IOSTANDARD LVCMOS33 [get_ports {q_str[5]}]
set_property PACKAGE_PIN U3 [get_ports {q_str[4]}]					
    set_property IOSTANDARD LVCMOS33 [get_ports {q_str[4]}]
set_property PACKAGE_PIN P3 [get_ports {q_str[3]}]					
    set_property IOSTANDARD LVCMOS33 [get_ports {q_str[3]}]
set_property PACKAGE_PIN N3 [get_ports {q_str[2]}]					
    set_property IOSTANDARD LVCMOS33 [get_ports {q_str[2]}]
set_property PACKAGE_PIN P1 [get_ports {q_str[1]}]					
    set_property IOSTANDARD LVCMOS33 [get_ports {q_str[1]}]
set_property PACKAGE_PIN L1 [get_ports {q_str[0]}]					
    set_property IOSTANDARD LVCMOS33 [get_ports {q_str[0]}]

## Ring Oscillator Output (PMOD Header JB)
## Sch name = JB1
set_property PACKAGE_PIN A14 [get_ports ro_out]					
    set_property IOSTANDARD LVCMOS33 [get_ports ro_out]

##Pmod Header JC
##Sch name = JC1
set_property PACKAGE_PIN K17 [get_ports {edge_count[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {edge_count[2]}]
##Sch name = JC2
set_property PACKAGE_PIN M18 [get_ports {edge_count[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {edge_count[1]}]
##Sch name = JC3
set_property PACKAGE_PIN N17 [get_ports {edge_count[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {edge_count[0]}]
##Sch name = JC4
set_property PACKAGE_PIN P18 [get_ports edges_done]					
	set_property IOSTANDARD LVCMOS33 [get_ports edges_done]