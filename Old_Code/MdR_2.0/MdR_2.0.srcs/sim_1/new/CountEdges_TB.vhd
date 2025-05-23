library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity CountEdges_TB is
end CountEdges_TB;

architecture Behavioral of CountEdges_TB is
    -- Component declaration for CountEdges
    component CountEdges
        Port (
            clk_s         : in  STD_LOGIC;                      -- Clock signal
            q_cnt_input   : in  STD_LOGIC_VECTOR(7 downto 0);   -- Input from Counter_D (q_cnt)
            q_cnt_finale  : out STD_LOGIC_VECTOR(7 downto 0);   -- Accumulated counter value
            edge_count    : out STD_LOGIC_VECTOR(7 downto 0)    -- Number of edges detected on clk_s
        );
    end component;

    -- Signals for simulation
    signal clk_s         : STD_LOGIC := '0';                   -- Clock signal
    signal q_cnt_input   : STD_LOGIC_VECTOR(7 downto 0) := (others => '0'); -- Input counter value
    signal q_cnt_finale  : STD_LOGIC_VECTOR(7 downto 0);       -- Accumulated counter value
    signal edge_count    : STD_LOGIC_VECTOR(7 downto 0);       -- Edge count output

    -- Clock period definition
    constant clk_period : time := 10 ns;                       -- Define clock period
begin
    -- Instantiate the CountEdges entity
    UUT: CountEdges
        port map (
            clk_s         => clk_s,
            q_cnt_input   => q_cnt_input,
            q_cnt_finale  => q_cnt_finale,
            edge_count    => edge_count
        );

    -- Clock generation process
    clk_process: process
    begin
        clk_s <= not clk_s after clk_period / 2;               -- Toggle clock every half period
        wait for clk_period / 2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Initial values
        q_cnt_input <= "00000001";                             -- Set initial counter value
        wait for clk_period * 2;                               -- Wait for 2 clock cycles

        -- Change counter value and observe accumulation
        q_cnt_input <= "00000010";                             -- Update counter value
        wait for clk_period * 2;

        q_cnt_input <= "00000100";                             -- Update counter value again
        wait for clk_period * 2;

        q_cnt_input <= "00001000";                             -- Update counter value again
        wait for clk_period * 2;

        -- Stop simulation
        wait;
    end process;

end Behavioral;