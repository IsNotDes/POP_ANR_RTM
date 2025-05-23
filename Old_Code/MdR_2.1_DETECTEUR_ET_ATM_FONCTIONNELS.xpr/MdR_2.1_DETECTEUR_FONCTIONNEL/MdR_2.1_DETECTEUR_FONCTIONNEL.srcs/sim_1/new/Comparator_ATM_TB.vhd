library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Comparator_ATM_TB is
end Comparator_ATM_TB;

architecture Behavioral of Comparator_ATM_TB is
    signal ro_out  : STD_LOGIC := '0';
    signal q_str   : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');   -- Updated to 7 downto 0
    signal Alarme  : STD_LOGIC;

    constant clk_period : time := 10 ns; -- 100 MHz clock

    -- Component declaration
    component Comparator_ATM
        Port (
            ro_out   : in  STD_LOGIC;
            q_str    : in  STD_LOGIC_VECTOR(7 downto 0);   -- Updated to 7 downto 0
            Alarme   : out STD_LOGIC
        );
    end component;

begin
    -- Instantiate the Unit Under Test (UUT)
    UUT: Comparator_ATM
        port map (
            ro_out   => ro_out,
            q_str    => q_str,
            Alarme   => Alarme
        );

    -- Stimulus process
    stim_proc: process
    begin
        ro_out <= '0';  -- Initial state
        q_str <= "00000000";  -- Initial value
        wait for 20 ns;

        ro_out <= '1';  -- Rising edge on ro_out
        q_str <= "00001100";  -- Set a value within range
        wait for 10 ns;

        ro_out <= '0';  -- Falling edge on ro_out
        wait for 10 ns;

        ro_out <= '1';  -- Rising edge on ro_out
        q_str <= "11110000";  -- Set a value outside range
        wait for 10 ns;

        ro_out <= '0';  -- Falling edge on ro_out
        wait for 50 ns;

        wait;
    end process;
end Behavioral;