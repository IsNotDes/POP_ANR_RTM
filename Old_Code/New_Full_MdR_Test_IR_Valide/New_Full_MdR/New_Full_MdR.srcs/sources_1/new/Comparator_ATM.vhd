library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity Comparator_ATM is
    Port (
        clk_s        : in  STD_LOGIC;                      -- Clock signal for synchronization
        reset        : in  STD_LOGIC;                      -- Active-low reset
        q_str_atm    : in  STD_LOGIC_VECTOR(7 downto 0);   -- Input count value
        edges_done   : in  STD_LOGIC;                      -- End of counting edges signal
        alarm        : out STD_LOGIC;                      -- Alarm signal
        y_moins_out  : out STD_LOGIC_VECTOR(7 downto 0);   -- Output for y_moins
        y_plus_out   : out STD_LOGIC_VECTOR(7 downto 0)    -- Output for y_plus
    );
end Comparator_ATM;

architecture Behavioral of Comparator_ATM is
    signal alarm_reg           : STD_LOGIC;                -- Internal alarm register
    signal first_cycle_skipped : STD_LOGIC := '0';         -- Skip first edges_done after reset
    -- Constants for dynamic calculation
    constant f_clk_s    : INTEGER := 300;                  -- Frequency of reference clock in kHz
    constant f_ro       : INTEGER := 12000;                -- Frequency of ring oscillator in kHz
    constant percentage : INTEGER := 5;                    -- Percentage interval around the central value
    constant N          : INTEGER := 5;                    -- Number of edges to wait
    -- Calculate the interval boundaries
    constant y_moins    : INTEGER := (f_ro / f_clk_s * N) - ((f_ro / f_clk_s * N) * percentage / 100); -- Lower boundary
    constant y_plus     : INTEGER := (f_ro / f_clk_s * N) + ((f_ro / f_clk_s * N) * percentage / 100); -- Upper boundary
begin
    process(clk_s)
    begin
        if clk_s'event and clk_s = '1' then
            if reset = '1' then
                alarm_reg           <= '0';
                first_cycle_skipped <= '0';
            else
                -- Skip the first edges_done event after reset
                if edges_done = '1' and first_cycle_skipped = '0' then
                    first_cycle_skipped <= '1';
                -- Normal operation after first edges_done
                elsif edges_done = '1' and alarm_reg = '0' and first_cycle_skipped = '1' then
                    -- Convert q_str_atm to integer for comparison
                    if to_integer(unsigned(q_str_atm)) < y_moins or to_integer(unsigned(q_str_atm)) > y_plus then
                        alarm_reg <= '1';                   -- Raise alarm
                    else
                        alarm_reg <= '0';                   -- Clear alarm
                    end if;
                end if;
            end if;
        end if;
    end process;

    -- Assign constants to output ports
    y_moins_out <= std_logic_vector(to_unsigned(y_moins, 8));  -- 8 bits for y_moins
    y_plus_out  <= std_logic_vector(to_unsigned(y_plus, 8));   -- 8 bits for y_plus

    alarm <= alarm_reg;                                        -- Output the registered alarm signal
end Behavioral;