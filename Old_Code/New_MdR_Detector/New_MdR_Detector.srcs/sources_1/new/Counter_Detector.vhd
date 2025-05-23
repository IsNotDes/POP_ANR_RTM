library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Counter_Detector is
    Port (
        clk_s     : in  STD_LOGIC;                      -- Enable/Reset signal
        ro_output    : in  STD_LOGIC;                      -- Clock signal for counting
        q_cnt     : out STD_LOGIC_VECTOR(6 downto 0)    -- Counter output value
    );
end Counter_Detector;

architecture Behavioral of Counter_Detector is
    signal counter_reg : UNSIGNED(6 downto 0); -- Counter register, initialized
begin

    process(ro_output) -- Sensitive only to the clock
    begin
        if ro_output'event and ro_output = '1' then
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