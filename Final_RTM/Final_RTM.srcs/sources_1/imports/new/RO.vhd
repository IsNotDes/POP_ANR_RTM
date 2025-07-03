library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library UNISIM;
use UNISIM.VComponents.all;

entity RO is
    Port (
        enable_ro_and_siro : in  std_logic;   -- Combined enable signal for both RO and SIRO
        ro_out    : out std_logic              -- Output from RO
    );
end RO;

architecture Behavioral of RO is
    constant NUM_INV : integer := 301;  -- Number of inverters
    signal Inverters : std_logic_vector(NUM_INV-1 downto 0);  -- Inverter signals
    signal Nand_out  : std_logic;  -- Nand_out is the output of the last inverter

    attribute DONT_TOUCH : string;
    attribute DONT_TOUCH of Inverters : signal is "true";
    attribute DONT_TOUCH of Nand_out  : signal is "true";
begin
    Nand_out <= enable_ro_and_siro nand Inverters(NUM_INV-2);  -- Nand_out is the output of the last inverter

    Inverter0 : LUT1
        generic map (
            INIT => "01"
        )
        port map (
            O  => Inverters(0),
            I0 => Nand_out
        );

    Inverseur : for i in 1 to NUM_INV-1 generate
        InverterN : LUT1
            generic map (
                INIT => "01"
            )
            port map (
                O  => Inverters(i),
                I0 => Inverters(i-1)
            );
    end generate Inverseur;

    ro_out <= Inverters(NUM_INV-1);  -- ro_out is the output of the last inverter
end Behavioral;
