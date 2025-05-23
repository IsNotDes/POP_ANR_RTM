library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library UNISIM;
use UNISIM.VComponents.all;

entity Lut6_groupe2 is
  Port (
O6 :  out std_logic; -- Sortie
O5 :  out std_logic ; -- Sortie
lut_entre : in std_logic_vector( 5 downto 0)
  );
end Lut6_groupe2;

architecture Behavioral of Lut6_groupe2 is

begin

LUT6_2_inst : LUT6_2
generic map (
   INIT => "1111111111111111111111111111111111111111111111111111111111111111") -- Specify LUT Contents
port map (
   O6 => O6,  -- 6/5-LUT output (1-bit)
   O5 => O5,  -- 5-LUT output (1-bit)
   I0 => lut_entre(0),   -- LUT input (1-bit)
   I1 => lut_entre(1),   -- LUT input (1-bit)
   I2 => lut_entre(2),   -- LUT input (1-bit)
   I3 => lut_entre(3),   -- LUT input (1-bit)
   I4 => lut_entre(4),   -- LUT input (1-bit)
   I5 => lut_entre(5)   -- LUT input (1-bit)
);
end Behavioral;
