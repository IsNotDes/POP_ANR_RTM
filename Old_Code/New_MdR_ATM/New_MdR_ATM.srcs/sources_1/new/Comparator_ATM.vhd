library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity Comparator_ATM is
    Port (
        ro_output     : in  STD_LOGIC;                      -- Clock signal for synchronization
        q_cnt      : in  STD_LOGIC_VECTOR(6 downto 0);   -- Input count value
        edges_done : in  STD_LOGIC;   -- End of counting edges signal
        alarm     : out STD_LOGIC;                      -- Alarm signal
        y_moins_out : out STD_LOGIC_VECTOR(6 downto 0);  -- Output for y_moins
        y_plus_out  : out STD_LOGIC_VECTOR(6 downto 0)   -- Output for y_plus
    );
end Comparator_ATM;

architecture Behavioral of Comparator_ATM is
    signal alarm_reg : STD_LOGIC;                -- Internal alarm register
    -- Constants for dynamic calculation
    constant f_clk_s  : INTEGER := 1430;                  -- Frequency of reference clock in kHz
    constant f_ro     : INTEGER := 29335;                -- Frequency of ring oscillator in kHz
    constant percentage : INTEGER := 5;                 -- Percentage interval around the central value
    constant N        : INTEGER := 5;                    -- Number of edges to wait
    -- Calculate the interval boundaries
    constant y_moins  : INTEGER := (f_ro / f_clk_s * N) - ((f_ro / f_clk_s * N) * percentage / 100); -- Lower boundary
    constant y_plus   : INTEGER := (f_ro / f_clk_s * N) + ((f_ro / f_clk_s * N) * percentage / 100); -- Upper boundary
begin
    process(ro_output)
    begin
        if ro_output'event and ro_output = '1' then
            -- Check if the number of edges equals N
            if edges_done = '1' then
                -- Convert q_cnt to integer for comparison
                if to_integer(unsigned(q_cnt)) < y_moins or to_integer(unsigned(q_cnt)) > y_plus then
                    alarm_reg <= '1';                   -- Raise alarm
                else
                    alarm_reg <= '0';                   -- Clear alarm
                end if;
            end if;
        end if;
    end process;

    -- Assign constants to output ports
    y_moins_out <= std_logic_vector(to_unsigned(y_moins, 7));  -- 7 bits for y_moins
    y_plus_out  <= std_logic_vector(to_unsigned(y_plus, 7));   -- 7 bits for y_plus

    alarm <= alarm_reg;                                -- Output the registered alarm signal
end Behavioral;