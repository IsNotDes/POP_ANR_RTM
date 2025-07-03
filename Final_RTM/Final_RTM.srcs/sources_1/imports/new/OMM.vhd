library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity OMM is
    Port (
        clk_s        : in  STD_LOGIC;                      -- Main clock signal
        reset        : in  STD_LOGIC;                      -- Global reset signal
        ro_output    : in  STD_LOGIC;                      -- Shared RO output
        Alarm_OMM    : out STD_LOGIC;                      -- Final alarm output
        q_str_omm    : out STD_LOGIC_VECTOR(15 downto 0);  -- Stored counter value output
        edges_done   : out STD_LOGIC                       -- Signal indicating counting is done
    );
end OMM;

architecture Behavioral of OMM is
    -- Internal signals for inter-component communication
    signal q_cnt_omm_internal  : STD_LOGIC_VECTOR(15 downto 0); -- Live counter value for OMM
    signal q_str_omm_internal  : STD_LOGIC_VECTOR(15 downto 0); -- Stored counter value for OMM
    signal edges_done_internal : STD_LOGIC;                    -- Signal indicating counting is done for OMM
    signal alarm               : STD_LOGIC;                    -- Alarm signal from Comparator_OMM

    -- Component declarations
    component Counter_OMM
        Port (
            ro_output    : in  STD_LOGIC;   -- Shared RO output
            reset        : in  STD_LOGIC;   -- Global reset signal
            edges_done   : in  STD_LOGIC;   -- Signal indicating counting is done
            q_cnt_omm    : out STD_LOGIC_VECTOR(15 downto 0)   -- Live counter value
        );
    end component;

    component Counter_Edges_OMM
        Port (
            clk_s        : in  STD_LOGIC;   -- Main clock signal
            reset        : in  STD_LOGIC;   -- Global reset signal
            edges_done   : out STD_LOGIC    -- Signal indicating counting is done
        );
    end component;

    component Comparator_OMM
        Port (
            clk_s        : in  STD_LOGIC;   -- Main clock signal
            reset        : in  STD_LOGIC;   -- Global reset signal
            q_str_omm    : in  STD_LOGIC_VECTOR(15 downto 0);   -- Stored counter value
            edges_done   : in  STD_LOGIC;   -- Signal indicating counting is done
            alarm        : out STD_LOGIC    -- Alarm signal from Comparator_OMM
        );
    end component;

    component Alarm_Manage_OMM
        Port (
            clk_s        : in  STD_LOGIC;   -- Main clock signal
            reset        : in  STD_LOGIC;   -- Global reset signal
            edges_done   : in  STD_LOGIC;   -- Signal indicating counting is done
            alarm        : in  STD_LOGIC;   -- Alarm signal from Comparator_OMM
            Alarm_OMM    : out STD_LOGIC    -- Final alarm output
        );
    end component;

    component Storing_OMM
        Port (
            ro_output    : in  STD_LOGIC;   -- Shared RO output
            reset        : in  STD_LOGIC;   -- Global reset signal
            edges_done   : in  STD_LOGIC;   -- Signal indicating counting is done
            q_cnt_omm    : in  STD_LOGIC_VECTOR(15 downto 0);   -- Live counter value
            q_str_omm    : out STD_LOGIC_VECTOR(15 downto 0)    -- Stored counter value
        );
    end component;

begin
    -- Assign internal signals to top-level outputs
    q_str_omm   <= q_str_omm_internal;
    edges_done  <= edges_done_internal;

    -- Instantiate Counter_ATM
    Counter_OMM_UUT: Counter_OMM
        port map (
            ro_output  => ro_output,   -- Shared RO output
            reset      => reset,       -- Global reset signal
            edges_done => edges_done_internal,   -- Signal indicating counting is done
            q_cnt_omm  => q_cnt_omm_internal   -- Live counter value
        );

    -- Instantiate Counter_Edges_OMM
    Counter_Edges_OMM_UUT: Counter_Edges_OMM
        port map (
            clk_s       => clk_s,       -- Main clock signal
            reset       => reset,       -- Global reset signal
            edges_done  => edges_done_internal   -- Signal indicating counting is done
        );

    -- Instantiate Storing_OMM
    Storing_OMM_UUT: Storing_OMM
        port map (
            ro_output  => ro_output,    -- Shared RO output
            reset      => reset,        -- Global reset signal
            edges_done => edges_done_internal,   -- Signal indicating counting is done
            q_cnt_omm  => q_cnt_omm_internal,   -- Live counter value
            q_str_omm  => q_str_omm_internal    -- Stored counter value
        );

    -- Instantiate Comparator_OMM
    Comparator_OMM_UUT: Comparator_OMM
        port map (
            clk_s        => clk_s,       -- Main clock signal
            reset        => reset,       -- Global reset signal
            q_str_omm    => q_str_omm_internal,   -- Live counter value
            edges_done   => edges_done_internal,   -- Signal indicating counting is done
            alarm        => alarm   -- Alarm signal from Comparator_OMM
        );

    -- Instantiate Alarm_Manage_OMM
    Alarm_Manage_OMM_UUT: Alarm_Manage_OMM
        port map (
            clk_s        => clk_s,       -- Main clock signal
            reset        => reset,       -- Global reset signal
            edges_done   => edges_done_internal,   -- Signal indicating counting is done
            alarm        => alarm,       -- Alarm signal from Comparator_OMM
            Alarm_OMM    => Alarm_OMM    -- Final alarm output
        );
end Behavioral;