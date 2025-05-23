library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Storing_Detector is
    Port (
        ro_output : in  STD_LOGIC;
        reset     : in  STD_LOGIC;
        q_fe      : in  STD_LOGIC;
        q_cnt     : in  STD_LOGIC_VECTOR(7 downto 0);
        q_str_d   : out STD_LOGIC_VECTOR(7 downto 0)
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