library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Detector is
    Port (
        clk_s     : in  STD_LOGIC;                      -- Main clock
        Alarme    : out STD_LOGIC;                      -- Alarm output
        q_str_d     : out STD_LOGIC_VECTOR(6 downto 0);   -- Stored value output
        ro_output    : in  STD_LOGIC;                    -- Shared RO output
        x_moins_out : out STD_LOGIC_VECTOR(6 downto 0); -- Output for x_moins
        x_plus_out  : out STD_LOGIC_VECTOR(6 downto 0)   -- Output for x_plus
    );
end Detector;

architecture Behavioral of Detector is
    -- Internal signals
    signal q_cnt : STD_LOGIC_VECTOR(6 downto 0);
    signal q_fe  : STD_LOGIC;
    signal q_str_d_internal : STD_LOGIC_VECTOR(6 downto 0);
    signal x_moins_internal : STD_LOGIC_VECTOR(6 downto 0);
    signal x_plus_internal : STD_LOGIC_VECTOR(6 downto 0);

    -- Component declarations
    component Counter_Detector
        Port (
            clk_s    : in  STD_LOGIC;
            ro_output   : in  STD_LOGIC;
            q_cnt    : out STD_LOGIC_VECTOR(6 downto 0)
        );
    end component;

    component Falling_Edge_Detector
        Port (
            clk_s  : in  STD_LOGIC;
            ro_output : in  STD_LOGIC;
            q_fe   : out STD_LOGIC
        );
    end component;

    component Storing_Detector
        Port (
            ro_output   : in  STD_LOGIC;
            q_fe     : in  STD_LOGIC;
            q_cnt    : in  STD_LOGIC_VECTOR(6 downto 0);
            q_str_d    : out STD_LOGIC_VECTOR(6 downto 0)
        );
    end component;

    component Comparator_Detector
        Port (
            ro_output  : in STD_LOGIC;
            q_str_d   : in STD_LOGIC_VECTOR(6 downto 0);
            Alarme  : out STD_LOGIC;
            x_moins_out : out STD_LOGIC_VECTOR(6 downto 0); -- Output for x_moins
            x_plus_out  : out STD_LOGIC_VECTOR(6 downto 0)   -- Output for x_plus
        );
    end component;

begin

    -- Assign the internal signal to the top-level output
    q_str_d <= q_str_d_internal;
    x_moins_out <= x_moins_internal;
    x_plus_out <= x_plus_internal;

    -- Instantiate the Counter
    Counter_Detector_UUT: Counter_Detector
        port map (
            clk_s  => clk_s,
            ro_output => ro_output,
            q_cnt  => q_cnt
        );

    -- Instantiate the Falling Edge Detector
    Falling_Edge_Detector_UUT: Falling_Edge_Detector
        port map (
            clk_s  => clk_s,
            ro_output => ro_output,
            q_fe   => q_fe
        );

    -- Instantiate the Storing Module
    Storing_Detector_UUT: Storing_Detector
        port map (
            ro_output => ro_output,
            q_fe   => q_fe,
            q_cnt  => q_cnt,
            q_str_d  => q_str_d_internal
        );

    -- Instantiate the Comparator
    Comparator_Detector_UUT: Comparator_Detector
        port map (
            ro_output  => ro_output,
            q_str_d   => q_str_d_internal,
            Alarme  => Alarme,
            x_moins_out => x_moins_internal,
            x_plus_out  => x_plus_internal
        );

end Behavioral;