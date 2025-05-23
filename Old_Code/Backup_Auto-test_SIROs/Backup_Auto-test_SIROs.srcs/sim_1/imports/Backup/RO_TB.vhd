    library IEEE;
    use IEEE.STD_LOGIC_1164.ALL;
    
    entity RO_TB is
    end RO_TB;
    
    architecture Behavioral of RO_TB is
        -- Test signals
        signal Enable_s : STD_LOGIC := '0';
        signal RO_OUT_s : STD_LOGIC;
    
        -- Corrected Component Declaration
        component RO is
            Port (
                Enable  : in  STD_LOGIC;
                RO_OUT  : out STD_LOGIC
            );
        end component;
    
    begin
        -- Component Instantiation
        inst_RO: RO
            port map (
                Enable => Enable_s,
                RO_OUT => RO_OUT_s
            );
    
        -- Test process
        stim_proc: process
        begin
        
            Enable_s <= '0';
            wait for 100 ns;
    
            Enable_s <= '1';
            wait for 500 ns;
    
            Enable_s <= '0';
            wait for 100 ns;
    
            wait;
        end process;
    end Behavioral;
