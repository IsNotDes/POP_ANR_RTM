library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Counting_Edges_ATM_TB is
end Counting_Edges_ATM_TB;

architecture Behavioral of Counting_Edges_ATM_TB is
    signal clk_s      : STD_LOGIC := '0';
    signal reset      : STD_LOGIC := '0';
    signal edges_done : STD_LOGIC;
    signal edge_count : STD_LOGIC_VECTOR(2 downto 0);   -- Updated to 2 downto 0

    constant clk_period : time := 10 ns; -- 100 MHz clock

    -- Component declaration
    component Counting_Edges_ATM
        Port (
            clk_s       : in  STD_LOGIC;
            reset       : in  STD_LOGIC;
            edges_done  : out STD_LOGIC;
            edge_count  : out STD_LOGIC_VECTOR(2 downto 0)   -- Updated to 2 downto 0
        );
    end component;

begin
    -- Instantiate the Unit Under Test (UUT)
    UUT: Counting_Edges_ATM
        port map (
            clk_s       => clk_s,
            reset       => reset,
            edges_done  => edges_done,
            edge_count  => edge_count
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
        reset <= '1';  -- Apply reset
        wait for 20 ns;

        reset <= '0';  -- Release reset
        wait for 100 ns;

        wait;
    end process;
end Behavioral;