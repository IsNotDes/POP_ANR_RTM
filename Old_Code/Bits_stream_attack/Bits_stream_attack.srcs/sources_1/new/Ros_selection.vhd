library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
library UNISIM;
use UNISIM.VComponents.all;
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-----------------------------------------------------------------------------------------
entity Ros_selection is
  Port ( 
  challenge : in std_logic_vector(2 downto 0) ;
  Output    : out std_logic ;
  Enable    : in std_logic
  );
end Ros_selection;
-----------------------------------------------------------------------------------------
architecture Behavioral of Ros_selection is
 
-----------------------------------------------------------------------------------------    
 component ROs
    Port ( Enable : in std_logic;
           RO_OUT : out std_logic);
    end component;
 -----------------------------------------------------------------------------------------
    
signal Sortie_RO : std_logic_vector(7 downto 0) ;  
    
begin
-----------------------------------------------------------------------------------------
Inverseur: for i in 0 to 7 generate
    ringoscillator : ROs
        port map (
              Enable => Enable, -- 1-bit output: LUT
              RO_OUT => Sortie_RO(i) -- 1-bit input: LUT
                );
end generate Inverseur;
-----------------------------------------------------------------------------------------
process(challenge,Sortie_RO)
    variable found_match : boolean := false;
begin
    for i in 0 to 7 loop
        if challenge = std_logic_vector(to_unsigned(i, 3)) then
            Output <= Sortie_RO(i);
            found_match := true;
            exit; 
        end if;
    end loop;
    if not found_match then
        Output <= '0';  
    end if;
end process;







end Behavioral;
