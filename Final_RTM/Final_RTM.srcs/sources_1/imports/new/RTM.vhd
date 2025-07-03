library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RTM is
    Port (
        clk_s              : in  STD_LOGIC;                            -- Main clock signal
        reset              : in  STD_LOGIC;                            -- Global reset signal
        enable_ro_and_siro : in  STD_LOGIC;                            -- Combined enable signal for RO and SIRO
        gbf_out            : in  STD_LOGIC;                            -- External input from PMOD pin
        ro_out             : out STD_LOGIC;                            -- Output from the shared RO or GBF
        Alarm_Detector     : out STD_LOGIC;                            -- Alarm output from Detector
        Alarm_OMM          : out STD_LOGIC;                            -- Final alarm output from OMM
        q_str_d            : out STD_LOGIC_VECTOR(7 downto 0);         -- Stored value from Detector
        q_str_omm          : out STD_LOGIC_VECTOR(15 downto 0);        -- Stored value from OMM
        edges_done         : out STD_LOGIC                             -- Signal indicating counting is done
    );
end RTM;

architecture Behavioral of RTM is
    signal ro_internal     : STD_LOGIC;  -- Internal signal for RO output from the RO_SIRO module
    signal ro_output       : STD_LOGIC;  -- Internal signal for shared RO output

    component OMM
        Port (
            clk_s          : in  STD_LOGIC;                           -- Main clock
            reset          : in  STD_LOGIC;                           -- Active-low reset
            ro_output      : in  STD_LOGIC;                           -- Shared RO output
            Alarm_OMM      : out STD_LOGIC;                           -- Alarm_OMM output
            q_str_omm      : out STD_LOGIC_VECTOR(15 downto 0);       -- Stored value output
            edges_done     : out STD_LOGIC                            -- Signal indicating counting is done
        );
    end component;

    component Detector
        Port (
            clk_s           : in  STD_LOGIC;                           -- Main clock
            reset           : in  STD_LOGIC;                           -- Active-low reset
            ro_output       : in  STD_LOGIC;                           -- Shared RO output
            Alarm_Detector  : out STD_LOGIC;                           -- Alarm_Detector output
            q_str_d         : out STD_LOGIC_VECTOR(7 downto 0)         -- Stored value output
        );
    end component;
    
    component RO_SIRO
        Port (
            enable_ro_and_siro : in  STD_LOGIC;                       -- Combined enable signal
            ro_out             : out STD_LOGIC                        -- Shared RO output
        );
    end component;
    
begin
    -- Multiplexer logic to select between internal RO and gbf_out
    ro_output <= gbf_out when enable_ro_and_siro = '0' else ro_internal;
    
    -- Assign the internal signal to the top-level output
    ro_out <= ro_output;

    -- Instantiate the Auto_Test_Module
    OMM_UUT: OMM
        port map (
            clk_s       => clk_s,                               -- Main clock
            reset       => reset,                               -- Active-low reset
            ro_output   => ro_output,                           -- Shared RO output
            Alarm_OMM   => Alarm_OMM,                           -- Alarm_OMM output
            q_str_omm   => q_str_omm,                           -- Stored value output
            edges_done  => edges_done                           -- Signal indicating counting is done
        );

    -- Instantiate Detector module
    Detector_UUT: Detector
        port map (
            clk_s           => clk_s,                               -- Main clock
            reset           => reset,                               -- Active-low reset
            ro_output       => ro_output,                           -- Shared RO output
            Alarm_Detector  => Alarm_Detector,                      -- Alarm output
            q_str_d         => q_str_d                              -- Stored value output
        );

    -- Instantiate RO_SIRO module
    RO_SIRO_UUT: RO_SIRO
        port map (
            enable_ro_and_siro => enable_ro_and_siro,  -- Combined enable signal
            ro_out             => ro_internal          -- Shared RO output (internal only)
        );
end Behavioral;