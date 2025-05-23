library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Counter_ATM_TB is
end Counter_ATM_TB;

architecture Behavioral of Counter_ATM_TB is

    -- Component declaration
    component Counter_ATM
        Port (
            clk_s     : in  STD_LOGIC;
            ro_out    : in  STD_LOGIC;
            reset     : in  STD_LOGIC;
            q_cnt     : out STD_LOGIC_VECTOR(6 downto 0)   -- Updated to 7 downto 0
        );
    end component;

    signal clk_s_s     : STD_LOGIC := '0';                             
    signal ro_out_s    : STD_LOGIC := '0';                             
    signal q_cnt_s     : STD_LOGIC_VECTOR(6 downto 0);    
    signal reset       : STD_LOGIC := '0';   

    constant CLK_S_PERIOD : time := 1 us; -- 100 MHz clock
    constant CLK_RO_PERIOD : time := 33.3 ns;

begin
    -- Instantiate the Unit Under Test (UUT)
    UUT: Counter_ATM
        port map (
            clk_s   => clk_s_s,
            ro_out  => ro_out_s,
            reset   => reset,
            q_cnt   => q_cnt_s
        );

    clk_s_s <= not clk_s_s after CLK_S_PERIOD / 2;
    ro_out_s <= not ro_out_s after CLK_RO_PERIOD / 2;
    
end Behavioral;