library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Comparator_ATM_TB is
end Comparator_ATM_TB;

architecture Behavioral of Comparator_ATM_TB is
    
    -- Component declaration for Comparator_ATM
    component Comparator_ATM is 
        Port ( 
            clk_ro     : in  STD_LOGIC;                      -- Clock signal for synchronization
            q_str      : in  STD_LOGIC_VECTOR(7 downto 0);   -- Input value to compare
            edge_count : in  STD_LOGIC_VECTOR(7 downto 0);   -- Number of edges detected
            Alarme     : out STD_LOGIC;                     -- Alarm output
            X_plus     : in  STD_LOGIC_VECTOR(7 downto 0);   -- Upper threshold
            X_moins    : in  STD_LOGIC_VECTOR(7 downto 0);   -- Lower threshold
            N          : in  STD_LOGIC_VECTOR(7 downto 0)    -- Threshold for edge_count
        );
    end component;
    
    -- Signals for simulation
    signal clk_ro_s    : STD_LOGIC := '0';                  -- Clock signal
    signal q_str_s     : STD_LOGIC_VECTOR(7 downto 0) := "00000000"; -- Input value to compare
    signal edge_count_s: STD_LOGIC_VECTOR(7 downto 0) := "00000000"; -- Number of edges detected
    signal Alarme_s    : STD_LOGIC;                                -- Alarm output
    signal X_plus_s    : STD_LOGIC_VECTOR(7 downto 0) := "00010110"; -- X_plus = 22
    signal X_moins_s   : STD_LOGIC_VECTOR(7 downto 0) := "00010010"; -- X_moins = 18
    signal N_s         : STD_LOGIC_VECTOR(7 downto 0) := "00000100"; -- N = 4

    -- Clock period definition
    constant CLK_PERIOD : time := 10 ns;  -- Clock period
begin

    -- Instantiate the Comparator_ATM entity
    uut : Comparator_ATM
        port map (
            clk_ro     => clk_ro_s,
            q_str      => q_str_s,
            edge_count => edge_count_s,
            Alarme     => Alarme_s,
            X_plus     => X_plus_s,
            X_moins    => X_moins_s,
            N          => N_s
        );

    -- Clock generation process
    clk_process: process
    begin
        clk_ro_s <= not clk_ro_s after CLK_PERIOD / 2;
        wait for CLK_PERIOD / 2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin 
        -- Initial values
        q_str_s <= "00010011";       -- q_str_s = 19 (within range)
        edge_count_s <= "00000011";  -- edge_count_s = 3 (not equal to N)
        wait for CLK_PERIOD * 5;

        -- Change edge_count to N (4)
        edge_count_s <= "00000100";  -- edge_count_s = 4 (equal to N)
        wait for CLK_PERIOD * 5;

        -- Change q_str to a value outside the range
        q_str_s <= "00011001";       -- q_str_s = 25 (outside range)
        wait for CLK_PERIOD * 5;

        -- Change edge_count back to a value not equal to N
        edge_count_s <= "00000011";  -- edge_count_s = 3 (not equal to N)
        wait for CLK_PERIOD * 5;

        -- Stop simulation
        wait;
    end process;

end Behavioral;