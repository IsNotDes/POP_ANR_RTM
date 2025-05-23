library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Counter_D is
    Port (
        clk_s     : in  STD_LOGIC;                      -- Enable/Reset signal
        ro_out    : in  STD_LOGIC;                      -- Clock signal for counting
        q_cnt     : out STD_LOGIC_VECTOR(6 downto 0)    -- Counter output value
    );
end Counter_D;

architecture Behavioral of Counter_D is
    signal counter_reg : UNSIGNED(6 downto 0) := (others => '0'); -- Counter register, initialized
begin

    -- Process for counting based on ro_out, controlled by clk_s
    process(ro_out) -- Sensitive only to the clock
    begin
        if ro_out'event and ro_out = '1' then
            if clk_s = '0' then -- Reset condition (active low enable/reset assumed based on usage)
                counter_reg <= (others => '0');
            else -- clk_s = '1', enable counting
                counter_reg <= counter_reg + 1;
            end if;
        end if;
    end process;

    -- Output the counter value
    q_cnt <= STD_LOGIC_VECTOR(counter_reg);
end Behavioral;