library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Top_Module_TB is
end Top_Module_TB;

architecture Behavioral of Top_Module_TB is
    -- Test signals
    signal Enable_s         : STD_LOGIC := '0';
    signal RO_OUT_s         : STD_LOGIC;
    signal EnableROattack_s : STD_LOGIC := '0';

    -- Component Declaration
    component Top_Module
        Port (
            Enable         : in  STD_LOGIC;
            RO_OUT         : out STD_LOGIC;
            EnableROattack : in  STD_LOGIC
        );
    end component;

begin
    -- Instantiate Top_Module
    UUT: Top_Module
        port map (
            Enable         => Enable_s,
            RO_OUT         => RO_OUT_s,
            EnableROattack => EnableROattack_s
        );

    -- Stimulus process
    stim_proc: process
    begin
        -- Initial state: both inputs disabled
        Enable_s         <= '0';
        EnableROattack_s <= '0';
        wait for 100 ns;

        -- Enable RO
        Enable_s <= '1';
        wait for 500 ns;

        -- Enable ROattacks
        EnableROattack_s <= '1';
        wait for 500 ns;

        -- Disable ROattacks
        EnableROattack_s <= '0';
        wait for 300 ns;

        -- Disable RO
        Enable_s <= '0';
        wait for 200 ns;

        -- End simulation
        wait;
    end process;

end Behavioral;
