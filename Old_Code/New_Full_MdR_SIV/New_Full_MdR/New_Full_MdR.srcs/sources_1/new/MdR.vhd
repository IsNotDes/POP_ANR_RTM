library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MdR is
    Port (
        clk_s       : in  STD_LOGIC;                            -- Main clock signal
        reset       : in  STD_LOGIC;                            -- Global reset signal
        enable_ro   : in  STD_LOGIC;                            -- Enable signal for the shared RO
        enable_siro : in  STD_LOGIC;                            -- Enable signal for the SIRO (not used in this design)
        ro_out      : out STD_LOGIC;                            -- Output from the shared RO
        Alarme      : out STD_LOGIC;                            -- Alarm output from Detector
        Final_Alarm : out STD_LOGIC;                            -- Final alarm output from Auto_Test_Module
        q_str_d     : out STD_LOGIC_VECTOR(4 downto 0);          -- Stored value from Detector
        q_str_atm   : out STD_LOGIC_VECTOR(7 downto 0);          -- Stored value from Auto_Test_Module
        edge_count  : out STD_LOGIC_VECTOR(2 downto 0);          -- Edge count from Auto_Test_Module
        edges_done  : out STD_LOGIC;                            -- Signal indicating counting is done
        x_moins_out : out STD_LOGIC_VECTOR(4 downto 0);          -- Output for x_moins
        x_plus_out  : out STD_LOGIC_VECTOR(4 downto 0);          -- Output for x_plus
        y_moins_out : out STD_LOGIC_VECTOR(7 downto 0);          -- Output for y_moins
        y_plus_out  : out STD_LOGIC_VECTOR(7 downto 0)           -- Output for y_plus
    );
end MdR;

architecture Behavioral of MdR is
    signal ro_out_internal : STD_LOGIC;  -- Internal signal for shared RO output
begin
    -- Assign the internal signal to the top-level output
    ro_out <= ro_out_internal;

    -- Instantiate the Auto_Test_Module
    ATM_UUT: entity work.ATM
        port map (
            clk_s       => clk_s,          -- Main clock signal
            reset       => reset,          -- Global reset signal
            ro_output   => ro_out_internal,-- Shared RO output
            Final_Alarm => Final_Alarm,    -- Final alarm output
            q_str_atm   => q_str_atm,      -- Stored value output
            edge_count  => edge_count,     -- Edge count output
            edges_done  => edges_done,     -- Signal indicating counting is done
            y_moins_out => y_moins_out,    -- Output for y_moins
            y_plus_out  => y_plus_out      -- Output for y_plus
        );

    -- Instantiate Detector module
    Detector_inst: entity work.Detector
        port map (
            clk_s       => clk_s,          -- Main clock signal
            Alarme      => Alarme,         -- Alarm output
            q_str_d     => q_str_d,        -- Stored value output
            ro_output   => ro_out_internal,-- Connects to the shared RO output
            x_moins_out => x_moins_out,    -- Output for x_moins
            x_plus_out  => x_plus_out      -- Output for x_plus
        );

    -- Instantiate RO_SIRO module
    RO_SIRO_inst: entity work.RO_SIRO
        port map (
            enable_ro   => enable_ro,      -- Enable signal for the shared RO
            ro_out      => ro_out_internal,-- Shared RO output
            enable_siro => enable_siro     -- SIRO enable signal (not used in this design)
        );
end Behavioral;