library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Falling_Edge_Detector_D_TB is
end Falling_Edge_Detector_D_TB;

architecture Behavioral of Falling_Edge_Detector_D_TB is
    -- Component declaration
    component Falling_Edge_Detector_D
        Port (
            clk_s   : in  STD_LOGIC;
            ro_out : in  STD_LOGIC;
            q_fe   : out STD_LOGIC
        );
    end component;

    -- Test signals
    signal clk_s_s  : STD_LOGIC := '0';
    signal ro_out_s : STD_LOGIC := '0';
    signal q_fe_s   : STD_LOGIC;
    
begin
    -- Instantiate the Unit Under Test (UUT)
    uut: Falling_Edge_Detector_D
        port map (
            clk_s   => clk_s_s,
            ro_out  => ro_out_s,
            q_fe    => q_fe_s
        );

    -- Clock generation (10ns period)
    ro_out_s <= not ro_out_s after 5 ns;

    -- Stimulus process
    process
    begin
        clk_s_s <= not clk_s_s;  -- Toggle input
        wait for 10 ns;  -- Full clock period
    end process;
end architecture;