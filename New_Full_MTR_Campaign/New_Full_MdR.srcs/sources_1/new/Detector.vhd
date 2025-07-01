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
    signal q_cnt             : STD_LOGIC_VECTOR(7 downto 0);    -- Live counter value
    signal q_fe              : STD_LOGIC;                       -- Falling edge signal
    signal q_str_d_internal  : STD_LOGIC_VECTOR(7 downto 0);    -- Stored value

    -- Component declarations
    component Counter_Detector
        Port (
            clk_s     : in  STD_LOGIC;                           -- Main clock
            reset     : in  STD_LOGIC;                           -- Active-low reset
            ro_output : in  STD_LOGIC;                           -- Shared RO output
            q_cnt     : out STD_LOGIC_VECTOR(7 downto 0)         -- Live counter value
        );
    end component;

    component Falling_Edge_Detector
        Port (
            clk_s     : in  STD_LOGIC;                           -- Main clock
            reset     : in  STD_LOGIC;                           -- Active-low reset
            ro_output : in  STD_LOGIC;                           -- Shared RO output
            q_fe      : out STD_LOGIC                            -- Falling edge signal
        );
    end component;

    component Storing_Detector
        Port (
            ro_output : in  STD_LOGIC;                           -- Shared RO output
            reset     : in  STD_LOGIC;                           -- Active-low reset
            q_fe      : in  STD_LOGIC;                           -- Falling edge signal
            q_cnt     : in  STD_LOGIC_VECTOR(7 downto 0);        -- Live counter value
            q_str_d   : out STD_LOGIC_VECTOR(7 downto 0)         -- Stored value
        );
    end component;

    component Comparator_Detector
        Port (
            clk_s        : in  STD_LOGIC;                           -- Main clock
            reset        : in  STD_LOGIC;                           -- Active-low reset
            q_str_d      : in  STD_LOGIC_VECTOR(7 downto 0);        -- Stored value
            Alarm_Detector : out STD_LOGIC                          -- Alarm output
        );
    end component;

begin
    -- Assign the internal signal to the top-level output
    q_str_d     <= q_str_d_internal;

    -- Instantiate the Counter
    Counter_Detector_UUT: Counter_Detector
        port map (
            clk_s     => clk_s,                               -- Main clock
            reset     => reset,                               -- Active-low reset
            ro_output => ro_output,                           -- Shared RO output
            q_cnt     => q_cnt                                -- Live counter value
        );

    -- Instantiate the Falling Edge Detector
    Falling_Edge_Detector_UUT: Falling_Edge_Detector
        port map (
            clk_s     => clk_s,                               -- Main clock
            reset     => reset,                               -- Active-low reset
            ro_output => ro_output,                           -- Shared RO output
            q_fe      => q_fe                                 -- Falling edge signal
        );

    -- Instantiate the Storing Module
    Storing_Detector_UUT: Storing_Detector
        port map (
            ro_output => ro_output,                           -- Shared RO output
            reset     => reset,                               -- Active-low reset
            q_fe      => q_fe,                                -- Falling edge signal
            q_cnt     => q_cnt,                               -- Live counter value
            q_str_d   => q_str_d_internal                     -- Stored value
        );

    -- Instantiate the Comparator
    Comparator_Detector_UUT: Comparator_Detector
        port map (
            clk_s          => clk_s,                           -- Main clock
            reset          => reset,                           -- Active-low reset
            q_str_d        => q_str_d_internal,                -- Stored value
            Alarm_Detector => Alarm_Detector                   -- Alarm output
        );
end Behavioral;