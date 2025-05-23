library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MdR_TB is
end MdR_TB;

architecture Behavioral of MdR_TB is

    -- Component Declaration for MdR
    component MdR
        Port (
            clk_s       : in  STD_LOGIC;                            -- Main clock signal
            reset       : in  STD_LOGIC;                            -- Global reset signal
            enable_ro   : in  STD_LOGIC;                            -- Enable signal for the shared RO
            enable_siro : in  STD_LOGIC;                            -- Enable signal for the SIRO (not used in this design)
            ro_out      : out STD_LOGIC;                            -- Output from the shared RO
            Final_Alarm : out STD_LOGIC;                            -- Final alarm output from Auto_Test_Module
            q_cnt       : out STD_LOGIC_VECTOR(6 downto 0);         -- Stored value from Auto_Test_Module (modified to 6 downto 0)
            edge_count  : out STD_LOGIC_VECTOR(2 downto 0);         -- Edge count from Auto_Test_Module
            edges_done  : out STD_LOGIC;                            -- Signal indicating counting is done
            y_moins_out : out STD_LOGIC_VECTOR(6 downto 0);         -- Output for y_moins
            y_plus_out  : out STD_LOGIC_VECTOR(6 downto 0)          -- Output for y_plus
        );
    end component;

    -- Inputs
    signal clk_s       : STD_LOGIC := '0';                      -- Main clock signal
    signal reset       : STD_LOGIC := '0';                      -- Global reset signal
    signal enable_ro   : STD_LOGIC := '0';                      -- Enable signal for the shared RO
    signal enable_siro : STD_LOGIC := '0';                      -- Enable signal for the shared SIRO

    -- Outputs
    signal ro_out      : STD_LOGIC;                            -- Output from the shared RO
    signal Final_Alarm : STD_LOGIC;                     -- Final alarm output from Auto_Test_Module
    signal q_cnt     : STD_LOGIC_VECTOR(6 downto 0);  -- Stored value from Auto_Test_Module
    signal edge_count          : STD_LOGIC_VECTOR(2 downto 0);  -- Edge count from Auto_Test_Module
    signal edges_done          : STD_LOGIC;                    -- Signal indicating counting is done
    signal y_moins_tb : STD_LOGIC_VECTOR(6 downto 0);
    signal y_plus_tb  : STD_LOGIC_VECTOR(6 downto 0);

    -- Clock period definitions
    constant CLK_S_PERIOD    : TIME := 0.7 us;                     -- 100 MHz clock (adjust as needed)

begin

    -- Instantiate the Unit Under Test (UUT)
    UUT: MdR
        port map (
            clk_s               => clk_s,
            reset               => reset,
            enable_ro           => enable_ro,
            enable_siro         => enable_siro,
            ro_out              => ro_out,
            Final_Alarm         => Final_Alarm,
            q_cnt               => q_cnt,
            edge_count          => edge_count,
            edges_done          => edges_done,
            y_moins_out         => y_moins_tb,
            y_plus_out          => y_plus_tb
        );

    clk_s <= not clk_s after CLK_S_PERIOD / 2;

    process
    begin
        reset <= '1';       -- Apply reset
        enable_ro <= '0';   -- Disable RO
        enable_siro <= '0'; -- Disable SIRO
        wait for 300 ns;
        reset <= '0';       -- Release reset
        wait for 40 ns;
        enable_ro <= '1';   -- Enable RO
        wait for 20 ns;
        enable_siro <= '1'; -- Enable SIRO
        wait;
    end process;
end Behavioral;