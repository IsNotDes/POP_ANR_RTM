library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Counter_D_TB is
end Counter_D_TB;

architecture Behavioral of Counter_D_TB is
    component Counter_D
        Port (
            clk_s     : in  STD_LOGIC;                     
            ro_out    : in  STD_LOGIC;                      
            q_cnt     : out STD_LOGIC_VECTOR(6 downto 0)    
        );
    end component;

    signal clk_s_s     : STD_LOGIC := '0';                             
    signal ro_out_s    : STD_LOGIC := '0';                             
    signal q_cnt_s     : STD_LOGIC_VECTOR(6 downto 0);                  

    constant CLK_S_PERIOD : time := 1 us;  
    constant CLK_RO_PERIOD : time := 33.3 ns;

begin
    uut: Counter_D
        port map (
            clk_s   => clk_s_s,
            ro_out  => ro_out_s,
            q_cnt   => q_cnt_s
        );

    clk_s_s <= not clk_s_s after CLK_S_PERIOD / 2;
    ro_out_s <= not ro_out_s after CLK_RO_PERIOD / 2;

end Behavioral;