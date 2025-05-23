library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Storing_ATM is
    Port (
        clk_ro    : in  STD_LOGIC;                         -- Clock signal
        q_fe      : in  STD_LOGIC;                         -- Enable signal
        q_cnt     : in  STD_LOGIC_VECTOR(7 downto 0);      -- Input value to store (from counter)
        q_str     : out STD_LOGIC_VECTOR(7 downto 0)       -- Stored value
    );
end Storing_ATM;

architecture Behavioral of Storing_ATM is
signal q_str_reg : STD_LOGIC_VECTOR(7 downto 0) := "00000000";    -- Flip-flop output register
begin
    process(clk_ro)
    begin
        if clk_ro'event and clk_ro = '1' then
            if q_fe = '1' then
                q_str_reg <= q_cnt;
            end if;
        end if;
    end process;
    q_str <= q_str_reg;
end Behavioral;