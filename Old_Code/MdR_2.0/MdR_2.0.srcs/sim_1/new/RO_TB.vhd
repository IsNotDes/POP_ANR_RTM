library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RO_TB is
end RO_TB;

architecture Behavioral of RO_TB is
    -- Test signals
    signal enable_ro_s : STD_LOGIC := '0';
    signal ro_out_s : STD_LOGIC := '1';

    -- Corrected Component Declaration
    component RO is
        Port (
            enable_ro  : in  STD_LOGIC;
            ro_out  : out STD_LOGIC
        );
    end component;

begin
    -- Component Instantiation
    inst_RO: RO
        port map (
            enable_ro => enable_ro_s,
            ro_out => ro_out_s
        );
end Behavioral;
