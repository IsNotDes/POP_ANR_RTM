library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Storing_Detector is
    Port (
        ro_output    : in  STD_LOGIC;                      -- Clock signal
        q_fe      : in  STD_LOGIC;                      -- Enable signal (Falling edge detected)
        q_cnt     : in  STD_LOGIC_VECTOR(4 downto 0);   -- Input value to store (from counter)
        q_str_d     : out STD_LOGIC_VECTOR(4 downto 0)    -- Stored value
    );
end Storing_Detector;

architecture Behavioral of Storing_Detector is
    signal q_str_d_reg : STD_LOGIC_VECTOR(4 downto 0); -- Initialize register
begin
    process(ro_output)
    begin
        -- Use rising edge of ro_output for synchronous operation
        if ro_output'event and ro_output = '1' then
            if q_fe = '1' then
                q_str_d_reg <= q_cnt;
            -- else: Hold the previous value (implicit in synchronous process)
            end if;
        end if;
    end process;

    q_str_d <= q_str_d_reg; -- Assign registered value to output
end Behavioral;