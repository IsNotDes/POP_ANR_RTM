library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Counter_ATM_TB is
end Counter_ATM_TB;

architecture Behavioral of Counter_ATM_TB is
    component Counter_ATM
        Port (
            clk_s           : in  STD_LOGIC;                     
            clk_ro          : in  STD_LOGIC;                      
            q_cnt    : out STD_LOGIC_VECTOR(7 downto 0) -- Updated to 16 bits
        );
    end component;

    signal clk_s_s         : STD_LOGIC := '0';                             
    signal clk_ro_s        : STD_LOGIC := '0';                             
    signal q_cnt_s  : STD_LOGIC_VECTOR(7 downto 0); -- Updated to 16 bits

    constant CLK_S_PERIOD  : time := 80 ns;  
    constant CLK_RO_PERIOD : time := 20 ns;

begin
    uut: Counter_ATM
        port map (
            clk_s           => clk_s_s,
            clk_ro          => clk_ro_s,
            q_cnt           => q_cnt_s
        );

    -- Generate clock signals
    clk_s_s <= not clk_s_s after CLK_S_PERIOD / 2;
    clk_ro_s <= not clk_ro_s after CLK_RO_PERIOD / 2;

end Behavioral;