library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use STD.TEXTIO.ALL;  -- For file operations

entity RTM_TB is
end RTM_TB;

architecture Behavioral of RTM_TB is

    -- Component Declaration for RTM
    component RTM
        Port (
            clk_s              : in  STD_LOGIC;                            -- Main clock signal
            reset              : in  STD_LOGIC;                            -- Global reset signal
            enable_ro_and_siro : in  STD_LOGIC;                            -- Combined enable signal for RO and SIRO
            gbf_out            : in  STD_LOGIC;                            -- External input from PMOD pin
            ro_out             : out STD_LOGIC;                            -- Output from the shared RO
            Alarm_Detector     : out STD_LOGIC;                            -- Alarm output from Detector
            Alarm_OMM          : out STD_LOGIC;                            -- Final alarm output from Auto_Test_Module
            q_str_d            : out STD_LOGIC_VECTOR(7 downto 0);         -- Stored value from Detector
            q_str_omm          : out STD_LOGIC_VECTOR(15 downto 0);        -- Stored value from Auto_Test_Module
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
    signal Alarm_OMM          : STD_LOGIC;                             -- Final alarm output from Auto_Test_Module
    signal q_str_d            : STD_LOGIC_VECTOR(7 downto 0);          -- Stored value from Detector
    signal q_str_omm          : STD_LOGIC_VECTOR(15 downto 0);         -- Stored value from Auto_Test_Module
    signal edges_done         : STD_LOGIC;                             -- Signal indicating counting is done

    -- Clock period definitions
    signal CLK_S_PERIOD       : TIME := 10 us;                          -- 100 kHz clock (adjust as needed)
    signal RO_PERIOD         : TIME := 250 ns;                         -- 4 MHz simulated RO (adjust as needed) (ONLY FOR SIMULATION)

    -- Constants for test configuration
    constant CLK_S_BASE       : TIME := 10 us;                          -- Base period for clk_s (100 kHz)
    constant RO_BASE         : TIME := 250 ns;                         -- Base period for gbf_out (4 MHz)
    constant STEP_PERCENT     : real := 1.0;                           -- Step size in percentage
    constant STABLE_TIME      : TIME := 500 us;                           -- Time to wait for stable operation
    constant NUM_STEPS        : integer := 50;                          -- Number of steps in each direction

    -- File handling
    file results_file : TEXT;
    constant results_filename : string := "..\\..\\..\\..\\..\\..\\..\\Simulation_Results\\simulation_results.csv";

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
    
    -- Main test process
    process
        variable clk_s_period_current : TIME;
        variable gbf_period_current   : TIME;
        variable reset_time           : TIME;
        variable line_out            : LINE;
        variable clk_s_freq          : real;
        variable gbf_freq            : real;
    begin
        -- Open results file
        file_open(results_file, results_filename, WRITE_MODE);
        
        -- Write header
        write(line_out, string'("clk_s_T(s),gbf_T(s),q_str_d,Alarm_Detector,q_str_omm,Alarm_OMM"));
        writeline(results_file, line_out);
        
        -- Initial reset state
        reset <= '1';
        enable_ro_and_siro <= '0';
        wait for 5 us;
        
        -- Enable the oscillators
        enable_ro_and_siro <= '1';
        wait for 5 us;
        
        -- Release reset
        reset <= '0';
        wait for 5 ms;

        enable_ro_and_siro <= '0';
        wait for 1 ms;

        -- Test matrix: Vary both clocks systematically
        for i in -NUM_STEPS to NUM_STEPS loop
            -- Calculate current clk_s period (varying by STEP_PERCENT)
            clk_s_period_current := CLK_S_BASE * (1.0 + real(i) * STEP_PERCENT / 100.0);
            CLK_S_PERIOD <= clk_s_period_current;
            
            for j in -NUM_STEPS to NUM_STEPS loop
                -- Calculate current gbf_out period (varying by STEP_PERCENT)
                gbf_period_current := RO_BASE * (1.0 + real(j) * STEP_PERCENT / 100.0);
                RO_PERIOD <= gbf_period_current;
                
                reset_time := CLK_S_PERIOD;
                
                -- Reset between measurements
                reset <= '1';
                wait for reset_time;
                reset <= '0';

                -- Wait for stable operation
                wait for STABLE_TIME;
                
                -- Write results to file
                write(line_out, clk_s_period_current / 1 ns * 1.0e-9);
                write(line_out, string'(","));
                write(line_out, gbf_period_current / 1 ns * 1.0e-9);
                write(line_out, string'(","));
                write(line_out, integer'image(to_integer(unsigned(q_str_d))));
                write(line_out, string'(","));
                write(line_out, std_logic'image(Alarm_Detector));
                write(line_out, string'(","));
                write(line_out, integer'image(to_integer(unsigned(q_str_omm))));
                write(line_out, string'(","));
                write(line_out, std_logic'image(Alarm_OMM));
                writeline(results_file, line_out);
                
            end loop;
        end loop;
        
        -- Close the file
        file_close(results_file);
        
        -- End simulation
        report "Simulation completed. Results written to " & results_filename;
        wait;
    end process;
end Behavioral;