library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Counter_Edges_OMM is
    Port (
        clk_s      : in  STD_LOGIC;                      -- Reference clock
        reset      : in  STD_LOGIC;                      -- Synchronous reset
        edges_done : out STD_LOGIC                       -- Signal indicating counting is done
    );
end Counter_Edges_OMM;

architecture Behavioral of Counter_Edges_OMM is
    constant N             : INTEGER := 5;                    -- Numbers of clk_s periods during which the edges of ro_output are counted
    signal edge_count_reg  : UNSIGNED(2 downto 0) := (others => '0'); -- Internal edge count register
begin
    process(clk_s)
    begin
        if clk_s'event and clk_s = '1' then
            if reset = '1' then
                edges_done      <= '0';                        -- Clear done signal
                edge_count_reg  <= (others => '0');            -- Reset edge count
            else
                if edge_count_reg < N then
                    edge_count_reg <= edge_count_reg + 1;     -- Increment edge count
                end if;
                if edge_count_reg = N then
                    edges_done      <= '1';                    -- Raise done signal
                    edge_count_reg  <= (others => '0');        -- Reset edge count
                else
                    edges_done      <= '0';
                end if;
            end if;
        end if;
    end process;
end Behavioral;