library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Counter_ATM is
    Port (
        ro_out    : in  STD_LOGIC;
        reset     : in  STD_LOGIC;
        q_cnt     : out STD_LOGIC_VECTOR(6 downto 0)   -- Counter output
    );
end Counter_ATM;

architecture Behavioral of Counter_ATM is
    signal counter_reg : UNSIGNED(6 downto 0) := (others => '0'); -- Counter register, initialized
begin

    -- Process for counting based on ro_out
    process(ro_out, reset)
    begin
        if ro_out'event and ro_out = '1' then
            if reset = '1' then -- Reset condition
                counter_reg <= (others => '0');
            else
                counter_reg <= counter_reg + 1;
            end if;
        end if;
    end process;

    -- Output the counter value
    q_cnt <= STD_LOGIC_VECTOR(counter_reg);
end Behavioral;
