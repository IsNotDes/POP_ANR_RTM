library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity CountEdges is
    Port (
        clk_s         : in  STD_LOGIC;                      -- Clock signal (for edge detection)
        q_cnt_input   : in  STD_LOGIC_VECTOR(7 downto 0);   -- Input from Counter_D (q_cnt)
        q_cnt_finale  : out STD_LOGIC_VECTOR(7 downto 0);   -- Accumulated counter value
        edge_count    : out STD_LOGIC_VECTOR(7 downto 0)    -- Number of edges detected on clk_s
    );
end CountEdges;

architecture Behavioral of CountEdges is
    signal edge_count_reg   : UNSIGNED(7 downto 0) := (others => '0'); -- Register to count edges
    signal q_cnt_finale_reg : UNSIGNED(7 downto 0) := (others => '0'); -- Register to store accumulated q_cnt
begin

    -- Process to detect edges of clk_s and count them
    process(clk_s)
    begin
        if clk_s'event and clk_s = '1' then
            q_cnt_finale_reg <= q_cnt_finale_reg + UNSIGNED(q_cnt_input);
            edge_count_reg <= edge_count_reg + 1;
        end if;
    end process;

    -- Output the accumulated counter value and edge count
    q_cnt_finale <= STD_LOGIC_VECTOR(q_cnt_finale_reg);
    edge_count <= STD_LOGIC_VECTOR(edge_count_reg);

end Behavioral;