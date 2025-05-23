library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MdR_TB is
end MdR_TB;

architecture Behavioral of MdR_TB is

    -- Component Declaration for MdR
    component MdR
        Port (
            clk_s           : in  STD_LOGIC;                            -- Main clock signal
            reset           : in  STD_LOGIC;                            -- Global reset signal
            enable_ro       : in  STD_LOGIC;                            -- Enable signal for the shared RO
            enable_siro     : in  STD_LOGIC;                            -- Enable signal for the SIRO (not used in this design)
            gbf_out         : in  STD_LOGIC;                            -- External input from PMOD pin
            ro_out          : out STD_LOGIC;                            -- Output from the shared RO
            Alarm_Detector  : out STD_LOGIC;                            -- Alarm output from Detector
            Alarm_ATM       : out STD_LOGIC;                            -- Final alarm output from Auto_Test_Module
            q_str_d         : out STD_LOGIC_VECTOR(4 downto 0);         -- Stored value from Detector (modified to 6 downto 0)
            q_str_atm       : out STD_LOGIC_VECTOR(7 downto 0);         -- Stored value from Auto_Test_Module (modified to 6 downto 0)
            edge_count      : out STD_LOGIC_VECTOR(2 downto 0);         -- Edge count from Auto_Test_Module
            edges_done      : out STD_LOGIC;                            -- Signal indicating counting is done
            y_moins_out     : out STD_LOGIC_VECTOR(7 downto 0);         -- Output for y_moins
            y_plus_out      : out STD_LOGIC_VECTOR(7 downto 0);         -- Output for y_plus
            x_moins_out     : out STD_LOGIC_VECTOR(4 downto 0);         -- Output for x_moins
            x_plus_out      : out STD_LOGIC_VECTOR(4 downto 0)          -- Output for x_plus
        );
    end component;

    -- Inputs
    signal clk_s       : STD_LOGIC := '0';                      -- Main clock signal
    signal reset       : STD_LOGIC := '0';                      -- Global reset signal
    signal enable_ro   : STD_LOGIC := '0';                      -- Enable signal for the shared RO
    signal enable_siro : STD_LOGIC := '1';                      -- Enable signal for the shared SIRO
    signal gbf_out     : STD_LOGIC := '0';                      -- External input from PMOD pin

    -- Outputs
    signal ro_out           : STD_LOGIC;                        -- Output from the shared RO
    signal Alarm_Detector   : STD_LOGIC;                        -- Alarm output from Detector
    signal Alarm_ATM        : STD_LOGIC;                        -- Final alarm output from Auto_Test_Module
    signal q_str_d          : STD_LOGIC_VECTOR(4 downto 0);     -- Stored value from Detector
    signal q_str_atm        : STD_LOGIC_VECTOR(7 downto 0);     -- Stored value from Auto_Test_Module
    signal edge_count       : STD_LOGIC_VECTOR(2 downto 0);     -- Edge count from Auto_Test_Module
    signal edges_done       : STD_LOGIC;                        -- Signal indicating counting is done
    signal y_moins_tb       : STD_LOGIC_VECTOR(7 downto 0);
    signal y_plus_tb        : STD_LOGIC_VECTOR(7 downto 0);
    signal x_moins_tb       : STD_LOGIC_VECTOR(4 downto 0);
    signal x_plus_tb        : STD_LOGIC_VECTOR(4 downto 0);

    -- Clock period definitions
    signal CLK_S_PERIOD    : TIME := 2 us;                     -- 100 MHz clock (adjust as needed)

begin

    -- Instantiate the Unit Under Test (UUT)
    UUT: MdR
        port map (
            clk_s               => clk_s,
            reset               => reset,
            enable_ro           => enable_ro,
            enable_siro         => enable_siro,
            gbf_out             => gbf_out,
            ro_out              => ro_out,
            Alarm_Detector      => Alarm_Detector,
            Alarm_ATM           => Alarm_ATM,
            q_str_d             => q_str_d,
            q_str_atm           => q_str_atm,
            edge_count          => edge_count,
            edges_done          => edges_done,
            y_moins_out         => y_moins_tb,
            y_plus_out          => y_plus_tb,
            x_moins_out         => x_moins_tb,
            x_plus_out          => x_plus_tb
        );

    clk_s <= not clk_s after CLK_S_PERIOD / 2;

    process
    begin
        -- Initial reset state
        reset <= '1';       -- Apply reset
        enable_ro <= '0';   -- Disable RO
        wait for 5 us;      -- Hold reset long enough for all signals to stabilize
        
        -- Enable the oscillators before releasing reset
        enable_ro <= '1';   -- Enable RO
        wait for 5 us;      -- Wait for oscillators to stabilize
        
        -- Release reset and wait for counting to initialize
        reset <= '0';       -- Release reset
        wait for 10 us;     -- Wait for counting mechanism to initialize
        
        -- Now we can start normal operation
        wait for 200 us;    -- Normal operation time
        
        -- Test different clock period
        CLK_S_PERIOD <= 0.5 us;
        wait for 50 us;
        
        -- Test reset functionality
        reset <= '1';
        wait for 50 ns;
        reset <= '0';
    end process;
end Behavioral;