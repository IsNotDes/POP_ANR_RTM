library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Storing_ATM is
    Port (
        ro_output   : in  STD_LOGIC;
        reset       : in  STD_LOGIC;
        edges_done  : in  STD_LOGIC;
        q_cnt_atm   : in  STD_LOGIC_VECTOR(15 downto 0);
        q_str_atm   : out STD_LOGIC_VECTOR(15 downto 0)
    );
end Storing_ATM;

architecture Behavioral of Storing_ATM is
begin
    process(ro_output)
    begin
        if ro_output'event and ro_output = '1' then
            if reset = '1' then
                q_str_atm <= (others => '0');
            elsif edges_done = '1' then
                q_str_atm <= q_cnt_atm;
            end if;
        end if;
    end process;
end Behavioral;