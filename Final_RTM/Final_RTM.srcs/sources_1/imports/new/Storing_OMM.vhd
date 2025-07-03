library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Storing_OMM is
    Port (
        ro_output   : in  STD_LOGIC;    -- RO output
        reset       : in  STD_LOGIC;    -- Reset signal
        edges_done  : in  STD_LOGIC;    -- Edges done signal
        q_cnt_omm   : in  STD_LOGIC_VECTOR(15 downto 0);  -- Counter value
        q_str_omm   : out STD_LOGIC_VECTOR(15 downto 0)   -- Stored counter value
    );
end Storing_OMM;

architecture Behavioral of Storing_OMM is
    signal stored_value : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');  -- Initialize internal register
begin
    process(ro_output)
    begin
        if ro_output'event and ro_output = '1' then
            if reset = '1' then
                stored_value <= (others => '0');
            elsif edges_done = '1' then
                stored_value <= q_cnt_omm;
            end if;
        end if;
    end process;

    -- Output the registered value
    q_str_omm <= stored_value;
end Behavioral;