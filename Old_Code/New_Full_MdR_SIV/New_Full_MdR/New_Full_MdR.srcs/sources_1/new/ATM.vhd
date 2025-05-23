library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ATM is
    Port (
        clk_s       : in  STD_LOGIC;                      -- Main clock signal
        reset       : in  STD_LOGIC;                      -- Global reset signal
        ro_output   : in  STD_LOGIC;                      -- Shared RO output
        Final_Alarm : out STD_LOGIC;                      -- Final alarm output
        q_str_atm   : out STD_LOGIC_VECTOR(7 downto 0);   -- Stored value output
        edge_count  : out STD_LOGIC_VECTOR(2 downto 0);   -- Edge count output
        edges_done  : out STD_LOGIC;                      -- Signal indicating counting is done
        y_moins_out : out STD_LOGIC_VECTOR(7 downto 0);   -- Output for y_moins
        y_plus_out  : out STD_LOGIC_VECTOR(7 downto 0)    -- Output for y_plus
    );
end ATM;

architecture Behavioral of ATM is
    -- Internal signals for inter-component communication
    signal q_cnt_atm_internal  : STD_LOGIC_VECTOR(7 downto 0); -- Live counter value
    signal q_str_atm_internal  : STD_LOGIC_VECTOR(7 downto 0); -- Live counter value
    signal edges_done_internal : STD_LOGIC;                   -- Signal indicating counting is done
    signal alarm               : STD_LOGIC;                   -- Alarm signal from Comparator_ATM
    signal edge_count_internal : STD_LOGIC_VECTOR(2 downto 0);
    signal y_moins_internal    : STD_LOGIC_VECTOR(7 downto 0); -- Internal signal for y_moins
    signal y_plus_internal     : STD_LOGIC_VECTOR(7 downto 0); -- Internal signal for y_plus

    -- Component declarations
    component Counter_ATM
        Port (
            ro_output    : in  STD_LOGIC;
            reset        : in  STD_LOGIC;
            edges_done   : in  STD_LOGIC;
            q_cnt_atm    : out STD_LOGIC_VECTOR(7 downto 0)
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
            ro_output    : in  STD_LOGIC;
            q_str_atm    : in  STD_LOGIC_VECTOR(7 downto 0);
            edges_done   : in  STD_LOGIC;
            alarm        : out STD_LOGIC;
            y_moins_out  : out STD_LOGIC_VECTOR(7 downto 0);
            y_plus_out   : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    component Alarm_Manage_ATM
        Port (
            clk_s        : in  STD_LOGIC;
            reset        : in  STD_LOGIC;
            edges_done   : in  STD_LOGIC;
            alarm        : in  STD_LOGIC;
            Final_Alarm  : out STD_LOGIC
        );
    end component;

    component Storing_ATM
        Port (
            ro_output   : in  STD_LOGIC;
            reset       : in  STD_LOGIC;
            edges_done  : in  STD_LOGIC;
            q_cnt_atm   : in  STD_LOGIC_VECTOR(7 downto 0);
            q_str_atm   : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

begin
    -- Assign internal signals to top-level outputs
    q_str_atm <= q_str_atm_internal;
    edge_count <= edge_count_internal;
    edges_done <= edges_done_internal;
    y_moins_out <= y_moins_internal;
    y_plus_out <= y_plus_internal;

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
            ro_output   => ro_output,
            reset       => reset,
            edges_done  => edges_done_internal,
            q_cnt_atm   => q_cnt_atm_internal,
            q_str_atm   => q_str_atm_internal
        );

    -- Instantiate Comparator_ATM
    Comparator_ATM_UUT: Comparator_ATM
        port map (
            ro_output    => ro_output,
            q_str_atm    => q_str_atm_internal,
            edges_done   => edges_done_internal,
            alarm        => alarm,
            y_moins_out  => y_moins_internal,
            y_plus_out   => y_plus_internal
        );

    -- Instantiate Alarm_Manage_ATM
    Alarm_Manage_ATM_UUT: Alarm_Manage_ATM
        port map (
            clk_s        => clk_s,
            reset        => reset,
            edges_done   => edges_done_internal,
            alarm        => alarm,
            Final_Alarm  => Final_Alarm
        );
end Behavioral;