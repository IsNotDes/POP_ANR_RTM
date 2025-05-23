library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Storing_ATM_TB is
end Storing_ATM_TB;

architecture Behavioral of Storing_ATM_TB is
    -- Component declaration (must match the actual entity name and ports)
    component Storing_ATM
        Port (
            clk_ro    : in  STD_LOGIC;                      -- Clock signal
            q_fe      : in  STD_LOGIC;                      -- Enable signal (falling edge detection)
            q_cnt     : in  STD_LOGIC_VECTOR(7 downto 0);   -- Input value to store (from counter)
            q_str     : out STD_LOGIC_VECTOR(7 downto 0)    -- Stored value
        );
    end component;

    -- Test signals
    signal clk_ro_s    : STD_LOGIC := '0';                  -- RO clock
    signal q_fe_s      : STD_LOGIC := '0';                  -- Falling edge enable signal
    signal q_cnt_s     : STD_LOGIC_VECTOR(7 downto 0) := "00000000";  -- Counter value
    signal q_str_s     : STD_LOGIC_VECTOR(7 downto 0);      -- Stored value

    -- Clock periods
    constant CLK_RO_PERIOD : time := 10 ns;  -- clk_ro period
begin
    -- Instantiate the Unit Under Test (UUT)
    uut: Storing_ATM
        port map (
            clk_ro => clk_ro_s,
            q_fe   => q_fe_s,
            q_cnt  => q_cnt_s,
            q_str  => q_str_s
        );

    -- Clock generation
    clk_ro_s <= not clk_ro_s after CLK_RO_PERIOD / 2;

    -- Stimulus process
    process
    begin
        -- Initial state
        q_cnt_s <= "00000000";
        wait for 2*CLK_RO_PERIOD;

        -- Enable storage
        q_fe_s <= '1';
        wait for 2*CLK_RO_PERIOD;

        -- Change input value
        q_cnt_s <= "00101010";      -- 42 in decimal
        wait for 2*CLK_RO_PERIOD;

        -- Disable storage
        q_fe_s <= '0';
        wait for 2*CLK_RO_PERIOD;

    end process;
end Behavioral;