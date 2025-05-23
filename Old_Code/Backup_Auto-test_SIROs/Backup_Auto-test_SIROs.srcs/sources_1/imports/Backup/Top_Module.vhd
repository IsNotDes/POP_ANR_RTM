library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Top_Module is
    generic(
        SIRO_number : integer := 8000;  -- Number of SIROs
        RO_number   : integer := 1   -- Number of ROs
    );
    port(
        Enable             : in  STD_LOGIC;   -- From XDC (RO.vhd)
        RO_OUT             : out STD_LOGIC_VECTOR(RO_number-1 downto 0);  -- Outputs from ROs
        EnableROattack     : in  STD_LOGIC;   -- From XDC (ROattacks.vhd)
        ROattack_dummy_out : out STD_LOGIC    -- Forces routing
    );
end Top_Module;

architecture Behavioral of Top_Module is
    signal activate_SIRO : STD_LOGIC := '0';

    -- Prevent optimization
    attribute KEEP        : string;
    attribute DONT_TOUCH  : string;
    attribute S           : string;
    attribute KEEP_HIERARCHY : string;
    attribute MAX_FANOUT  : string;

    attribute KEEP of activate_SIRO : signal is "true"; 
    attribute DONT_TOUCH of activate_SIRO : signal is "true"; 
    attribute S of activate_SIRO : signal is "true"; 
    attribute KEEP_HIERARCHY of activate_SIRO : signal is "true"; 
    attribute MAX_FANOUT of activate_SIRO : signal is "1"; 

    -- Component declarations
    component RO
        Port (
            Enable  : in  STD_LOGIC;
            RO_OUT  : out STD_LOGIC
        );
    end component;

    component ROattacks
        Port (
            EnableROattack : in  STD_LOGIC
        );
    end component;

begin
    -- Activate all ROattacks instances
    activate_SIRO <= EnableROattack;

    -- Generate RO instances
    GENERATE_RO: for i in 0 to RO_number-1 generate
    begin
        UUT_RO : RO
            port map (
                Enable  => Enable,
                RO_OUT  => RO_OUT(i)
            );
    end generate GENERATE_RO;

    -- Generate SIRO_number ROattacks (for power/EM analysis)
    GENERATE_SIRO: for i in 0 to SIRO_number-1 generate    
    begin
        UUT_SIRO : ROattacks
            port map (
                EnableROattack => activate_SIRO
            );
    end generate GENERATE_SIRO;

    -- Force Vivado to keep the instance by driving an output
    ROattack_dummy_out <= activate_SIRO;

end Behavioral;