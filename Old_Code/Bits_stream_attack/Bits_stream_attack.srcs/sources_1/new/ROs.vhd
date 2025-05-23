library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
library UNISIM;
use UNISIM.VComponents.all;

-----------------------------------------------------------------------------------------------------
entity ROs is
generic(
 RO_size : integer := 102 );
 
Port (
        --En : in STD_LOGIC;
        Enable : in std_logic;
        RO_OUT : out std_logic
);
end ROs;
------------------------------------------------------------------------------------------------------
architecture Behavioral of ROs is
signal Inverters:std_logic_vector(6 downto 0):= (others => '0');
Signal Nand_out:std_logic;
attribute KEEP: string ;
attribute KEEP of Inverters: signal  is  " true " ; 
attribute KEEP of Nand_out: signal  is  " true " ;
-------------------------------------------------------------------------------------------------------
begin


--Nand_out <= Enable nand Inverters(5);--(not Enable)

-------------------------------------------------------------------------------------------------------
Inverter1 : LUT2
     generic map (
            -- Table de vérité pour une NAND (0x7 = 0111 en binaire)
        INIT => X"7" -- "7" représente 0111, correspondant à une NAND
        )
     port map (
         O => Nand_out,   -- Sortie de la LUT
         I0 => Enable, -- Entrée 0
         I1 => Inverters(5)  -- Entrée 1
        );
        
        

Inverter2 : LUT1
generic map (
 INIT => "01" -- Logic function
)
port map (
 O => Inverters(0), -- 1-bit output: LUT
 I0 => Nand_out -- 1-bit input: LUT
);

Inverter3 : LUT1
    generic map (
    INIT => "01" -- Logic function
            )
    port map (
    O => Inverters(1), -- 1-bit output: LUT
    I0 => Inverters(0) -- 1-bit input: LUT
    );

Inverter4 : LUT1
    generic map (
    INIT => "01" -- Logic function
            )
    port map (
    O => Inverters(2), -- 1-bit output: LUT
    I0 => Inverters(1) -- 1-bit input: LUT
    );


Inverter5 : LUT1
    generic map (
    INIT => "01" -- Logic function
            )
    port map (
    O => Inverters(3), -- 1-bit output: LUT
    I0 => Inverters(2) -- 1-bit input: LUT
    );


Inverter6 : LUT1
    generic map (
    INIT => "01" -- Logic function
            )
    port map (
    O => Inverters(4), -- 1-bit output: LUT
    I0 => Inverters(3) -- 1-bit input: LUT
    );


Inverter7 : LUT1
    generic map (
    INIT => "01" -- Logic function
            )
    port map (
    O => Inverters(5), -- 1-bit output: LUT
    I0 => Inverters(4) -- 1-bit input: LUT
    );



Inverter8 : LUT1
    generic map (
    INIT => "01" -- Logic function
            )
    port map (
    O => Inverters(6), -- 1-bit output: LUT
    I0 => Inverters(5) -- 1-bit input: LUT
    );




--Inverseur: for i in 1 to 6 generate
  
--    Inverter1 : LUT1
--        generic map (
--            INIT => "01" -- Logic function
--            )
--        port map (
--            O => Inverters(i), -- 1-bit output: LUT
--            I0 => Inverters(i-1) -- 1-bit input: LUT
--            );

--------------------------------------------------
--end generate Inverseur;
-------------------------------------------------------
RO_OUT <= Inverters(6) ;

end Behavioral;