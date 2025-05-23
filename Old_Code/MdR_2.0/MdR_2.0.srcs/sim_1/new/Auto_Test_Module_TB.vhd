library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Auto_Test_Module_TB is
end Auto_Test_Module_TB;

architecture Behavioral of Auto_Test_Module_TB is
    -- Component declaration for Detector
    component Auto_Test_Module
        Port (
            clk_ro      : in  STD_LOGIC;                      -- RO signal (for counting edges)
            clk_s       : in  STD_LOGIC;                      -- Main clock (enable/reset and falling edge detection)
            X_plus      : in  STD_LOGIC_VECTOR(7 downto 0);   -- Upper threshold for comparison
            X_moins     : in  STD_LOGIC_VECTOR(7 downto 0);   -- Lower threshold for comparison
            N           : in  STD_LOGIC_VECTOR(7 downto 0);   -- Threshold for edge_count
            Alarme      : out STD_LOGIC;                     -- Alarm output
            q_str       : out STD_LOGIC_VECTOR(7 downto 0);   -- Stored value output
            edge_count  : out STD_LOGIC_VECTOR(7 downto 0)    -- Number of edges detected on clk_s
        );
    end component;

    -- Test signals
    signal clk_ro_s     : STD_LOGIC := '0';                            -- RO clock
    signal clk_s_s      : STD_LOGIC := '0';                            -- Main clock (enable/reset)
    signal X_plus_s     : STD_LOGIC_VECTOR(7 downto 0) := "00001011";  -- Upper threshold (11)
    signal X_moins_s    : STD_LOGIC_VECTOR(7 downto 0) := "00001001";  -- Lower threshold (9)
    signal N_s          : STD_LOGIC_VECTOR(7 downto 0) := "00000100";  -- Edge count threshold (4)
    signal Alarme_s     : STD_LOGIC;                                   -- Alarm output
    signal q_str_s      : STD_LOGIC_VECTOR(7 downto 0);                -- Stored value output
    signal edge_count_s : STD_LOGIC_VECTOR(7 downto 0);

    -- Clock periods
    signal CLK_RO_PERIOD : time := 5 ns;    -- clk_ro period (fast clock for counting edges)
    constant CLK_S_PERIOD  : time := 110 ns; -- clk_s period (main clock for enable/reset)
begin
    -- Instantiate the Unit Under Test (UUT)
    uut: Auto_Test_Module
        port map (
            clk_ro     => clk_ro_s,
            clk_s      => clk_s_s,
            X_plus     => X_plus_s,
            X_moins    => X_moins_s,
            N          => N_s,
            Alarme     => Alarme_s,
            q_str      => q_str_s,
            edge_count => edge_count_s
        );

    -- Clock generation for clk_ro (fast clock for counting edges)
    clk_ro_s <= not clk_ro_s after CLK_RO_PERIOD / 2;

    -- Clock generation for clk_s (main clock for enable/reset)
    clk_s_s <= not clk_s_s after CLK_S_PERIOD / 2;

    -- Stimulus process
    process
    begin
        wait for 5000 ns;
        
        CLK_RO_PERIOD <= 10 ns;
    end process;
end Behavioral;