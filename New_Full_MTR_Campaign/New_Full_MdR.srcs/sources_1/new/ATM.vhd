library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ATM is
    Port (
        clk_s        : in  STD_LOGIC;                      -- Main clock signal
        reset        : in  STD_LOGIC;                      -- Global reset signal
        ro_output    : in  STD_LOGIC;                      -- Shared RO output
        Alarm_ATM    : out STD_LOGIC;                      -- Final alarm output
        q_str_atm    : out STD_LOGIC_VECTOR(15 downto 0);  -- Stored counter value output
        edges_done   : out STD_LOGIC                       -- Signal indicating counting is done
    );
end ATM;

architecture Behavioral of ATM is
    -- Internal signals for inter-component communication
    signal q_cnt_atm_internal  : STD_LOGIC_VECTOR(15 downto 0); -- Live counter value for ATM
    signal q_str_atm_internal  : STD_LOGIC_VECTOR(15 downto 0); -- Stored counter value for ATM
    signal edges_done_internal : STD_LOGIC;                    -- Signal indicating counting is done for ATM
    signal alarm               : STD_LOGIC;                    -- Alarm signal from Comparator_ATM

    -- Component declarations
    component Counter_ATM
        Port (
            ro_output    : in  STD_LOGIC;   -- Shared RO output
            reset        : in  STD_LOGIC;   -- Global reset signal
            edges_done   : in  STD_LOGIC;   -- Signal indicating counting is done
            q_cnt_atm    : out STD_LOGIC_VECTOR(15 downto 0)   -- Live counter value
        );
    end component;

    component Counter_Edges_ATM
        Port (
            clk_s        : in  STD_LOGIC;   -- Main clock signal
            reset        : in  STD_LOGIC;   -- Global reset signal
            edges_done   : out STD_LOGIC    -- Signal indicating counting is done
        );
    end component;

    component Comparator_ATM
        Port (
            clk_s        : in  STD_LOGIC;   -- Main clock signal
            reset        : in  STD_LOGIC;   -- Global reset signal
            q_str_atm    : in  STD_LOGIC_VECTOR(15 downto 0);   -- Stored counter value
            edges_done   : in  STD_LOGIC;   -- Signal indicating counting is done
            alarm        : out STD_LOGIC    -- Alarm signal from Comparator_ATM
        );
    end component;

    component Alarm_Manage_ATM
        Port (
            clk_s        : in  STD_LOGIC;   -- Main clock signal
            reset        : in  STD_LOGIC;   -- Global reset signal
            edges_done   : in  STD_LOGIC;   -- Signal indicating counting is done
            alarm        : in  STD_LOGIC;   -- Alarm signal from Comparator_ATM
            Alarm_ATM    : out STD_LOGIC    -- Final alarm output
        );
    end component;

    component Storing_ATM
        Port (
            ro_output    : in  STD_LOGIC;   -- Shared RO output
            reset        : in  STD_LOGIC;   -- Global reset signal
            edges_done   : in  STD_LOGIC;   -- Signal indicating counting is done
            q_cnt_atm    : in  STD_LOGIC_VECTOR(15 downto 0);   -- Live counter value
            q_str_atm    : out STD_LOGIC_VECTOR(15 downto 0)    -- Stored counter value
        );
    end component;

begin
    -- Assign internal signals to top-level outputs
    q_str_atm   <= q_str_atm_internal;
    edges_done  <= edges_done_internal;

    -- Instantiate Counter_ATM
    Counter_ATM_UUT: Counter_ATM
        port map (
            ro_output  => ro_output,   -- Shared RO output
            reset      => reset,       -- Global reset signal
            edges_done => edges_done_internal,   -- Signal indicating counting is done
            q_cnt_atm  => q_cnt_atm_internal   -- Live counter value
        );

    -- Instantiate Counter_Edges_ATM
    Counter_Edges_ATM_UUT: Counter_Edges_ATM
        port map (
            clk_s       => clk_s,       -- Main clock signal
            reset       => reset,       -- Global reset signal
            edges_done  => edges_done_internal   -- Signal indicating counting is done
        );

    -- Instantiate Storing_ATM
    Storing_ATM_UUT: Storing_ATM
        port map (
            ro_output  => ro_output,    -- Shared RO output
            reset      => reset,        -- Global reset signal
            edges_done => edges_done_internal,   -- Signal indicating counting is done
            q_cnt_atm  => q_cnt_atm_internal,   -- Live counter value
            q_str_atm  => q_str_atm_internal    -- Stored counter value
        );

    -- Instantiate Comparator_ATM
    Comparator_ATM_UUT: Comparator_ATM
        port map (
            clk_s        => clk_s,       -- Main clock signal
            reset        => reset,       -- Global reset signal
            q_str_atm    => q_str_atm_internal,   -- Live counter value
            edges_done   => edges_done_internal,   -- Signal indicating counting is done
            alarm        => alarm   -- Alarm signal from Comparator_ATM
        );

    -- Instantiate Alarm_Manage_ATM
    Alarm_Manage_ATM_UUT: Alarm_Manage_ATM
        port map (
            clk_s        => clk_s,       -- Main clock signal
            reset        => reset,       -- Global reset signal
            edges_done   => edges_done_internal,   -- Signal indicating counting is done
            alarm        => alarm,       -- Alarm signal from Comparator_ATM
            Alarm_ATM    => Alarm_ATM    -- Final alarm output
        );
end Behavioral;