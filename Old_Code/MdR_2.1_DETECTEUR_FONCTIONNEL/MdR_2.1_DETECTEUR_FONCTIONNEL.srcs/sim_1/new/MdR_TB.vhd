library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MdR_TB is
end MdR_TB;

architecture Behavioral of MdR_TB is
    -- Inputs
    signal clk_s       : STD_LOGIC := '0';                      -- Main clock signal
    signal reset       : STD_LOGIC := '0';                      -- Global reset signal
    signal enable_ro   : STD_LOGIC := '0';                      -- Enable signal for the shared RO

    -- Outputs
    signal Alarme_Detector     : STD_LOGIC;                     -- Alarm output from Detector
    signal Final_Alarm_AutoTest: STD_LOGIC;                     -- Final alarm output from Auto_Test_Module
    signal q_str_detector      : STD_LOGIC_VECTOR(6 downto 0);  -- Stored value from Detector
    signal q_str_auto_test     : STD_LOGIC_VECTOR(6 downto 0);  -- Stored value from Auto_Test_Module
    signal edge_count          : STD_LOGIC_VECTOR(2 downto 0);  -- Edge count from Auto_Test_Module
    signal edges_done          : STD_LOGIC;                    -- Signal indicating counting is done

    -- Clock period definitions
    constant clk_period    : TIME := 1 us;                     -- 100 MHz clock (adjust as needed)
    signal ro_clk_period : TIME := 33.3 ns;                      -- Faster clock for RO (adjust as needed)

begin
    -- Instantiate the Unit Under Test (UUT)
    UUT: entity work.MdR
        port map (
            clk_s               => clk_s,
            reset               => reset,
            enable_ro           => enable_ro,
            Alarme_Detector     => Alarme_Detector,
            Final_Alarm_AutoTest=> Final_Alarm_AutoTest,
            q_str_detector      => q_str_detector,
            q_str_auto_test     => q_str_auto_test,
            edge_count          => edge_count,
            edges_done          => edges_done
        );

    -- Clock generation process for clk_s
    clk_process: process
    begin
        clk_s <= not clk_s;
        wait for clk_period / 2;
    end process;

    -- Clock generation process for ro_clk
    ro_clk_process: process
    begin
        enable_ro <= not enable_ro; -- Simulate RO clock toggling
        wait for ro_clk_period / 2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        reset <= '1';       -- Apply reset
        wait for 20 ns;
        reset <= '0';       -- Release reset
        wait for 100 ns;
        reset <= '1';       -- Reapply reset
        wait for 20 ns;
        reset <= '0';       -- Release reset again
        wait for 1000 ns;
        ro_clk_period <= 100 ns;
        wait;
    end process;
end Behavioral;