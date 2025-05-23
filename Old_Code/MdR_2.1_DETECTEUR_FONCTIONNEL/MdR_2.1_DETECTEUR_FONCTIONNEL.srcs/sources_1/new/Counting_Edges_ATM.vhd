library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Counting_Edges_ATM is
    Port (
        clk_s       : in  STD_LOGIC;                      -- Reference clock
        reset       : in  STD_LOGIC;                      -- Synchronous reset
        edges_done  : out STD_LOGIC;                      -- Signal indicating counting is done
        edge_count  : out STD_LOGIC_VECTOR(2 downto 0)    -- Number of edges detected on clk_s
    );
end Counting_Edges_ATM;

architecture Behavioral of Counting_Edges_ATM is
    signal counter_reg : INTEGER := 0;                    -- Internal counter register
    constant N         : INTEGER := 5;                    -- Threshold for edge count
    signal edge_count_reg : UNSIGNED(2 downto 0) := (others => '0'); -- Internal edge count register
begin
    process(clk_s)
    begin
        if clk_s'event and clk_s = '1' then
            if reset = '1' then
                counter_reg <= 0;                         -- Reset counter
                edges_done <= '0';                        -- Clear done signal
                edge_count_reg <= (others => '0');        -- Reset edge count
            else
                if counter_reg < N - 1 then
                    counter_reg <= counter_reg + 1;       -- Increment counter
                    edge_count_reg <= edge_count_reg + 1; -- Increment edge count
                end if;
                if counter_reg = N - 1 then
                    edges_done <= '1';                    -- Raise done signal
                else
                    edges_done <= '0';
                end if;
            end if;
        end if;
    end process;

    edge_count <= STD_LOGIC_VECTOR(edge_count_reg);       -- Output the edge count
end Behavioral;