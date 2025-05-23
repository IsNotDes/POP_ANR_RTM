library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
library UNISIM;
use UNISIM.VComponents.all;

-----------------------------------------------------------------------------------------------------
entity ROattacks is
 
Port (
        --En : in STD_LOGIC;
        EnableROattack : in std_logic
       -- RO_OUTattack : out std_logic
);
end ROattacks;
------------------------------------------------------------------------------------------------------
architecture Behavioral of ROattacks is
signal Invertersattack:std_logic:= '0';

--Signal Nand_outattack:std_logic;
attribute KEEP: string ;
attribute KEEP of Invertersattack: signal  is  " true " ; 
  
--attribute KEEP of Nand_outattack: signal  is  " true " ;
-------------------------------------------------------------------------------------------------------
begin


-------------------------------------------------------------------------------------------------------

LUT2_inst : LUT2
generic map (
   INIT => "01"  -- Logic function
)
port map (
   O => Invertersattack,   -- 1-bit output: LUT
   I0 => EnableROattack, -- 1-bit input: LUT
   I1 => Invertersattack  -- 1-bit input: LUT
);



 --RO_OUTattack <= Invertersattack;
-----------------------
end Behavioral;
