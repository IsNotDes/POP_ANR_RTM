library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Counter_Detector is
    Port (
        clk_s     : in  STD_LOGIC;                      -- Enable/Reset signal
        ro_output    : in  STD_LOGIC;                      -- Clock signal for counting
        q_cnt     : out STD_LOGIC_VECTOR(4 downto 0)    -- Counter output value
    );
end Counter_Detector;

architecture Behavioral of Counter_Detector is
    signal counter_reg : UNSIGNED(4 downto 0); -- Counter register
    signal clk_s_sync  : STD_LOGIC_VECTOR(1 downto 0); -- Synchronizer for clk_s

begin
    -- Synchronizer for clk_s (clk_s ? ro_output)
    process(ro_output)
    begin
        if ro_output'event and ro_output = '1' then
            clk_s_sync <= clk_s & clk_s_sync(0); -- 2-stage flip-flop chain
        end if;
    end process;

    -- Counter process using synchronized clk_s
    process(ro_output)
    begin
        if ro_output'event and ro_output = '1' then
            if clk_s_sync(1) = '0' then -- Reset condition (active low enable/reset assumed)
                counter_reg <= (others => '0');
            else -- clk_s = '1', enable counting
                counter_reg <= counter_reg + 1;
            end if;
        end if;
    end process;

    -- Output the counter value
    q_cnt <= STD_LOGIC_VECTOR(counter_reg);
end Behavioral;