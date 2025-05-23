library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Counter_ATM is
    Port (
        clk_s     : in  STD_LOGIC;                      -- Clock signal (for enable and reset)
        clk_ro    : in  STD_LOGIC;                      -- RO signal (for counting edges)
        q_cnt     : out STD_LOGIC_VECTOR(7 downto 0)    -- Stored value
    );
end Counter_ATM;

architecture Behavioral of Counter_ATM is
    signal counter_reg : UNSIGNED(7 downto 0);         -- Counter register
    signal counting_en : STD_LOGIC := '0';             -- Enable counting flag
begin
    -- Process to detect rising edge of clk_s
    process(clk_s)
    begin
        if clk_s'event and clk_s = '1' then
            -- On rising edge of clk_s, enable counting
            counting_en <= '1';
        end if;
        if clk_s = '0' then
            -- On falling edge of clk_s, disable counting
            counting_en <= '0';
        end if;
    end process;

    -- Process for counting on clk_ro
    process(clk_ro)
    begin
        if clk_ro'event and clk_ro = '1' then
            if counting_en = '1' then
                -- Increment counter only when counting is enabled
                counter_reg <= counter_reg + 1;
            else
                -- Reset counter when counting is disabled
                counter_reg <= (others => '0');
            end if;
        end if;
    end process;

    -- Output the counter value
    q_cnt <= STD_LOGIC_VECTOR(counter_reg);
end Behavioral;