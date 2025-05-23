library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Storing_D is
    Port (
        ro_out    : in  STD_LOGIC;                      -- Clock signal
        q_fe      : in  STD_LOGIC;                      -- Enable signal (Falling edge detected)
        q_cnt     : in  STD_LOGIC_VECTOR(6 downto 0);   -- Input value to store (from counter)
        q_str     : out STD_LOGIC_VECTOR(6 downto 0)    -- Stored value
    );
end Storing_D;

architecture Behavioral of Storing_D is
    signal q_str_reg : STD_LOGIC_VECTOR(6 downto 0) := (others => '0'); -- Initialize register
begin
    process(ro_out)
    begin
        -- Use rising edge of ro_out for synchronous operation
        if ro_out'event and ro_out = '1' then
            if q_fe = '1' then
                q_str_reg <= q_cnt;
            -- else: Hold the previous value (implicit in synchronous process)
            end if;
        end if;
    end process;

    q_str <= q_str_reg; -- Assign registered value to output
end Behavioral;