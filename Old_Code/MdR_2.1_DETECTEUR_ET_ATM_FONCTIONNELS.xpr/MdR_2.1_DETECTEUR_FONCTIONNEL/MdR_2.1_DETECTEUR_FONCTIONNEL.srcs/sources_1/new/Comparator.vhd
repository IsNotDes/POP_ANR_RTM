library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity Comparator_D is
    Port (
        ro_out : in STD_LOGIC;                      -- Clock signal for synchronization
        q_str : in STD_LOGIC_VECTOR (6 downto 0);
        Alarme : out STD_LOGIC
    );
end Comparator_D;

architecture Behavioral of Comparator_D is
    signal Alarme_reg : STD_LOGIC := '0'; -- Initialize internal register

    -- Constants for dynamic calculation
    constant f_clk_s : INTEGER := 1000; -- Frequency of clock source in kHz (example: 100 kHz)
    constant f_ro : INTEGER := 30000;   -- Frequency of ring oscillator in kHz (example: 30000 kHz)
    constant percentage : INTEGER := 10; -- Percentage interval around the central value

    -- Calculate the central value and interval boundaries
    constant value : INTEGER := f_ro / (f_clk_s * 2); -- Central value calculation
    constant x_moins : INTEGER := value - (value * percentage / 100); -- Lower boundary
    constant x_plus : INTEGER := value + (value * percentage / 100);  -- Upper boundary
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