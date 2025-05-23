library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ATM_TB is
end ATM_TB;

architecture Behavioral of ATM_TB is

    -- Component Declaration for ATM
    component ATM
        Port (
            clk_s        : in  STD_LOGIC;                      -- Main clock signal
            reset        : in  STD_LOGIC;                      -- Global reset signal
            ro_output    : in  STD_LOGIC;                      -- Shared RO output
            Alarm_ATM    : out STD_LOGIC;                      -- Final alarm output
            q_str_atm    : out STD_LOGIC_VECTOR(15 downto 0);  -- Stored value output
            edge_count   : out STD_LOGIC_VECTOR(2 downto 0);   -- Edge count output
            edges_done   : out STD_LOGIC                       -- Signal indicating counting is done
        );
    end component;

    -- Component Declaration for RO_SIRO
    component RO_SIRO
        Port (
            enable_ro_and_siro : in  STD_LOGIC;   -- Combined enable signal for both RO and SIRO
            ro_out            : out STD_LOGIC    -- Outputs from ROs
        );
    end component;

    -- Signals
    signal clk_s              : STD_LOGIC := '0';
    signal reset              : STD_LOGIC := '0';
    signal enable_ro_and_siro : STD_LOGIC := '0';
    signal ro_output             : STD_LOGIC;
    signal Alarm_ATM          : STD_LOGIC;
    signal q_str_atm          : STD_LOGIC_VECTOR(15 downto 0);
    signal edge_count         : STD_LOGIC_VECTOR(2 downto 0);
    signal edges_done         : STD_LOGIC;

    -- Clock period definitions
    constant CLK_S_PERIOD     : TIME := 10 us;
    constant GBF_PERIOD       : TIME := 250 ns;

begin

    -- Instantiate RO_SIRO
    RO_SIRO_INST: RO_SIRO
        port map (
            enable_ro_and_siro => enable_ro_and_siro,
            ro_out             => ro_out
        );

    -- Instantiate ATM
    ATM_INST: ATM
        port map (
            clk_s              => clk_s,
            reset              => reset,
            ro_output          => ro_output,
            Alarm_ATM          => Alarm_ATM,
            q_str_d            => q_str_d,
            q_str_atm          => q_str_atm,
            edge_count         => edge_count,
            edges_done         => edges_done
        );

    -- Clock generation
    clk_s <= not clk_s after CLK_S_PERIOD / 2;
    
    -- Simulated RO signal
    gbf_out <= not gbf_out after GBF_PERIOD / 2;

    -- Test process
    process
    begin
        -- Initial reset
        reset <= '1';
        enable_ro_and_siro <= '0';
        wait for 5 us;
        
        -- Enable the system
        enable_ro_and_siro <= '1';
        wait for 5 us;
        
        -- Release reset
        reset <= '0';
        wait for 5 ms;

        -- Disable the system
        enable_ro_and_siro <= '0';
        wait for 1 ms;

        wait;
    end process;

end Behavioral;