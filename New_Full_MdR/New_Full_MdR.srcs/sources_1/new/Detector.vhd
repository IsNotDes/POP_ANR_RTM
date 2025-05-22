library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Detector is
    Port (
        clk_s          : in  STD_LOGIC;                       -- Main clock
        reset          : in  STD_LOGIC;                       -- Active-low reset
        ro_output      : in  STD_LOGIC;                       -- Shared RO output
        Alarm_Detector : out STD_LOGIC;                       -- Alarm output
        q_str_d        : out STD_LOGIC_VECTOR(7 downto 0)     -- Stored value output
    );
end Detector;

architecture Behavioral of Detector is
    -- Internal signals
    signal q_cnt             : STD_LOGIC_VECTOR(7 downto 0);
    signal q_fe              : STD_LOGIC;
    signal q_str_d_internal  : STD_LOGIC_VECTOR(7 downto 0);

    -- Component declarations
    component Counter_Detector
        Port (
            clk_s     : in  STD_LOGIC;
            reset     : in  STD_LOGIC;
            ro_output : in  STD_LOGIC;
            q_cnt     : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    component Falling_Edge_Detector
        Port (
            clk_s     : in  STD_LOGIC;
            reset     : in  STD_LOGIC;
            ro_output : in  STD_LOGIC;
            q_fe      : out STD_LOGIC
        );
    end component;

    component Storing_Detector
        Port (
            ro_output : in  STD_LOGIC;
            reset     : in  STD_LOGIC;
            q_fe      : in  STD_LOGIC;
            q_cnt     : in  STD_LOGIC_VECTOR(7 downto 0);
            q_str_d   : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    component Comparator_Detector
        Port (
            clk_s        : in  STD_LOGIC;
            reset        : in  STD_LOGIC;
            q_str_d      : in  STD_LOGIC_VECTOR(7 downto 0);
            Alarm_Detector : out STD_LOGIC
        );
    end component;

begin
    -- Assign the internal signal to the top-level output
    q_str_d     <= q_str_d_internal;

    -- Instantiate the Counter
    Counter_Detector_UUT: Counter_Detector
        port map (
            clk_s     => clk_s,
            reset     => reset,
            ro_output => ro_output,
            q_cnt     => q_cnt
        );

    -- Instantiate the Falling Edge Detector
    Falling_Edge_Detector_UUT: Falling_Edge_Detector
        port map (
            clk_s     => clk_s,
            reset     => reset,
            ro_output => ro_output,
            q_fe      => q_fe
        );

    -- Instantiate the Storing Module
    Storing_Detector_UUT: Storing_Detector
        port map (
            ro_output => ro_output,
            reset     => reset,
            q_fe      => q_fe,
            q_cnt     => q_cnt,
            q_str_d   => q_str_d_internal
        );

    -- Instantiate the Comparator
    Comparator_Detector_UUT: Comparator_Detector
        port map (
            clk_s          => clk_s,
            reset          => reset,
            q_str_d        => q_str_d_internal,
            Alarm_Detector => Alarm_Detector
        );
end Behavioral;