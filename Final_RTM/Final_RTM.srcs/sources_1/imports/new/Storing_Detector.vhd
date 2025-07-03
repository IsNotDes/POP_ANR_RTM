library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Storing_Detector is
    Port (
        ro_output : in  STD_LOGIC;  -- RO output
        reset     : in  STD_LOGIC;  -- Reset signal
        q_fe      : in  STD_LOGIC;  -- Falling edge signal
        q_cnt     : in  STD_LOGIC_VECTOR(7 downto 0);  -- Counter value
        q_str_d   : out STD_LOGIC_VECTOR(7 downto 0)   -- Stored counter value
    );
end Storing_Detector;

architecture Behavioral of Storing_Detector is
    signal stored_value : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');  -- Initialize internal register
begin
    -- Synchronous process for storing the value
    process(ro_output)
    begin
        if ro_output'event and ro_output = '1' then
            if reset = '1' then
                stored_value <= (others => '0');
            elsif q_fe = '1' then
                stored_value <= q_cnt;
            end if;
        end if;
    end process;

    -- Output the registered value
    q_str_d <= stored_value;
end Behavioral;