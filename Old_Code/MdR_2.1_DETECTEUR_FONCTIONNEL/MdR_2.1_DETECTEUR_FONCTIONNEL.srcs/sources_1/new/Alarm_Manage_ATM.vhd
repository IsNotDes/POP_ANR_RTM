library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Alarm_Manage_ATM is
    Port (
        clk_s         : in  STD_LOGIC;                  -- Reference clock
        reset         : in  STD_LOGIC;                  -- Synchronous reset
        edges_done    : in  STD_LOGIC;                  -- Signal indicating counting is done
        True_Alarm    : in  STD_LOGIC;                  -- Alarm signal from comparator
        Final_Alarm   : out STD_LOGIC                   -- Final alarm output
    );
end Alarm_Manage_ATM;

architecture Behavioral of Alarm_Manage_ATM is
    signal alarm_reg : STD_LOGIC;                -- Internal alarm register
    signal Prev_Final_Alarm : STD_LOGIC;
begin
    process(clk_s)
    begin
        if clk_s'event and clk_s = '1' then
            if reset = '1' then
                alarm_reg <= '0';                      -- Reset alarm register
            elsif edges_done = '1' or Prev_Final_Alarm = '1' then
                alarm_reg <= True_Alarm;              -- Update alarm register
            end if;
        end if;
    end process;

    Prev_Final_Alarm <= alarm_reg;
    Final_Alarm <= alarm_reg;                          -- Output the final alarm signal
end Behavioral;