library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RO_SIRO_TB is
end RO_SIRO_TB;

architecture Behavioral of RO_SIRO_TB is
    -- Test signals
    signal enable_ro_and_siro_s : STD_LOGIC := '0';
    signal ro_out_s             : STD_LOGIC;

    -- Component Declaration
    component RO_SIRO
        Port (
            enable_ro_and_siro  : in  STD_LOGIC;   -- Combined enable signal for both RO and SIRO
            ro_out              : out STD_LOGIC    -- Outputs from ROs
        );
    end component;

begin
    -- Instantiate Top_Module
    UUT: RO_SIRO
        port map (
            enable_ro_and_siro  => enable_ro_and_siro_s,
            ro_out              => ro_out_s
        );

    -- Stimulus process
    stim_proc: process
    begin
        -- Initial state: both inputs disabled
        enable_ro_and_siro_s    <= '0';
        wait for 100 ns;

        -- Enable RO
        enable_ro_and_siro_s    <= '1';

        wait;
    end process;

end Behavioral;
