library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Storing_Detector is
    Port (
        ro_output : in  STD_LOGIC;                      -- Clock signal
        reset     : in  STD_LOGIC;                      -- Active-low reset
        q_fe      : in  STD_LOGIC;                      -- Enable signal (Falling edge detected)
        q_cnt     : in  STD_LOGIC_VECTOR(4 downto 0);   -- Input value to store (from counter)
        q_str_d   : out STD_LOGIC_VECTOR(4 downto 0)    -- Stored value
    );
end Storing_Detector;

architecture Behavioral of Storing_Detector is
begin
    process(ro_output)
    begin
        if ro_output'event and ro_output = '1' then
            if reset = '1' then
                q_str_d <= (others => '0');
            elsif q_fe = '1' then
                q_str_d <= q_cnt;
            end if;
        end if;
    end process;
end Behavioral;