library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Falling_Edge_Detector_ATM is
    Port (
        clk_ro : in  STD_LOGIC;  -- Clock signal
        clk_s  : in  STD_LOGIC;  -- Input signal to monitor
        q_fe   : out STD_LOGIC      -- Falling edge pulse output
    );
end Falling_Edge_Detector_ATM;

architecture Behavioral of Falling_Edge_Detector_ATM is
    signal q_fe_reg : STD_LOGIC := '0';  -- Flip-flop output register
    begin
        process(clk_ro)
        begin
            if clk_ro'event and clk_ro = '1' then
                q_fe_reg <= clk_s;
            end if;
        end process;
        q_fe <= (not clk_s) and q_fe_reg;
end Behavioral;
