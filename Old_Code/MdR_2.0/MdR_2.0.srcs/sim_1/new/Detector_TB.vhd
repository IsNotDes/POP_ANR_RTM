library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Detector_TB is
end Detector_TB;

architecture Behavioral of Detector_TB is
    -- Component declaration for Detector
    component Detector
        Port (
            clk_s     : in  STD_LOGIC;
            Alarme    : out STD_LOGIC;
            q_str     : out STD_LOGIC_VECTOR(7 downto 0);
            enable_ro : in  STD_LOGIC;
            ro_out    : out STD_LOGIC
        );
    end component;

    -- Test signals
    signal clk_s_s     : STD_LOGIC := '0'; -- Main clock/enable signal
    signal Alarme_s    : STD_LOGIC;       -- Alarm output
    signal q_str_s     : STD_LOGIC_VECTOR(7 downto 0); -- Stored value output
    signal enable_ro_s : STD_LOGIC := '0'; -- RO Enable, start disabled
    signal ro_out_s    : STD_LOGIC;       -- RO Output

    -- Clock period for clk_s
    constant CLK_S_PERIOD : time := 1 us; -- Adjust as needed

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: Detector
        port map (
            clk_s      => clk_s_s,
            Alarme     => Alarme_s,
            q_str      => q_str_s,
            enable_ro  => enable_ro_s,
            ro_out     => ro_out_s
        );

    -- Clock generation process for clk_s
    clk_s_process : process
    begin
        clk_s_s <= '0';
        wait for CLK_S_PERIOD / 2;
        clk_s_s <= '1';
        wait for CLK_S_PERIOD / 2;
    end process clk_s_process;

    -- Stimulus process
    stimulus_process: process
    begin
        -- Initialize
        enable_ro_s <= '0'; -- Keep RO disabled initially
        wait for 20 ns;

        -- Enable the RO
        enable_ro_s <= '1';
        wait for 20 * CLK_S_PERIOD; -- Let it run for a while

    end process stimulus_process;

end Behavioral;