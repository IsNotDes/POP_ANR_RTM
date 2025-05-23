library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Detector is
    Port (
        clk_s     : in  STD_LOGIC;                      -- Main clock (enable/reset and falling edge detection)
        Alarme    : out STD_LOGIC;                      -- Alarm output
        q_str     : out STD_LOGIC_VECTOR(6 downto 0);   -- Stored value output
        ro_out    : out STD_LOGIC;
        enable_ro : in  STD_LOGIC
    );
end Detector;

architecture Behavioral of Detector is
    -- Internal signals for inter-component communication
    signal q_cnt_internal : STD_LOGIC_VECTOR(6 downto 0);  -- Counter output
    signal q_fe_internal  : STD_LOGIC;                      -- Falling edge detection output
    signal q_str_internal : STD_LOGIC_VECTOR(6 downto 0);  -- Storing output
    signal ro_out_internal : STD_LOGIC;

    -- Component declarations
    component Counter_D
        Port (
            clk_s    : in  STD_LOGIC;
            ro_out   : in  STD_LOGIC;
            q_cnt    : out STD_LOGIC_VECTOR(6 downto 0)
        );
    end component;

    component Falling_Edge_Detector_D
        Port (
            clk_s  : in  STD_LOGIC;
            ro_out : in  STD_LOGIC;
            q_fe   : out STD_LOGIC
        );
    end component;

    component Storing_D
        Port (
            ro_out   : in  STD_LOGIC;
            q_fe     : in  STD_LOGIC;
            q_cnt    : in  STD_LOGIC_VECTOR(6 downto 0);
            q_str    : out STD_LOGIC_VECTOR(6 downto 0)
        );
    end component;

    component Comparator_D
        Port (
            ro_out  : in STD_LOGIC;
            q_str   : in STD_LOGIC_VECTOR(6 downto 0);
            Alarme  : out STD_LOGIC
        );
    end component;

    component RO_D
        Port (
            enable_ro  : in  STD_LOGIC;
            ro_out  : out STD_LOGIC
        );
    end component;

begin

    -- Instantiate the Counter
    Counter_D_UUT: Counter_D
        port map (
            clk_s  => clk_s,
            ro_out => ro_out_internal,
            q_cnt  => q_cnt_internal
        );

    -- Instantiate the Falling_Edge Detector
    Falling_Edge_Detector_D_UUT: Falling_Edge_Detector_D
        port map (
            clk_s  => clk_s,
            ro_out => ro_out_internal,
            q_fe   => q_fe_internal
        );

    -- Instantiate the Storing Module
    Storing_D_UUT: Storing_D
        port map (
            ro_out => ro_out_internal,
            q_fe   => q_fe_internal,
            q_cnt  => q_cnt_internal,
            q_str  => q_str_internal
        );

    -- Instantiate the Comparator
    Comparator_D_UUT: Comparator_D
        port map (
            ro_out  => ro_out_internal,
            q_str   => q_str_internal,
            Alarme  => Alarme
        );

    -- Instantiate the RO
    RO_D_UUT: RO_D
        port map (
            enable_ro  => enable_ro,
            ro_out     => ro_out_internal
        );

    -- Output the stored value and RO output
    q_str <= q_str_internal;
    ro_out <= ro_out_internal; -- Assign internal RO signal to the top-level output port

end Behavioral;