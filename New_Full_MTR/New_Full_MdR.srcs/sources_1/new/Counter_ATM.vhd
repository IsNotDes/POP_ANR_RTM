library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Counter_ATM is
    Port (
        ro_output   : in  STD_LOGIC;
        reset       : in  STD_LOGIC;
        edges_done  : in  STD_LOGIC;
        q_cnt_atm   : out STD_LOGIC_VECTOR(15 downto 0)
    );
end Counter_ATM;

architecture Behavioral of Counter_ATM is
    signal counter_reg      : UNSIGNED(15 downto 0) := (others => '0'); -- Internal counter register
    signal edges_done_sync1 : STD_LOGIC := '0';                        -- Register to store the synchronized value of edges_done
    signal edges_done_sync2 : STD_LOGIC := '0';                        -- Register to store the synchronized value of edges_done
    signal edges_done_prev  : STD_LOGIC := '0';                        -- Register to store the previous value of edges_done
begin
    -- Synchronize edges_done to ro_output clock domain
    process(ro_output)
    begin
        if ro_output'event and ro_output = '1' then
            edges_done_sync1 <= edges_done;
            edges_done_sync2 <= edges_done_sync1;
        end if;
    end process;

    -- Main counter process
    process(ro_output)
    begin
        if ro_output'event and ro_output = '1' then
            -- Detect falling edge of edges_done (synchronized)
            if reset = '1' or (edges_done_prev = '1' and edges_done_sync2 = '0') then
                counter_reg <= (others => '0');  -- Reset the counter on falling edge of edges_done
            elsif edges_done_sync2 = '0' then
                counter_reg <= counter_reg + 1;  -- Increment the counter when edges_done is '0'
            end if;

            -- Update the previous value of edges_done
            edges_done_prev <= edges_done_sync2;
        end if;
    end process;

    -- Assign the counter value to the output
    q_cnt_atm <= STD_LOGIC_VECTOR(counter_reg);
end Behavioral;