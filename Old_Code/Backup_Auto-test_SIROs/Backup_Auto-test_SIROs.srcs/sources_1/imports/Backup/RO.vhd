library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VComponents.all;

entity RO is
    Generic (
        NUM_INVERTERS : integer := 7
    );
    Port (
        Enable  : in  STD_LOGIC;
        RO_OUT  : out STD_LOGIC
    );
end RO;

architecture Behavioral of RO is
    signal Inverters : std_logic_vector((NUM_INVERTERS-1) downto 0);
    signal Nand_out  : std_logic;
    
    -- Prevent optimization
    attribute KEEP       : string;
    attribute DONT_TOUCH : string;
    attribute S          : string;

    attribute KEEP of Inverters : signal is "TRUE";
    attribute KEEP of Nand_out  : signal is "TRUE";
    attribute DONT_TOUCH of Inverters : signal is "TRUE";
    attribute DONT_TOUCH of Nand_out  : signal is "TRUE";
    attribute S of Inverters : signal is "TRUE";
    attribute S of Nand_out  : signal is "TRUE";
begin
    -- NAND gate for enable control
    Nand_out <= Enable nand Inverters(NUM_INVERTERS-2); --(not Enable)
    
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
    gen_inverters: for i in 1 to (NUM_INVERTERS-1) generate
    begin
        Inverter : LUT1
            generic map (
                INIT => "01" -- Inverter logic
            )
            port map (
                O => Inverters(i),
                I0 => Inverters(i-1)
            );
    end generate gen_inverters;

    -- Output the last inverter's signal
    RO_OUT <= Inverters(NUM_INVERTERS-1);
end Behavioral;