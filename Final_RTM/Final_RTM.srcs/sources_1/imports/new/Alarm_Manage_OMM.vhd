library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Alarm_Manage_OMM is
    Port (
        clk_s      : in  STD_LOGIC;     -- Clock signal
        reset      : in  STD_LOGIC;     -- Reset signal
        edges_done : in  STD_LOGIC;     -- Edges done signal
        alarm      : in  STD_LOGIC;     -- Alarm signal
        Alarm_OMM  : out STD_LOGIC      -- Alarm OMM signal
    );
end Alarm_Manage_OMM;

architecture Behavioral of Alarm_Manage_OMM is
    signal alarm_OMM_reg : STD_LOGIC;   -- Alarm OMM register

begin
    -- Alarm management process
    process(clk_s)
    begin
        if clk_s'event and clk_s = '1' then
            if reset = '1' then
                alarm_OMM_reg <= '0';   -- Reset alarm OMM register
            else
                -- Once alarm is set, it stays set until reset
                if alarm_OMM_reg = '0' and edges_done = '1' then
                    alarm_OMM_reg <= alarm;   -- Set alarm OMM register
                end if;
            end if;
        end if;
    end process;

    Alarm_OMM <= alarm_OMM_reg;   -- Output alarm OMM
end Behavioral;