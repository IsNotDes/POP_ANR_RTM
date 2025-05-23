library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MdR is
    Port (
        clk_s       : in  STD_LOGIC;                      -- Main clock signal
        reset       : in  STD_LOGIC;                      -- Global reset signal
        enable_ro   : in  STD_LOGIC;                      -- Enable signal for the shared RO
        Alarme_Detector : out STD_LOGIC;                  -- Alarm output from Detector
        Final_Alarm_AutoTest : out STD_LOGIC;             -- Final alarm output from Auto_Test_Module
        q_str_detector : out STD_LOGIC_VECTOR(6 downto 0); -- Stored value from Detector (modified to 6 downto 0)
        q_str_auto_test : out STD_LOGIC_VECTOR(6 downto 0);-- Stored value from Auto_Test_Module (modified to 6 downto 0)
        edge_count      : out STD_LOGIC_VECTOR(2 downto 0);-- Edge count from Auto_Test_Module
        edges_done      : out STD_LOGIC                    -- Signal indicating counting is done
    );
end MdR;

architecture Behavioral of MdR is
    -- Internal signals for inter-component communication
    signal ro_out_shared : STD_LOGIC;                     -- Shared RO output

begin
    -- Instantiate the Detector module
    Detector_UUT: entity work.Detector
        port map (
            clk_s     => clk_s,
            Alarme    => Alarme_Detector,
            q_str     => q_str_detector,
            ro_out    => open,                             -- Not used externally
            enable_ro => enable_ro
        );

    -- Instantiate the Auto_Test_Module
    Auto_Test_Module_UUT: entity work.Auto_Test_Module
        port map (
            clk_s       => clk_s,
            reset       => reset,
            enable_ro   => enable_ro,
            Final_Alarm => Final_Alarm_AutoTest,
            q_str       => q_str_auto_test,
            edge_count  => edge_count,
            edges_done  => edges_done
        );
end Behavioral;