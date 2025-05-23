library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Auto_Test_Module is
    Port (
        clk_s       : in  STD_LOGIC;                      -- Main clock
        reset       : in  STD_LOGIC;                      -- External reset signal
        enable_ro   : in  STD_LOGIC;                      -- Enable signal for the Ring Oscillator
        Final_Alarm : out STD_LOGIC;                      -- Alarm output
        q_cnt       : out STD_LOGIC_VECTOR(6 downto 0);   -- Stored value output (modified to 6 downto 0)
        q_str       : out STD_LOGIC_VECTOR(6 downto 0);
        edge_count  : out STD_LOGIC_VECTOR(2 downto 0);   -- Number of edges detected on clk_s
        edges_done  : out STD_LOGIC                      -- Signal indicating counting is done
    );
end Auto_Test_Module;

architecture Behavioral of Auto_Test_Module is
    -- Internal signals for inter-component communication
    signal clk_ro_internal : STD_LOGIC;                   -- Internal RO signal
    signal q_cnt_internal  : STD_LOGIC_VECTOR(6 downto 0); -- Counter output (modified to 6 downto 0)
    signal q_str_internal  : STD_LOGIC_VECTOR(6 downto 0); -- Stored value output (modified to 6 downto 0)
    signal edges_done_internal : STD_LOGIC := '0';        -- Signal indicating counting is done
    signal True_Alarm      : STD_LOGIC := '0';            -- Alarm signal from Comparator_ATM
    signal internal_reset  : STD_LOGIC := '0';            -- Internal reset signal
    signal edge_count_internal : STD_LOGIC_VECTOR(2 downto 0);

    -- Component declarations (unchanged)
    component RO
        Port (
            enable_ro  : in  STD_LOGIC;
            ro_out     : out STD_LOGIC
        );
    end component;

    component Counter_ATM
        Port (
            clk_s     : in  STD_LOGIC;
            ro_out    : in  STD_LOGIC;
            reset     : in  STD_LOGIC;
            q_cnt     : out STD_LOGIC_VECTOR(6 downto 0)   -- Modified to 6 downto 0
        );
    end component;

    component Counting_Edges_ATM
        Port (
            clk_s       : in  STD_LOGIC;
            reset       : in  STD_LOGIC;
            edges_done  : out STD_LOGIC;
            edge_count  : out STD_LOGIC_VECTOR(2 downto 0)
        );
    end component;

    component Comparator_ATM
        Port (
            ro_out     : in  STD_LOGIC;                      -- Clock signal for synchronization
            q_str      : in  STD_LOGIC_VECTOR(6 downto 0);   -- Modified to 6 downto 0
            edge_count : in  STD_LOGIC_VECTOR(2 downto 0);
            True_Alarm : out STD_LOGIC
        );
    end component;

    component Alarm_Manage_ATM
        Port (
            clk_s         : in  STD_LOGIC;
            reset         : in  STD_LOGIC;
            edges_done    : in  STD_LOGIC;
            True_Alarm    : in  STD_LOGIC;
            Final_Alarm   : out STD_LOGIC
        );
    end component;

begin
    -- Instantiate the Ring Oscillator (RO_ATM)
    RO_UUT: RO
        port map (
            enable_ro => enable_ro,
            ro_out    => clk_ro_internal
        );

    -- Instantiate the Counter_ATM
    Counter_ATM_UUT: Counter_ATM
        port map (
            clk_s   => clk_s,
            ro_out  => clk_ro_internal,
            reset   => internal_reset,
            q_cnt   => q_cnt_internal
        );

    -- Instantiate the Counting_Edges_ATM
    Counting_Edges_ATM_UUT: Counting_Edges_ATM
        port map (
            clk_s       => clk_s,
            reset       => internal_reset,
            edges_done  => edges_done_internal,
            edge_count  => edge_count_internal
        );

    -- Instantiate the Comparator_ATM
    Comparator_ATM_UUT: Comparator_ATM
        port map (
            ro_out     => clk_ro_internal,
            q_str      => q_str_internal,  -- Use q_str_internal here
            edge_count => edge_count_internal,
            True_Alarm => True_Alarm
        );

    -- Instantiate the Alarm_Manage_ATM
    Alarm_Manage_ATM_UUT: Alarm_Manage_ATM
        port map (
            clk_s         => clk_s,
            reset         => internal_reset,
            edges_done    => edges_done_internal,
            True_Alarm    => True_Alarm,
            Final_Alarm   => Final_Alarm
        );

    -- Assign q_str_internal to q_cnt_internal
    q_str_internal <= q_cnt_internal;

    -- Output assignments
    q_str <= q_str_internal;
    q_cnt <= q_cnt_internal;
    edge_count <= "101" when edges_done_internal = '1' else edge_count_internal;
    edges_done <= edges_done_internal;

end Behavioral;