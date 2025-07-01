library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library UNISIM;
use UNISIM.VComponents.ALL;

entity SIRO is
    Port (
        enable_ro_and_siro : in  STD_LOGIC  -- Combined enable signal for both RO and SIRO
    );
end SIRO;

architecture Behavioral of SIRO is
    signal Invertersattack : STD_LOGIC;  -- Inverter output
    attribute KEEP        : string;
    attribute DONT_TOUCH  : string;
    attribute KEEP of Invertersattack      : signal is "true";
    attribute DONT_TOUCH of Invertersattack: signal is "TRUE";
    attribute DONT_TOUCH of LUT2_inst      : label  is "TRUE"; -- Critical!

begin
    LUT2_inst : LUT2
        generic map (
            INIT => "01"
        )
        port map (
            O  => Invertersattack,
            I0 => enable_ro_and_siro,
            I1 => Invertersattack
        );
end Behavioral;
