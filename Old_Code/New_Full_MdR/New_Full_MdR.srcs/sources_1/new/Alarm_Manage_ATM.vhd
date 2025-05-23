library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Alarm_Manage_ATM is
    Port (
        clk_s         : in  STD_LOGIC;
        reset         : in  STD_LOGIC;
        edges_done    : in  STD_LOGIC;
        alarm    : in  STD_LOGIC;
        Final_Alarm   : out STD_LOGIC
    );
end Alarm_Manage_ATM;

architecture Behavioral of Alarm_Manage_ATM is
    signal final_alarm_reg : STD_LOGIC;
    -- Synchronizer for alarm (ro_output ? clk_s)
    signal alarm_sync : STD_LOGIC_VECTOR(1 downto 0);  -- 2-stage shift register

begin
    -- Synchronizer process
    process(clk_s)
    begin
        if clk_s'event and clk_s = '1' then
            alarm_sync <= alarm & alarm_sync(0);
        end if;
    end process;

    -- Alarm management process uses the synchronized signal
    process(clk_s)
    begin
        if clk_s'event and clk_s = '1' then
            if reset = '1' then
                final_alarm_reg <= '0';
            elsif edges_done = '1' then
                final_alarm_reg <= alarm_sync(1);  -- Use alarm_sync(1)
            end if;
        end if;
    end process;

    Final_Alarm <= final_alarm_reg;
end Behavioral;