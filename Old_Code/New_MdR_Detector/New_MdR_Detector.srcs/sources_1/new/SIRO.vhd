library IEEE; 
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library UNISIM;
use UNISIM.VComponents.ALL;

entity SIRO is
    Port (
        enable_siro : in STD_LOGIC
    );
end SIRO;

architecture Behavioral of SIRO is
    signal Invertersattack : STD_LOGIC;
    attribute KEEP : string;
    attribute DONT_TOUCH : string;
    attribute KEEP of Invertersattack : signal is "true"; 
    attribute DONT_TOUCH of LUT2_inst : label is "TRUE"; -- Critical!

begin
    LUT2_inst : LUT2
    generic map (
        INIT => "01"
    )
    port map (
        O  => Invertersattack,
        I0 => enable_siro,
        I1 => Invertersattack
    );
    
end Behavioral;
