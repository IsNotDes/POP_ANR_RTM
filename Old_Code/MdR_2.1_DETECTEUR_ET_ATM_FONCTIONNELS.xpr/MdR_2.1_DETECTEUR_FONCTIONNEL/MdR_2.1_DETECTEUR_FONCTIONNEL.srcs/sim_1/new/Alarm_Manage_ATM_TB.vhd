library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Alarm_Manage_ATM_TB is
end Alarm_Manage_ATM_TB;

architecture Behavioral of Alarm_Manage_ATM_TB is
    signal clk_s       : STD_LOGIC := '0';
    signal reset       : STD_LOGIC := '0';
    signal edges_done  : STD_LOGIC := '0';
    signal True_Alarm  : STD_LOGIC := '0';
    signal Final_Alarm : STD_LOGIC;

    constant clk_period : time := 10 ns; -- 100 MHz clock

    -- Component declaration
    component Alarm_Manage_ATM
        Port (
            clk_s         : in  STD_LOGIC;
            reset         : in  STD_LOGIC;
            edges_done    : in  STD_LOGIC;
            True_Alarm    : in  STD_LOGIC;
            Final_Alarm   : out STD_LOGIC
        );
    end component;

begin
    -- Instantiate the Unit Under Test (UUT)
    UUT: Alarm_Manage_ATM
        port map (
            clk_s         => clk_s,
            reset         => reset,
            edges_done    => edges_done,
            True_Alarm    => True_Alarm,
            Final_Alarm   => Final_Alarm
        );

    -- Clock process
    clk_process: process
    begin
        clk_s <= not clk_s;
        wait for clk_period / 2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        reset <= '1';       -- Apply reset
        edges_done <= '0';
        True_Alarm <= '0';
        wait for 20 ns;

        reset <= '0';       -- Release reset
        edges_done <= '1';  -- Trigger edges_done
        wait for 10 ns;

        True_Alarm <= '1';  -- Trigger True_Alarm
        wait for 10 ns;

        edges_done <= '0';  -- Clear edges_done
        wait for 10 ns;

        reset <= '1';       -- Reapply reset
        wait for 20 ns;

        reset <= '0';       -- Release reset again
        wait for 100 ns;

        wait;
    end process;
end Behavioral;