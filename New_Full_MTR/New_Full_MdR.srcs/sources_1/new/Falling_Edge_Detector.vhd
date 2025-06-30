library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Falling_Edge_Detector is
    Port (
        clk_s     : in  STD_LOGIC;  -- Input signal to monitor (renamed for clarity)
        reset     : in  STD_LOGIC;  -- Active-low reset
        ro_output : in  STD_LOGIC;  -- Clock signal
        q_fe      : out STD_LOGIC   -- Falling edge pulse output
    );
end Falling_Edge_Detector;

architecture Behavioral of Falling_Edge_Detector is
    signal clk_s_sync : STD_LOGIC_VECTOR(3 downto 0); -- 4-stage synchronizer for clk_s
    signal clk_s_dly  : STD_LOGIC; -- Register to store previous state of synchronized clk_s
begin
    -- 4-stage synchronizer for clk_s (clk_s ? ro_output)
    process(ro_output)
    begin
        if ro_output'event and ro_output = '1' then
            if reset = '1' then
                clk_s_sync <= (others => '0');
            else
                clk_s_sync <= clk_s & clk_s_sync(3 downto 1); -- 4-stage flip-flop chain
            end if;
        end if;
    end process;

    -- Register the synchronized clk_s value
    process(ro_output)
    begin
        if ro_output'event and ro_output = '1' then
            if reset = '1' then
                clk_s_dly <= '0';
            else
                clk_s_dly <= clk_s_sync(3);
            end if;
        end if;
    end process;

    -- Use the synchronized clk_s for falling edge detection
    q_fe <= clk_s_dly and (not clk_s_sync(3));
end Behavioral;