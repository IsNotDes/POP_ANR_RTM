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

## Alarms Outputs (LED)
set_property PACKAGE_PIN U16 [get_ports Final_Alarm]					
    set_property IOSTANDARD LVCMOS33 [get_ports Final_Alarm]
set_property PACKAGE_PIN E19 [get_ports Alarme]					
	set_property IOSTANDARD LVCMOS33 [get_ports Alarme]

## Stored Value Output (LEDs)
set_property PACKAGE_PIN U19 [get_ports {q_str_d[4]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {q_str_d[4]}]
set_property PACKAGE_PIN V19 [get_ports {q_str_d[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {q_str_d[3]}]
set_property PACKAGE_PIN W18 [get_ports {q_str_d[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {q_str_d[2]}]
set_property PACKAGE_PIN U15 [get_ports {q_str_d[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {q_str_d[1]}]
set_property PACKAGE_PIN U14 [get_ports {q_str_d[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {q_str_d[0]}]

#set_property PACKAGE_PIN V14 [get_ports {q_str_d[1]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {q_str_d[1]}]
	
set_property PACKAGE_PIN V13 [get_ports {q_str_atm[7]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {q_str_atm[7]}]
set_property PACKAGE_PIN V3 [get_ports {q_str_atm[6]}]					
    set_property IOSTANDARD LVCMOS33 [get_ports {q_str_atm[6]}]
set_property PACKAGE_PIN W3 [get_ports {q_str_atm[5]}]					
    set_property IOSTANDARD LVCMOS33 [get_ports {q_str_atm[5]}]
set_property PACKAGE_PIN U3 [get_ports {q_str_atm[4]}]					
    set_property IOSTANDARD LVCMOS33 [get_ports {q_str_atm[4]}]
set_property PACKAGE_PIN P3 [get_ports {q_str_atm[3]}]					
    set_property IOSTANDARD LVCMOS33 [get_ports {q_str_atm[3]}]
set_property PACKAGE_PIN N3 [get_ports {q_str_atm[2]}]					
    set_property IOSTANDARD LVCMOS33 [get_ports {q_str_atm[2]}]
set_property PACKAGE_PIN P1 [get_ports {q_str_atm[1]}]					
    set_property IOSTANDARD LVCMOS33 [get_ports {q_str_atm[1]}]
set_property PACKAGE_PIN L1 [get_ports {q_str_atm[0]}]					
    set_property IOSTANDARD LVCMOS33 [get_ports {q_str_atm[0]}]

##Pmod Header JA
##Sch name = JA1
set_property PACKAGE_PIN J1 [get_ports {y_moins_out[7]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {y_moins_out[7]}]
##Sch name = JA2
set_property PACKAGE_PIN L2 [get_ports {y_moins_out[6]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {y_moins_out[6]}]
##Sch name = JA3
set_property PACKAGE_PIN J2 [get_ports {y_moins_out[5]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {y_moins_out[5]}]
##Sch name = JA4
set_property PACKAGE_PIN G2 [get_ports {y_moins_out[4]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {y_moins_out[4]}]
##Sch name = JA7
set_property PACKAGE_PIN H1 [get_ports {y_moins_out[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {y_moins_out[3]}]
##Sch name = JA8
set_property PACKAGE_PIN K2 [get_ports {y_moins_out[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {y_moins_out[2]}]
##Sch name = JA9
set_property PACKAGE_PIN H2 [get_ports {y_moins_out[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {y_moins_out[1]}]
##Sch name = JA10
set_property PACKAGE_PIN G3 [get_ports {y_moins_out[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {y_moins_out[0]}]

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
set_property PACKAGE_PIN K17 [get_ports {y_plus_out[7]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {y_plus_out[7]}]
##Sch name = JC2
set_property PACKAGE_PIN M18 [get_ports {y_plus_out[6]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {y_plus_out[6]}]
##Sch name = JC3
set_property PACKAGE_PIN N17 [get_ports {y_plus_out[5]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {y_plus_out[5]}]
##Sch name = JC4
set_property PACKAGE_PIN P18 [get_ports {y_plus_out[4]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {y_plus_out[4]}]
##Sch name = JC7
set_property PACKAGE_PIN L17 [get_ports {y_plus_out[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {y_plus_out[3]}]
##Sch name = JC8
set_property PACKAGE_PIN M19 [get_ports {y_plus_out[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {y_plus_out[2]}]
##Sch name = JC9
set_property PACKAGE_PIN P17 [get_ports {y_plus_out[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {y_plus_out[1]}]
##Sch name = JC10
set_property PACKAGE_PIN R18 [get_ports {y_plus_out[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {y_plus_out[0]}]
	
#Pmod Header JXADC
#Sch name = XA1_P
set_property PACKAGE_PIN J3 [get_ports {x_moins_out[4]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {x_moins_out[4]}]
#Sch name = XA2_P
set_property PACKAGE_PIN L3 [get_ports {x_moins_out[3]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {x_moins_out[3]}]
#Sch name = XA3_P
set_property PACKAGE_PIN M2 [get_ports {x_moins_out[2]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {x_moins_out[2]}]
#Sch name = XA4_P
set_property PACKAGE_PIN N2 [get_ports {x_moins_out[1]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {x_moins_out[1]}]
#Sch name = XA1_N
set_property PACKAGE_PIN K3 [get_ports {x_moins_out[0]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {x_moins_out[0]}]
#Sch name = XA2_N
#set_property PACKAGE_PIN M3 [get_ports {x_moins_out[1]}]				
	#set_property IOSTANDARD LVCMOS33 [get_ports {x_moins_out[1]}]
#Sch name = XA3_N
#set_property PACKAGE_PIN M1 [get_ports {x_moins_out[0]}]				
	#set_property IOSTANDARD LVCMOS33 [get_ports {x_moins_out[0]}]
#Sch name = XA4_N
#set_property PACKAGE_PIN N1 [get_ports {vauxn15}]				
	#set_property IOSTANDARD LVCMOS33 [get_ports {vauxn15}]

##VGA Connector
set_property PACKAGE_PIN G19 [get_ports {x_plus_out[4]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {x_plus_out[4]}]
set_property PACKAGE_PIN H19 [get_ports {x_plus_out[3]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {x_plus_out[3]}]
set_property PACKAGE_PIN J19 [get_ports {x_plus_out[2]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {x_plus_out[2]}]
set_property PACKAGE_PIN N19 [get_ports {x_plus_out[1]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {x_plus_out[1]}]
set_property PACKAGE_PIN N18 [get_ports {x_plus_out[0]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {x_plus_out[0]}]
#set_property PACKAGE_PIN L18 [get_ports {x_plus_out[1]}]				
	#set_property IOSTANDARD LVCMOS33 [get_ports {x_plus_out[1]}]
#set_property PACKAGE_PIN K18 [get_ports {x_plus_out[0]}]				
	#set_property IOSTANDARD LVCMOS33 [get_ports {x_plus_out[0]}]
#set_property PACKAGE_PIN J18 [get_ports {vgaBlue[3]}]				
	#set_property IOSTANDARD LVCMOS33 [get_ports {vgaBlue[3]}]
#set_property PACKAGE_PIN J17 [get_ports {vgaGreen[0]}]				
	#set_property IOSTANDARD LVCMOS33 [get_ports {vgaGreen[0]}]
#set_property PACKAGE_PIN H17 [get_ports {vgaGreen[1]}]				
	#set_property IOSTANDARD LVCMOS33 [get_ports {vgaGreen[1]}]
#set_property PACKAGE_PIN G17 [get_ports {vgaGreen[2]}]				
	#set_property IOSTANDARD LVCMOS33 [get_ports {vgaGreen[2]}]
#set_property PACKAGE_PIN D17 [get_ports {vgaGreen[3]}]				
	#set_property IOSTANDARD LVCMOS33 [get_ports {vgaGreen[3]}]
#set_property PACKAGE_PIN P19 [get_ports Hsync]						
	#set_property IOSTANDARD LVCMOS33 [get_ports Hsync]
#set_property PACKAGE_PIN R19 [get_ports Vsync]						
	#set_property IOSTANDARD LVCMOS33 [get_ports Vsync]