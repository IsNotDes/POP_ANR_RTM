library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MdR_TB is
end MdR_TB;

architecture Behavioral of MdR_TB is

    -- Component declaration for the Unit Under Test (UUT)
    component MdR
        Port (
            clk_s       : in  STD_LOGIC;                      -- Main clock signal
            enable_ro   : in  STD_LOGIC;                      -- Enable signal for the shared RO
            enable_siro : in  STD_LOGIC;                      -- SIRO enable signal (not used in this design)
            ro_out      : out STD_LOGIC;                      -- Shared RO output
            Alarme      : out STD_LOGIC;                      -- Alarm output from Detector
            q_str       : out STD_LOGIC_VECTOR(6 downto 0)    -- Stored value from Detector
        );
    end component;

    -- Testbench signals
    signal clk_s     : STD_LOGIC := '0';
    signal enable_ro : STD_LOGIC := '0';
    signal enable_siro : STD_LOGIC := '0';
    signal ro_out    : STD_LOGIC;
    signal Alarme    : STD_LOGIC;
    signal q_str     : STD_LOGIC_VECTOR(6 downto 0);

    -- Clock period definition
    constant CLK_S_PERIOD : time := 0.7 us;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: MdR
        port map (
            clk_s     => clk_s,
            enable_ro => enable_ro,
            enable_siro => enable_siro,
            ro_out => ro_out,
            Alarme    => Alarme,
            q_str     => q_str
        );

    clk_s <= not clk_s after CLK_S_PERIOD / 2;

    process
    begin
        enable_ro <= '0';
        enable_siro <= '0';
        wait for 150 ns;
        enable_ro <= '1';
        wait for 20 ns;
        enable_siro <= '1';
        wait;
    end process;

end Behavioral;