library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Falling_Edge_Detector_ATM_TB is
end Falling_Edge_Detector_ATM_TB;

architecture Behavioral of Falling_Edge_Detector_ATM_TB is
    -- Component declaration
    component Falling_Edge_Detector_ATM
        Port (
            clk : in  STD_LOGIC;
            d   : in  STD_LOGIC;
            q   : out STD_LOGIC
        );
    end component;

    -- Test signals
    signal clk_s : STD_LOGIC := '0';
    signal d_s  : STD_LOGIC := '0';
    signal q_s   : STD_LOGIC;
    
begin
    -- Instantiate the Unit Under Test (UUT)
    uut: Falling_Edge_Detector_ATM
        port map (
            clk => clk_s,
            d   => d_s,
            q   => q_s
        );

-- Clock generation (10ns period)
    clk_s <= not clk_s after 5 ns;

    -- Stimulus process
    process
    begin
        d_s <= not d_s;  -- Toggle input
        wait for 10 ns;  -- Full clock period
    end process;
end architecture;