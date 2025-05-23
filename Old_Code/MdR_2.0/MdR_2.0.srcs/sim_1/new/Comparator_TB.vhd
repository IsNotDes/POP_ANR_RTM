library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Comparator_D_TB is
end Comparator_D_TB;

architecture Behavioral of Comparator_D_TB is
    
    component Comparator_D is 
        Port ( 
            ro_out : in STD_LOGIC;                      -- Clock signal for synchronization
            q_str : in STD_LOGIC_VECTOR (7 downto 0);   
            Alarme : out STD_LOGIC           
        );
    end component;
    
    signal ro_out_s : STD_LOGIC := '0';                  -- Clock signal
    signal q_str_s : STD_LOGIC_VECTOR (7 downto 0) := "00000000";
    signal Alarme_s : STD_LOGIC := '0';
    
    constant CLK_PERIOD : time := 10 ns;  -- Clock period
begin

    uut : Comparator_D
        port map (
            ro_out => ro_out_s,
            q_str => q_str_s,
            Alarme => Alarme_s
        );

    -- Clock generation
    ro_out_s <= not ro_out_s after CLK_PERIOD / 2;

    -- Stimulus process
    process
    begin 
        wait for 100 ns;
        q_str_s <= "00001010";  -- q_str_s = 10 (within range, Alarme_s = 0)
        wait for 100 ns;
        q_str_s <= "11111111";  -- q_str_s = 255 (outside range, Alarme_s = 1)
        wait for 100 ns;
        q_str_s <= "00001011";  -- q_str_s = 25 (outside range, Alarme_s = 1)
        wait for 100 ns;
    end process;
end Behavioral;