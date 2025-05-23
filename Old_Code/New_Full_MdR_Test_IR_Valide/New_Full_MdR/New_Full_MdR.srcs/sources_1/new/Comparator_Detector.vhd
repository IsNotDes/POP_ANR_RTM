library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity Comparator_Detector is
    Port (
        clk_s        : in  STD_LOGIC;                      -- Clock signal for synchronization
        reset        : in  STD_LOGIC;                      -- Active-high reset
        q_str_d      : in  STD_LOGIC_VECTOR(4 downto 0);
        Alarm_Detector : out STD_LOGIC;
        x_moins_out  : out STD_LOGIC_VECTOR(4 downto 0);  -- Output for x_moins
        x_plus_out   : out STD_LOGIC_VECTOR(4 downto 0)   -- Output for x_plus
    );
end Comparator_Detector;

architecture Behavioral of Comparator_Detector is
    signal alarm_reg    : STD_LOGIC;                -- Initialize internal register
    signal value_valid  : STD_LOGIC := '0';         -- Tracks if q_str_d is valid

    -- Constants for dynamic calculation
    constant f_clk_s    : INTEGER := 300;           -- Frequency of reference clock in kHz
    constant f_ro       : INTEGER := 12000;         -- Frequency of ring oscillator in kHz
    constant percentage : INTEGER := 10;            -- Percentage interval around the central value

    -- Calculate the interval boundaries
    constant x_moins    : INTEGER := (f_ro / (f_clk_s * 2)) - ((f_ro / (f_clk_s * 2)) * percentage / 100); -- Lower boundary
    constant x_plus     : INTEGER := (f_ro / (f_clk_s * 2)) + ((f_ro / (f_clk_s * 2)) * percentage / 100); -- Upper boundary
begin
    -- Synchronous process for alarm calculation
    process(clk_s)
    begin
        if clk_s'event and clk_s = '1' then
            if reset = '1' then
                alarm_reg   <= '0';
                value_valid <= '0';
            else
                -- Set value_valid when q_str_d is first updated (not zero)
                if value_valid = '0' and q_str_d /= "00000" then
                    value_valid <= '1';
                end if;
                -- Once alarm is set, it stays set until reset
                if alarm_reg = '0' and value_valid = '1' then
                    -- Convert q_str_d to integer for comparison
                    if to_integer(unsigned(q_str_d)) < x_moins or to_integer(unsigned(q_str_d)) > x_plus then
                        alarm_reg <= '1';
                    end if;
                end if;
            end if;
        end if;
    end process;

    -- Assign constants to output ports
    x_moins_out <= std_logic_vector(to_unsigned(x_moins, 5)); -- 5 bits for x_moins
    x_plus_out  <= std_logic_vector(to_unsigned(x_plus, 5));  -- 5 bits for x_plus

    -- Output the registered alarm signal
    Alarm_Detector <= alarm_reg;
end Behavioral;