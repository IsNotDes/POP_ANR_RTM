library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Falling_Edge_Detector is
    Port (
        clk_s     : in  STD_LOGIC;  -- Input signal to monitor (renamed for clarity)
        reset     : in  STD_LOGIC;  -- Active-low reset
        ro_output : in  STD_LOGIC;  -- Clock signal
        q_fe      : out STD_LOGIC   -- Falling edge pulse output
    );
end Falling_Edge_Detector;

architecture Behavioral of Falling_Edge_Detector is
    signal clk_s_dly : STD_LOGIC; -- Register to store previous state of clk_s, initialized
begin
    -- Register the input signal on the clock edge
    process(ro_output)
    begin
        if ro_output'event and ro_output = '1' then
            if reset = '1' then
                clk_s_dly <= '0';
            else
                clk_s_dly <= clk_s;
            end if;
        end if;
    end process;

    q_fe <= clk_s_dly and (not clk_s);
end Behavioral;