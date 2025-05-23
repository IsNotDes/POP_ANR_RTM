library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RO_TB is
end RO_TB;

architecture Behavioral of RO_TB is
    -- Test signals
    signal enable_ro : STD_LOGIC := '0';
    signal ro_out : STD_LOGIC := '0';

    -- Corrected Component Declaration
    component RO_ATM is
        Port (
            enable_ro  : in  STD_LOGIC;
            ro_out  : out STD_LOGIC
        );
    end component;

begin
    -- Component Instantiation
    inst_RO: RO_ATM
        port map (
            enable_ro => enable_ro,
            ro_out => ro_out
        );
end Behavioral;
