library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Counter_ATM is
    Port (
        ro_output    : in  STD_LOGIC;
        reset     : in  STD_LOGIC;
        edges_done : in STD_LOGIC;
        q_str_atm     : out STD_LOGIC_VECTOR(6 downto 0)
    );
end Counter_ATM;

architecture Behavioral of Counter_ATM is
    signal counter_reg : UNSIGNED(6 downto 0) := (others => '0');
    -- Synchronizer for edges_done (clk_s ? ro_output)
    signal edges_done_sync : STD_LOGIC_VECTOR(1 downto 0);  -- 2-stage shift register

begin
    -- Synchronizer process
    process(ro_output)
    begin
        if ro_output'event and ro_output = '1' then
            edges_done_sync <= edges_done & edges_done_sync(0);
        end if;
    end process;

    -- Counter process uses the synchronized signal
    process(ro_output)
    begin
        if ro_output'event and ro_output = '1' then
            if reset = '1' or edges_done_sync(1) = '1' then  -- Use edges_done_sync(1)
                counter_reg <= (others => '0');
            elsif edges_done_sync(1) = '0' then
                counter_reg <= counter_reg + 1;
            end if;
        end if;
    end process;

    q_str_atm <= STD_LOGIC_VECTOR(counter_reg);
end Behavioral;