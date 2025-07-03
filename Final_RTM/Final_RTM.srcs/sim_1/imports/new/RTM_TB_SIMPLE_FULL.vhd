library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use STD.TEXTIO.ALL;  -- For file operations

entity RTM_TB_SIMPLE_FULL is
end RTM_TB_SIMPLE_FULL;

architecture Behavioral of RTM_TB_SIMPLE_FULL is

    -- Component Declaration for RTM
    component RTM
        Port (
            clk_s              : in  STD_LOGIC;                            -- Main clock signal
            reset              : in  STD_LOGIC;                            -- Global reset signal
            enable_ro_and_siro : in  STD_LOGIC;                            -- Combined enable signal for RO and SIRO
            gbf_out            : in  STD_LOGIC;                            -- External input from PMOD pin
            ro_out             : out STD_LOGIC;                            -- Output from the shared RO
            Alarm_Detector     : out STD_LOGIC;                            -- Alarm output from Detector
            Alarm_OMM          : out STD_LOGIC;                            -- Final alarm output from OMM
            q_str_d            : out STD_LOGIC_VECTOR(7 downto 0);         -- Stored value from Detector
            q_str_omm          : out STD_LOGIC_VECTOR(15 downto 0);        -- Stored value from OMM
            edges_done         : out STD_LOGIC                             -- Signal indicating counting is done
        );
    end component;

    -- Inputs
    signal clk_s              : STD_LOGIC := '0';                      -- Main clock signal
    signal reset              : STD_LOGIC := '0';                      -- Global reset signal
    signal enable_ro_and_siro : STD_LOGIC := '0';                      -- Combined enable signal for RO and SIRO
    signal gbf_out            : STD_LOGIC := '0';                      -- External input from PMOD pin

    -- Outputs
    signal ro_out             : STD_LOGIC;                             -- Output from the shared RO
    signal Alarm_Detector     : STD_LOGIC;                             -- Alarm output from Detector
    signal Alarm_OMM          : STD_LOGIC;                             -- Final alarm output from OMM
    signal q_str_d            : STD_LOGIC_VECTOR(7 downto 0);          -- Stored value from Detector
    signal q_str_omm          : STD_LOGIC_VECTOR(15 downto 0);         -- Stored value from OMM
    signal edges_done         : STD_LOGIC;                             -- Signal indicating counting is done

    -- Clock period definitions
    signal CLK_S_PERIOD       : TIME := 10 us;                          -- 100 kHz clock (adjust as needed)
    signal RO_PERIOD         : TIME := 250 ns;                         -- 4 MHz simulated RO (adjust as needed) (ONLY FOR SIMULATION)

begin

    -- Instantiate the Unit Under Test (UUT)
    UUT: RTM
        port map (
            clk_s              => clk_s,
            reset              => reset,
            enable_ro_and_siro => enable_ro_and_siro,
            gbf_out            => gbf_out,
            ro_out             => ro_out,
            Alarm_Detector     => Alarm_Detector,
            Alarm_OMM          => Alarm_OMM,
            q_str_d            => q_str_d,
            q_str_omm          => q_str_omm,
            edges_done         => edges_done
        );

    -- Generate main clock signal
    clk_s <= not clk_s after CLK_S_PERIOD / 2;
    
    -- Generate simulated RO signal (gbf_out) (ONLY FOR SIMULATION)
    gbf_out <= not gbf_out after RO_PERIOD / 2;
    
    process
    begin
        -- Initial reset state
        reset <= '1';
        enable_ro_and_siro <= '0';
        wait for 5 us;
        
        -- Enable the oscillators
        enable_ro_and_siro <= '1';
        wait for 5 us;
        
        -- Release reset
        reset <= '0';
        wait for 500 us;
    
        enable_ro_and_siro <= '0';
        wait for 500 us;
        
        -- ======================================
        
        CLK_S_PERIOD <= 5 us;
        RO_PERIOD <= 250 ns;
        
        -- Reset between measurements
        reset <= '1';
        wait for 250 us;
        reset <= '0';
        wait for 250 us;
        
        wait for 500 us;        
        
        -- ======================================
        
        CLK_S_PERIOD <= 5 us;
        RO_PERIOD <= 125 ns;
        
        -- Reset between measurements
        reset <= '1';
        wait for 250 us;
        reset <= '0';
        wait for 250 us;
        
        wait for 500 us;    
        
        -- ======================================
        
        CLK_S_PERIOD <= 10 us;
        RO_PERIOD <= 125 ns;
        
        -- Reset between measurements
        reset <= '1';
        wait for 250 us;
        reset <= '0';
        wait for 250 us;
        
        wait for 500 us;    
        
        -- ======================================
        
        CLK_S_PERIOD <= 10 us;
        RO_PERIOD <= 250 ns;
        
        -- Reset between measurements
        reset <= '1';
        wait for 250 us;
        reset <= '0';
        wait for 250 us;
        
        wait for 500 us;    
    
    end process;
end Behavioral;
