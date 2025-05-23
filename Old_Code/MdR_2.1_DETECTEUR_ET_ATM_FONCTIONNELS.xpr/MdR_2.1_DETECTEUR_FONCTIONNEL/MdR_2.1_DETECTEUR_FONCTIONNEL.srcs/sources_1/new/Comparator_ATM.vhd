library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity Comparator_ATM is
    Port (
        ro_out     : in  STD_LOGIC;                      -- Clock signal for synchronization
        q_str      : in  STD_LOGIC_VECTOR(6 downto 0);   -- Input count value
        edge_count : in  STD_LOGIC_VECTOR(2 downto 0);   -- Number of edges detected
        True_Alarm     : out STD_LOGIC                      -- Alarm signal
    );
end Comparator_ATM;

architecture Behavioral of Comparator_ATM is
    signal Alarme_reg : STD_LOGIC := '0';                -- Internal alarm register
    -- Constants for dynamic calculation
    constant f_clk_s  : INTEGER := 1000;                  -- Frequency of reference clock in kHz
    constant f_ro     : INTEGER := 30000;                -- Frequency of ring oscillator in kHz
    constant percentage : INTEGER := 20;                 -- Percentage interval around the central value
    constant N        : INTEGER := 5;                    -- Number of edges to wait
    -- Calculate the central value and interval boundaries
    constant value    : INTEGER := (f_ro / f_clk_s) * N; -- Central value calculation
    constant y_moins  : INTEGER := value - (value * percentage / 100); -- Lower boundary
    constant y_plus   : INTEGER := value + (value * percentage / 100); -- Upper boundary
begin
    process(ro_out)
    begin
        if ro_out'event and ro_out = '1' then
            -- Check if the number of edges equals N
            if to_integer(unsigned(edge_count)) = N then
                -- Convert q_str to integer for comparison
                if to_integer(unsigned(q_str)) < y_moins or to_integer(unsigned(q_str)) > y_plus then
                    Alarme_reg <= '1';                   -- Raise alarm
                else
                    Alarme_reg <= '0';                   -- Clear alarm
                end if;
            end if;
        end if;
    end process;

    True_Alarm <= Alarme_reg;                                -- Output the registered alarm signal
end Behavioral;