library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity Comparator_D is
    Port (
        ro_out : in STD_LOGIC;                      -- Clock signal for synchronization
        q_str : in STD_LOGIC_VECTOR (7 downto 0);
        Alarme : out STD_LOGIC
    );
end Comparator_D;

architecture Behavioral of Comparator_D is
    signal Alarme_reg : STD_LOGIC := '0'; -- Initialize internal register
    constant x_moins : INTEGER := 65; -- 112 (125-10% en théorie pour nbr fronts montants)
    constant x_plus  : INTEGER := 80; -- 138 (125+10% en théorie pour nbr fronts montants)
begin
    -- Synchronous process for alarm calculation
    process(ro_out)
    begin
        -- Use rising edge of ro_out for synchronous operation
        if ro_out'event and ro_out = '1' then
             -- Convert q_str to integer for comparison
            if to_integer(unsigned(q_str)) < x_moins or to_integer(unsigned(q_str)) > x_plus then
                Alarme_reg <= '1';
            else
                Alarme_reg <= '0';
            end if;
        end if;
    end process;

    -- Output the registered alarm signal
    Alarme <= Alarme_reg;
end Behavioral;