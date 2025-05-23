library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity Counter_ATM is
    Port (
        clk_s     : in  STD_LOGIC;                      -- Enable/Reset signal
        ro_out    : in  STD_LOGIC;                      -- Clock signal for counting
        reset     : in  STD_LOGIC;                      -- Synchronous reset
        q_cnt     : out STD_LOGIC_VECTOR(6 downto 0)    -- Counter output value
    );
end Counter_ATM;
architecture Behavioral of Counter_ATM is
    signal counter_reg : UNSIGNED(6 downto 0) := (others => '0'); -- Counter register, initialized
begin
    process(ro_out, clk_s)
    begin
        if ro_out'event and ro_out = '1' then
            if reset = '1' then                          -- Reset condition
                counter_reg <= (others => '0');
            else
                if clk_s = '1' or clk_s = '0' then -- Enable counting
                    counter_reg <= counter_reg + 1;
                end if;
            end if;
        end if;
    end process;
    q_cnt <= STD_LOGIC_VECTOR(counter_reg);
end Behavioral;