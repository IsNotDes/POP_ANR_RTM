library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Auto_Test_Module is
    Port (
        clk_ro      : in  STD_LOGIC;                      -- RO signal (for counting edges)
        clk_s       : in  STD_LOGIC;                      -- Main clock (enable/reset and falling edge detection)
        X_plus      : in  STD_LOGIC_VECTOR(7 downto 0);   -- Upper threshold for comparison
        X_moins     : in  STD_LOGIC_VECTOR(7 downto 0);   -- Lower threshold for comparison
        N           : in  STD_LOGIC_VECTOR(7 downto 0);   -- Threshold for edge_count
        Alarme      : out STD_LOGIC;                     -- Alarm output
        q_str       : out STD_LOGIC_VECTOR(7 downto 0);   -- Stored value output
        edge_count  : out STD_LOGIC_VECTOR(7 downto 0)    -- Number of edges detected on clk_s
    );
end Auto_Test_Module;

architecture Behavioral of Auto_Test_Module is
    -- Internal signals for inter-component communication
    signal q_cnt_internal : STD_LOGIC_VECTOR(7 downto 0);  -- Counter output
    signal q_fe_internal  : STD_LOGIC := '0';             -- Falling edge detection output (initialized to '0')
    signal q_str_internal : STD_LOGIC_VECTOR(7 downto 0); -- Storing output from Storing_ATM
    signal q_cnt_finale   : STD_LOGIC_VECTOR(7 downto 0); -- Accumulated counter value from CountEdges
    signal edge_count_reg : STD_LOGIC_VECTOR(7 downto 0); -- Edge count register

    -- Component declarations
    component Counter_ATM
        Port (
            clk_s     : in  STD_LOGIC;
            clk_ro    : in  STD_LOGIC;
            q_cnt     : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    component Falling_Edge_Detector_ATM
        Port (
            clk_ro : in  STD_LOGIC;
            clk_s  : in  STD_LOGIC;
            q_fe   : out STD_LOGIC
        );
    end component;

    component Storing_ATM
        Port (
            clk_ro    : in  STD_LOGIC;
            q_fe      : in  STD_LOGIC;
            q_cnt     : in  STD_LOGIC_VECTOR(7 downto 0);
            q_str     : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    component CountEdges
        Port (
            clk_s         : in  STD_LOGIC;                      -- Clock signal
            q_cnt_input   : in  STD_LOGIC_VECTOR(7 downto 0);   -- Input from Counter_ATM (q_cnt)
            q_cnt_finale  : out STD_LOGIC_VECTOR(7 downto 0);   -- Accumulated counter value
            edge_count    : out STD_LOGIC_VECTOR(7 downto 0)    -- Number of edges detected on clk_s
        );
    end component;

    component Comparator_ATM
        Port (
            clk_ro     : in  STD_LOGIC;                      -- Clock signal for synchronization
            q_str      : in  STD_LOGIC_VECTOR(7 downto 0);   -- Input value to compare
            edge_count : in  STD_LOGIC_VECTOR(7 downto 0);   -- Number of edges detected
            Alarme     : out STD_LOGIC;                     -- Alarm output
            X_plus     : in  STD_LOGIC_VECTOR(7 downto 0);   -- Upper threshold
            X_moins    : in  STD_LOGIC_VECTOR(7 downto 0);   -- Lower threshold
            N          : in  STD_LOGIC_VECTOR(7 downto 0)    -- Threshold for edge_count
        );
    end component;
begin
    -- Instantiate the Counter
    Counter_ATM_UUT: Counter_ATM
        port map (
            clk_s => clk_s,
            clk_ro => clk_ro,
            q_cnt => q_cnt_internal
        );

    -- Instantiate the Falling Edge Detector
    Falling_Edge_Detector_ATM_UUT: Falling_Edge_Detector_ATM
        port map (
            clk_ro => clk_ro,
            clk_s  => clk_s,
            q_fe   => q_fe_internal
        );

    -- Instantiate the Storing Module
    Storing_ATM_UUT: Storing_ATM
        port map (
            clk_ro => clk_ro,
            q_fe   => q_fe_internal,
            q_cnt  => q_cnt_internal,  -- Pass the full 8-bit counter value
            q_str  => q_str_internal   -- Output stored value
        );

    -- Instantiate the CountEdges Module
    CountEdges_UUT: CountEdges
        port map (
            clk_s         => clk_s,
            q_cnt_input   => q_cnt_internal,  -- Pass the full 8-bit counter value
            q_cnt_finale  => q_cnt_finale,    -- Accumulated counter value
            edge_count    => edge_count_reg   -- Edge count output
        );

    -- Instantiate the Comparator
    Comparator_ATM_UUT: Comparator_ATM
        port map (
            clk_ro     => clk_ro,
            q_str      => q_str_internal,     -- Use the stored value from Storing_ATM
            edge_count => edge_count_reg,     -- Pass the edge count to the comparator
            Alarme     => Alarme,             -- Alarm output
            X_plus     => X_plus,             -- Upper threshold
            X_moins    => X_moins,            -- Lower threshold
            N          => N                   -- Threshold for edge_count
        );

    -- Output the stored value and edge count
    q_str <= q_str_internal;
    edge_count <= edge_count_reg;

    -- Optional: Add a reset mechanism if needed
    -- For example, you can tie rst_internal to an external reset signal or trigger it internally.
end Behavioral;