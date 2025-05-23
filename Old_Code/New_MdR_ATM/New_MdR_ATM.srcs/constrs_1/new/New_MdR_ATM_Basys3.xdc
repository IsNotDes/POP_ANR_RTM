#set_property SEVERITY {Warning} [get_drc_checks LUTLP-1]
#set_property SEVERITY {Warning} [get_drc_checks LUTLP-2]
#set_property SEVERITY {Warning} [get_drc_checks NSTD-1]
#set_property SEVERITY {Warning} [get_drc_checks UCIO-1]

set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]

## EXTREMEMENT IMPORTANT POUR AVOIR DES SIMULATIONS CORRECTES EN POST-IMPLEMENTATION AVEC LES ROs
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets RO_SIRO_inst/UUT_RO/Inverters[*]]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets RO_SIRO_inst/UUT_RO/Nand_out]

# Allow combinatorial loops for the oscillator
#set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets RO_SIRO/GENERATE_RO[*].UUT_RO/Inverters[*]]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets RO_SIRO_inst/GENERATE_SIRO[*].UUT_SIRO/Invertersattack]

set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets clk_s_IBUF]

create_clock -name ro_out -period 33.3 -waveform {0 16.65} [get_nets ro_out]

## Sch name = BTNC (Center Button)
set_property PACKAGE_PIN U18 [get_ports reset]					
    set_property IOSTANDARD LVCMOS33 [get_ports reset]

## Enable Ring Oscillator (Switch)
set_property PACKAGE_PIN V17 [get_ports enable_ro]
    set_property IOSTANDARD LVCMOS33 [get_ports enable_ro]
set_property PACKAGE_PIN V16 [get_ports enable_siro]
	set_property IOSTANDARD LVCMOS33 [get_ports enable_siro]

## Final Alarm Output (LED)
set_property PACKAGE_PIN U16 [get_ports Final_Alarm]					
    set_property IOSTANDARD LVCMOS33 [get_ports Final_Alarm]

## Stored Value Output (LEDs)
set_property PACKAGE_PIN V3 [get_ports {q_cnt[6]}]					
    set_property IOSTANDARD LVCMOS33 [get_ports {q_cnt[6]}]
set_property PACKAGE_PIN W3 [get_ports {q_cnt[5]}]					
    set_property IOSTANDARD LVCMOS33 [get_ports {q_cnt[5]}]
set_property PACKAGE_PIN U3 [get_ports {q_cnt[4]}]					
    set_property IOSTANDARD LVCMOS33 [get_ports {q_cnt[4]}]
set_property PACKAGE_PIN P3 [get_ports {q_cnt[3]}]					
    set_property IOSTANDARD LVCMOS33 [get_ports {q_cnt[3]}]
set_property PACKAGE_PIN N3 [get_ports {q_cnt[2]}]					
    set_property IOSTANDARD LVCMOS33 [get_ports {q_cnt[2]}]
set_property PACKAGE_PIN P1 [get_ports {q_cnt[1]}]					
    set_property IOSTANDARD LVCMOS33 [get_ports {q_cnt[1]}]
set_property PACKAGE_PIN L1 [get_ports {q_cnt[0]}]					
    set_property IOSTANDARD LVCMOS33 [get_ports {q_cnt[0]}]

##Pmod Header JA
##Sch name = JA1
set_property PACKAGE_PIN J1 [get_ports {y_moins_out[6]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {y_moins_out[6]}]
##Sch name = JA2
set_property PACKAGE_PIN L2 [get_ports {y_moins_out[5]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {y_moins_out[5]}]
##Sch name = JA3
set_property PACKAGE_PIN J2 [get_ports {y_moins_out[4]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {y_moins_out[4]}]
##Sch name = JA4
set_property PACKAGE_PIN G2 [get_ports {y_moins_out[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {y_moins_out[3]}]
##Sch name = JA7
set_property PACKAGE_PIN H1 [get_ports {y_moins_out[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {y_moins_out[2]}]
##Sch name = JA8
set_property PACKAGE_PIN K2 [get_ports {y_moins_out[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {y_moins_out[1]}]
##Sch name = JA9
set_property PACKAGE_PIN H2 [get_ports {y_moins_out[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {y_moins_out[0]}]
##Sch name = JA10
#set_property PACKAGE_PIN G3 [get_ports {JA[7]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {JA[7]}]

##Pmod Header JB
##Sch name = JB1
set_property PACKAGE_PIN A14 [get_ports clk_s]					
	set_property IOSTANDARD LVCMOS33 [get_ports clk_s]
##Sch name = JB2
set_property PACKAGE_PIN A16 [get_ports ro_out]					
	set_property IOSTANDARD LVCMOS33 [get_ports ro_out]
##Sch name = JB3
set_property PACKAGE_PIN B15 [get_ports {edge_count[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {edge_count[2]}]
##Sch name = JB4
set_property PACKAGE_PIN B16 [get_ports {edge_count[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {edge_count[1]}]
##Sch name = JB7
set_property PACKAGE_PIN A15 [get_ports {edge_count[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {edge_count[0]}]
##Sch name = JB8
set_property PACKAGE_PIN A17 [get_ports edges_done]					
	set_property IOSTANDARD LVCMOS33 [get_ports edges_done]
##Sch name = JB9
#set_property PACKAGE_PIN C15 [get_ports {JB[6]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {JB[6]}]
##Sch name = JB10 
#set_property PACKAGE_PIN C16 [get_ports {JB[7]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {JB[7]}]
	
##Pmod Header JC
##Sch name = JC1
set_property PACKAGE_PIN K17 [get_ports {y_plus_out[6]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {y_plus_out[6]}]
##Sch name = JC2
set_property PACKAGE_PIN M18 [get_ports {y_plus_out[5]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {y_plus_out[5]}]
##Sch name = JC3
set_property PACKAGE_PIN N17 [get_ports {y_plus_out[4]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {y_plus_out[4]}]
##Sch name = JC4
set_property PACKAGE_PIN P18 [get_ports {y_plus_out[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {y_plus_out[3]}]
##Sch name = JC7
set_property PACKAGE_PIN L17 [get_ports {y_plus_out[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {y_plus_out[2]}]
##Sch name = JC8
set_property PACKAGE_PIN M19 [get_ports {y_plus_out[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {y_plus_out[1]}]
##Sch name = JC9
set_property PACKAGE_PIN P17 [get_ports {y_plus_out[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {y_plus_out[0]}]
##Sch name = JC10
#set_property PACKAGE_PIN R18 [get_ports {JC[7]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {JC[7]}]