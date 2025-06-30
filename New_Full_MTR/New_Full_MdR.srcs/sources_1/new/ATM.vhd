library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ATM is
    Port (
        clk_s        : in  STD_LOGIC;                      -- Main clock signal
        reset        : in  STD_LOGIC;                      -- Global reset signal
        ro_output    : in  STD_LOGIC;                      -- Shared RO output
        Alarm_ATM    : out STD_LOGIC;                      -- Final alarm output
        q_str_atm    : out STD_LOGIC_VECTOR(15 downto 0);  -- Stored value output
        edge_count   : out STD_LOGIC_VECTOR(2 downto 0);   -- Edge count output
        edges_done   : out STD_LOGIC                       -- Signal indicating counting is done
    );
end ATM;

architecture Behavioral of ATM is
    -- Internal signals for inter-component communication
    signal q_cnt_atm_internal  : STD_LOGIC_VECTOR(15 downto 0); -- Live counter value
    signal q_str_atm_internal  : STD_LOGIC_VECTOR(15 downto 0); -- Live counter value
    signal edges_done_internal : STD_LOGIC;                    -- Signal indicating counting is done
    signal alarm               : STD_LOGIC;                    -- Alarm signal from Comparator_ATM
    signal edge_count_internal : STD_LOGIC_VECTOR(2 downto 0); -- Edge count output

    -- Component declarations
    component Counter_ATM
        Port (
            ro_output    : in  STD_LOGIC;
            reset        : in  STD_LOGIC;
            edges_done   : in  STD_LOGIC;
            q_cnt_atm    : out STD_LOGIC_VECTOR(15 downto 0)
        );
    end component;

    component Counter_Edges_ATM
        Port (
            clk_s        : in  STD_LOGIC;
            reset        : in  STD_LOGIC;
            edges_done   : out STD_LOGIC;
            edge_count   : out STD_LOGIC_VECTOR(2 downto 0)
        );
    end component;

    component Comparator_ATM
        Port (
            clk_s        : in  STD_LOGIC;
            reset        : in  STD_LOGIC;
            q_str_atm    : in  STD_LOGIC_VECTOR(15 downto 0);
            edges_done   : in  STD_LOGIC;
            alarm        : out STD_LOGIC
        );
    end component;

    component Alarm_Manage_ATM
        Port (
            clk_s        : in  STD_LOGIC;
            reset        : in  STD_LOGIC;
            edges_done   : in  STD_LOGIC;
            alarm        : in  STD_LOGIC;
            Alarm_ATM    : out STD_LOGIC
        );
    end component;

    component Storing_ATM
        Port (
            ro_output    : in  STD_LOGIC;
            reset        : in  STD_LOGIC;
            edges_done   : in  STD_LOGIC;
            q_cnt_atm    : in  STD_LOGIC_VECTOR(15 downto 0);
            q_str_atm    : out STD_LOGIC_VECTOR(15 downto 0)
        );
    end component;

begin
    -- Assign internal signals to top-level outputs
    q_str_atm   <= q_str_atm_internal;
    edge_count  <= edge_count_internal;
    edges_done  <= edges_done_internal;

    -- Instantiate Counter_ATM
    Counter_ATM_UUT: Counter_ATM
        port map (
            ro_output  => ro_output,
            reset      => reset,
            edges_done => edges_done_internal,
            q_cnt_atm  => q_cnt_atm_internal
        );

    -- Instantiate Counter_Edges_ATM
    Counter_Edges_ATM_UUT: Counter_Edges_ATM
        port map (
            clk_s       => clk_s,
            reset       => reset,
            edges_done  => edges_done_internal,
            edge_count  => edge_count_internal
        );

    -- Instantiate Storing_ATM
    Storing_ATM_UUT: Storing_ATM
        port map (
            ro_output  => ro_output,
            reset      => reset,
            edges_done => edges_done_internal,
            q_cnt_atm  => q_cnt_atm_internal,
            q_str_atm  => q_str_atm_internal
        );

    -- Instantiate Comparator_ATM
    Comparator_ATM_UUT: Comparator_ATM
        port map (
            clk_s        => clk_s,
            reset        => reset,
            q_str_atm    => q_str_atm_internal,
            edges_done   => edges_done_internal,
            alarm        => alarm
        );

    -- Instantiate Alarm_Manage_ATM
    Alarm_Manage_ATM_UUT: Alarm_Manage_ATM
        port map (
            clk_s        => clk_s,
            reset        => reset,
            edges_done   => edges_done_internal,
            alarm        => alarm,
            Alarm_ATM    => Alarm_ATM
        );
end Behavioral;