library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Alarm_Manage_ATM is
    Port (
        clk_s      : in  STD_LOGIC;     -- Clock signal
        reset      : in  STD_LOGIC;     -- Reset signal
        edges_done : in  STD_LOGIC;     -- Edges done signal
        alarm      : in  STD_LOGIC;     -- Alarm signal
        Alarm_ATM  : out STD_LOGIC      -- Alarm ATM signal
    );
end Alarm_Manage_ATM;

architecture Behavioral of Alarm_Manage_ATM is
    signal alarm_ATM_reg : STD_LOGIC;   -- Alarm ATM register

begin
    -- Alarm management process
    process(clk_s)
    begin
        if clk_s'event and clk_s = '1' then
            if reset = '1' then
                alarm_ATM_reg <= '0';   -- Reset alarm ATM register
            else
                -- Once alarm is set, it stays set until reset
                if alarm_ATM_reg = '0' and edges_done = '1' then
                    alarm_ATM_reg <= alarm;   -- Set alarm ATM register
                end if;
            end if;
        end if;
    end process;

    Alarm_ATM <= alarm_ATM_reg;   -- Output alarm ATM
end Behavioral;