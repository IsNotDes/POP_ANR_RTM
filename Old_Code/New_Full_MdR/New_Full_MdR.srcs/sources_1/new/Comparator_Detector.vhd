library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity Comparator_Detector is
    Port (
        ro_output : in STD_LOGIC;                      -- Clock signal for synchronization
        q_str_d : in STD_LOGIC_VECTOR (6 downto 0);
        Alarme : out STD_LOGIC;
        x_moins_out : out STD_LOGIC_VECTOR (6 downto 0); -- Output for x_moins
        x_plus_out : out STD_LOGIC_VECTOR (6 downto 0)   -- Output for x_plus
    );
end Comparator_Detector;

architecture Behavioral of Comparator_Detector is
    signal Alarme_reg : STD_LOGIC; -- Initialize internal register

    -- Constants for dynamic calculation
    constant f_clk_s : INTEGER := 1430; -- Frequency of clock source in kHz (example: 100 kHz)
    constant f_ro : INTEGER := 30562;   -- Frequency of ring oscillator in kHz (example: 30000 kHz)
    constant percentage : INTEGER := 10; -- Percentage interval around the central value

    -- Calculate the interval boundaries
    constant x_moins : INTEGER := (f_ro / (f_clk_s * 2)) - ((f_ro / (f_clk_s * 2)) * percentage / 100); -- Lower boundary
    constant x_plus : INTEGER := (f_ro / (f_clk_s * 2)) + ((f_ro / (f_clk_s * 2)) * percentage / 100);  -- Upper boundary
begin
    -- Synchronous process for alarm calculation
    process(ro_output)
    begin
        -- Use rising edge of ro_output for synchronous operation
        if ro_output'event and ro_output = '1' then
            -- Convert q_str_d to integer for comparison
            if to_integer(unsigned(q_str_d)) < x_moins or to_integer(unsigned(q_str_d)) > x_plus then
                Alarme_reg <= '1';
            else
                Alarme_reg <= '0';
            end if;
        end if;
    end process;

    -- Assign constants to output ports
    x_moins_out <= std_logic_vector(to_unsigned(x_moins, 7)); -- 7 bits for x_moins
    x_plus_out <= std_logic_vector(to_unsigned(x_plus, 7));   -- 7 bits for x_plus

    -- Output the registered alarm signal
    Alarme <= Alarme_reg;
end Behavioral;