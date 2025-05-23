library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RO_SIRO_TB is
end RO_SIRO_TB;

architecture Behavioral of RO_SIRO_TB is
    -- Test signals
    signal enable_ro_s         : STD_LOGIC := '0';
    signal ro_out_s         : STD_LOGIC;
    signal enable_siro_s : STD_LOGIC := '0';

    -- Component Declaration
    component RO_SIRO
        Port (
            enable_ro         : in  STD_LOGIC;
            ro_out         : out STD_LOGIC;
            enable_siro : in  STD_LOGIC
        );
    end component;

begin
    -- Instantiate Top_Module
    UUT: RO_SIRO
        port map (
            enable_ro         => enable_ro_s,
            ro_out         => ro_out_s,
            enable_siro => enable_siro_s
        );

    -- Stimulus process
    stim_proc: process
    begin
        -- Initial state: both inputs disabled
        enable_ro_s         <= '0';
        enable_siro_s <= '0';
        wait for 100 ns;

        -- Enable RO
        enable_ro_s <= '1';
        wait for 500 ns;

        -- Enable ROattacks
        enable_siro_s <= '1';

        wait;
    end process;

end Behavioral;
