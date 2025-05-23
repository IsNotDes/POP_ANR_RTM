library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ROattacks_TB is
end ROattacks_TB;

architecture Behavioral of ROattacks_TB is
    -- Component declaration
    component ROattacks
        Port(
            EnableROattack : in std_logic
        );
    end component;

    -- Signals for stimulus
    signal EnableROattack_s : std_logic := '0';

begin
    -- Instantiate the unit under test (UUT)
    inst_SIRO: ROattacks
        port map (
            EnableROattack => EnableROattack_s
        );

    -- Stimulus process
    stim_proc: process
    begin
        -- Test 1: Disabled state
        EnableROattack_s <= '0';
        wait for 100 ns;

        -- Test 2: Enabled state (will create oscillations in hardware)
        EnableROattack_s <= '1';
        wait for 100 ns;  -- Note: Simulation may not show oscillations!

        -- Test 3: Return to disabled state
        EnableROattack_s <= '0';
        wait for 100 ns;

        wait;
    end process;
end Behavioral;