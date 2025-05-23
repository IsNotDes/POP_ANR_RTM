library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ATM is
    Port (
        clk_s       : in  STD_LOGIC;                      -- Main clock signal
        reset       : in  STD_LOGIC;                      -- Global reset signal
        ro_output   : in  STD_LOGIC;                      -- Shared RO output
        Final_Alarm : out STD_LOGIC;                      -- Final alarm output
        q_cnt       : out STD_LOGIC_VECTOR(6 downto 0);   -- Stored value output (modified to 6 downto 0)
        edge_count  : out STD_LOGIC_VECTOR(2 downto 0);   -- Edge count output
        edges_done  : out STD_LOGIC;                      -- Signal indicating counting is done
        y_moins_out : out STD_LOGIC_VECTOR(6 downto 0);   -- Output for y_moins
        y_plus_out  : out STD_LOGIC_VECTOR(6 downto 0)    -- Output for y_plus
    );
end ATM;

architecture Behavioral of ATM is
    -- Internal signals for inter-component communication
    signal q_cnt_internal  : STD_LOGIC_VECTOR(6 downto 0); -- Counter output (modified to 6 downto 0)
    signal edges_done_internal : STD_LOGIC;        -- Signal indicating counting is done
    signal alarm      : STD_LOGIC;            -- Alarm signal from Comparator_ATM
    signal edge_count_internal : STD_LOGIC_VECTOR(2 downto 0);
    signal y_moins_internal : STD_LOGIC_VECTOR(6 downto 0); -- Internal signal for y_moins
    signal y_plus_internal  : STD_LOGIC_VECTOR(6 downto 0); -- Internal signal for y_plus

    component Counter_ATM
        Port (
            ro_output    : in  STD_LOGIC;
            reset     : in  STD_LOGIC;
            edges_done : in STD_LOGIC;
            q_cnt     : out STD_LOGIC_VECTOR(6 downto 0)   -- Counter output
        );
    end component;

    component Counter_Edges_ATM
        Port (
            clk_s       : in  STD_LOGIC;
            reset       : in  STD_LOGIC;
            edges_done  : out STD_LOGIC;
            edge_count  : out STD_LOGIC_VECTOR(2 downto 0)
        );
    end component;

    component Comparator_ATM
        Port (
            ro_output     : in  STD_LOGIC;                      -- Clock signal for synchronization
            q_cnt      : in  STD_LOGIC_VECTOR(6 downto 0);   -- Input count value
            edges_done : in  STD_LOGIC;   -- End of counting edges signal
            alarm     : out STD_LOGIC;                      -- Alarm signal
            y_moins_out : out STD_LOGIC_VECTOR(6 downto 0);  -- Output for y_moins
            y_plus_out  : out STD_LOGIC_VECTOR(6 downto 0)   -- Output for y_plus
        );
    end component;

    component Alarm_Manage_ATM
        Port (
            clk_s         : in  STD_LOGIC;
            reset         : in  STD_LOGIC;
            edges_done    : in  STD_LOGIC;
            alarm    : in  STD_LOGIC;
            Final_Alarm   : out STD_LOGIC
        );
    end component;

begin

    -- Assign the internal signal to the top-level output
    q_cnt <= q_cnt_internal;
    edge_count <= edge_count_internal;
    edges_done <= edges_done_internal;
    y_moins_out <= y_moins_internal;
    y_plus_out <= y_plus_internal;
    
    -- Instantiate the Counter_ATM
    Counter_ATM_UUT: Counter_ATM
        port map (
            ro_output  => ro_output,
            reset   => reset,
            edges_done => edges_done_internal,
            q_cnt   => q_cnt_internal
        );

    -- Instantiate the Counting_Edges_ATM
    Counter_Edges_ATM_UUT: Counter_Edges_ATM
        port map (
            clk_s       => clk_s,
            reset       => reset,
            edges_done  => edges_done_internal,
            edge_count  => edge_count_internal
        );

    -- Instantiate the Comparator_ATM
    Comparator_ATM_UUT: Comparator_ATM
        port map (
            ro_output     => ro_output,
            q_cnt      => q_cnt_internal,
            edges_done  => edges_done_internal,
            alarm => alarm,
            y_moins_out => y_moins_internal,
            y_plus_out => y_plus_internal
        );

    -- Instantiate the Alarm_Manage_ATM
    Alarm_Manage_ATM_UUT: Alarm_Manage_ATM
        port map (
            clk_s         => clk_s,
            reset         => reset,
            edges_done    => edges_done_internal,
            alarm    => alarm,
            Final_Alarm   => Final_Alarm
        );
        
end Behavioral;