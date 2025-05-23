set_property SEVERITY {Warning} [get_drc_checks LUTLP-1]
#set_property SEVERITY {Warning} [get_drc_checks LUTLP-2]
set_property SEVERITY {Warning} [get_drc_checks NSTD-1]
set_property SEVERITY {Warning} [get_drc_checks UCIO-1]

set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]

## EXTREMEMENT IMPORTANT POUR AVOIR DES SIMULATIONS CORRECTES EN POST-IMPLEMENTATION AVEC LES ROs
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets RO_UUT/Inverters[*]]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets RO_UUT/Nand_out]

#set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets RO_D_UUT_n_0]
#set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets enable_ro_IBUF]

# SI DRIVE EN TANT QUE CLOCK, AMENERA TRES VITE DES DECALAGES DE FREQUENCE NON DESIREES, FONCTIONNE TRES BIEN SANS DRIVE EN TANT QUE CLOCK
# Clock signal
#set_property PACKAGE_PIN W5 [get_ports ro_out]							
	#set_property IOSTANDARD LVCMOS33 [get_ports ro_out]
	#create_clock -add -name sys_clk_pin -period 6.5 -waveform {0 3.25} [get_ports ro_out]
 
# Switches
set_property PACKAGE_PIN V17 [get_ports enable_ro]					
	set_property IOSTANDARD LVCMOS33 [get_ports enable_ro]

# LEDs
set_property PACKAGE_PIN U16 [get_ports Alarme]					
	set_property IOSTANDARD LVCMOS33 [get_ports Alarme]
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

##Pmod Header JB
##Sch name = JB1
set_property PACKAGE_PIN A14 [get_ports clk_s]					
	set_property IOSTANDARD LVCMOS33 [get_ports clk_s]
##Sch name = JB2
set_property PACKAGE_PIN A16 [get_ports ro_out]					
	set_property IOSTANDARD LVCMOS33 [get_ports ro_out]