library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Auto_Test_Module_TB is
end Auto_Test_Module_TB;

architecture Behavioral of Auto_Test_Module_TB is
    -- Inputs
    signal clk_s       : STD_LOGIC := '0';
    signal reset       : STD_LOGIC := '0';
    signal ro_clk      : STD_LOGIC := '0';  -- New clock signal for RO
    -- Outputs
    signal Final_Alarm : STD_LOGIC;         -- Final Alarm output (renamed from Alarme)
    signal q_cnt       : STD_LOGIC_VECTOR(6 downto 0);
    signal q_str       : STD_LOGIC_VECTOR(6 downto 0);
    signal edge_count  : STD_LOGIC_VECTOR(2 downto 0);
    signal edges_done  : STD_LOGIC;
    constant clk_period : time := 1 us;   -- 1 MHz clock for clk_s
    signal ro_clk_period : time := 10 ns; -- 30 MHz clock for ro_clk
begin
    -- Instantiate the Unit Under Test (UUT)
    UUT: entity work.Auto_Test_Module
        port map (
            clk_s       => clk_s,
            reset       => reset,
            enable_ro   => ro_clk,        -- Use ro_clk as the enable signal
            Final_Alarm       => Final_Alarm,   -- Monitoring Final_Alarm instead of Alarme
            q_cnt       => q_cnt,
            q_str       => q_str,
            edge_count  => edge_count,
            edges_done  => edges_done
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
        ro_clk <= not ro_clk;
        wait for ro_clk_period / 2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        reset <= '1';       -- Apply reset
        wait for 20 ns;
        reset <= '0';       -- Release reset
        wait for 60 ns;
        reset <= '1';       -- Reapply reset
        wait for 20 ns;
        reset <= '0';       -- Release reset again
        wait for 10000 ns;
        ro_clk_period <= 500 ns;
        wait;
    end process;
end Behavioral;