library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VComponents.all;

entity RO is
    Port (
        enable_ro  : in  STD_LOGIC;
        ro_out  : out STD_LOGIC
    );
end RO;

architecture Behavioral of RO is
    constant num_inverters : INTEGER := 11;
    signal Inverters : std_logic_vector((num_inverters-1) downto 0);
    signal Nand_out  : std_logic;
    
    -- Declare attributes
    --attribute S : string;
    --attribute KEEP : string;
    attribute DONT_TOUCH : string;
    
    --attribute S of Inverters : signal is "TRUE";
    --attribute KEEP of Inverters : signal is "TRUE";
    attribute DONT_TOUCH of Inverters : signal is "TRUE";
    --attribute S of Nand_out : signal is "TRUE";
    --attribute KEEP of Nand_out : signal is "TRUE";
    attribute DONT_TOUCH of Nand_out : signal is "TRUE";
    
begin
    -- NAND gate for enable control
    Nand_out <= enable_ro nand Inverters(num_inverters-2); --(not Enable)
    
    -- First inverter
    Inverter1 : LUT1
        generic map (
            INIT => "01" -- Inverter logic
        )
        port map (
            O => Inverters(0),
            I0 => Nand_out
        );

    -- Generate remaining inverters
    gen_inverters: for i in 1 to (num_inverters-1) generate
    begin
        Inverter1 : LUT1
            generic map (
                INIT => "01" -- Inverter logic
            )
            port map (
                O => Inverters(i),
                I0 => Inverters(i-1)
            );
    end generate gen_inverters;

    -- Output the last inverter's signal
    ro_out <= Inverters(num_inverters-1);
end Behavioral;