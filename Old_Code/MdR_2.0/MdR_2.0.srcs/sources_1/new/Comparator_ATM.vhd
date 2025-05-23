library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity Comparator_ATM is
    Port ( 
        clk_ro     : in  STD_LOGIC;                      -- Clock signal for synchronization
        q_str      : in  STD_LOGIC_VECTOR(7 downto 0);   -- Input value to compare
        edge_count : in  STD_LOGIC_VECTOR(7 downto 0);   -- Number of edges detected
        Alarme     : out STD_LOGIC;                     -- Alarm output
        X_plus     : in  STD_LOGIC_VECTOR(7 downto 0);   -- Upper threshold
        X_moins    : in  STD_LOGIC_VECTOR(7 downto 0);   -- Lower threshold
        N          : in  STD_LOGIC_VECTOR(7 downto 0)    -- Threshold for edge_count
    );
end Comparator_ATM;

architecture Behavioral of Comparator_ATM is
    signal Alarme_internal : STD_LOGIC := '0';  -- Internal alarm signal
    signal Alarme_sync : STD_LOGIC := '0';     -- Synchronized alarm signal
begin
    -- Combinational logic for alarm calculation
    process(q_str, X_plus, X_moins, edge_count, N)
    begin
        -- Perform comparison only when edge_count equals N
        if unsigned(edge_count) = unsigned(N) then
            if q_str = "00000000" then
                Alarme_internal <= '0';
            else
                if unsigned(q_str) < unsigned(X_moins) or unsigned(q_str) > unsigned(X_plus) then
                    Alarme_internal <= '1';
                else
                    Alarme_internal <= '0';
                end if;
            end if;
        else
            Alarme_internal <= '0';  -- No alarm if edge_count is not equal to N
        end if;
    end process;

    -- Synchronize the alarm signal using a flip-flop
    process(clk_ro)
    begin
        if clk_ro'event and clk_ro = '1' then  -- Replace rising_edge with this condition
            Alarme_sync <= Alarme_internal;  -- Synchronize the internal signal
        end if;
    end process;

    -- Output the synchronized alarm signal
    Alarme <= Alarme_sync;
end Behavioral;