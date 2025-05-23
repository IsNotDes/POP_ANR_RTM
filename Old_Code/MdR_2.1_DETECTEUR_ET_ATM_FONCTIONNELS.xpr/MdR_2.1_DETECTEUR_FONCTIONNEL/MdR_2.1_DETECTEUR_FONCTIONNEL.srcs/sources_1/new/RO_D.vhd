library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
library UNISIM;
use UNISIM.VComponents.all;

entity RO_D is
    Port (
        enable_ro : in std_logic;
        ro_out : out std_logic
    );
end RO_D;

architecture Behavioral of RO_D is
    signal Inverters:std_logic_vector(6 downto 0):= (others => '0');
    Signal Nand_out:std_logic;
    attribute KEEP: string ;
    attribute KEEP of Inverters: signal is " true " ;
    attribute KEEP of Nand_out: signal is " true " ;
    
    begin
        Nand_out <= enable_ro nand Inverters(5);--(not enable_ro)

        Inverter1 : LUT1
            generic map (
                INIT => "01" -- Logic function
            )
            port map (
                O => Inverters(0), -- 1-bit output: LUT
                I0 => Nand_out -- 1-bit input: LUT
            );

        Inverseur: for i in 1 to 6 generate
            Inverter1 : LUT1
                generic map (
                    INIT => "01" -- Logic function
                )
                port map (
                    O => Inverters(i), -- 1-bit output: LUT
                    I0 => Inverters(i-1) -- 1-bit input: LUT
                );
        end generate Inverseur;
        ro_out <= Inverters(6);
end Behavioral;