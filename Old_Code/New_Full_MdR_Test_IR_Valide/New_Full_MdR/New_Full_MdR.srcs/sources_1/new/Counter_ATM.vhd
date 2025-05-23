library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Counter_ATM is
    Port (
        ro_output   : in  STD_LOGIC;
        reset       : in  STD_LOGIC;
        edges_done  : in  STD_LOGIC;
        q_cnt_atm   : out STD_LOGIC_VECTOR(7 downto 0)
    );
end Counter_ATM;

architecture Behavioral of Counter_ATM is
    signal counter_reg      : UNSIGNED(7 downto 0) := (others => '0'); -- Internal counter register
    signal edges_done_prev  : STD_LOGIC := '0';                        -- Register to store the previous value of edges_done
begin
    process(ro_output)
    begin
        if ro_output'event and ro_output = '1' then
            -- Detect falling edge of edges_done
            if reset = '1' or (edges_done_prev = '1' and edges_done = '0') then
                counter_reg <= (others => '0');  -- Reset the counter on falling edge of edges_done
            elsif edges_done = '0' then
                counter_reg <= counter_reg + 1;  -- Increment the counter when edges_done is '0'
            end if;

            -- Update the previous value of edges_done
            edges_done_prev <= edges_done;
        end if;
    end process;

    -- Assign the counter value to the output
    q_cnt_atm <= STD_LOGIC_VECTOR(counter_reg);
end Behavioral;