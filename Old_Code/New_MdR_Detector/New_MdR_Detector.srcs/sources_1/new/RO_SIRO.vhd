library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RO_SIRO is
    port(
        enable_ro             : in  STD_LOGIC;   -- From XDC (RO.vhd)
        ro_out             : out STD_LOGIC;  -- Outputs from ROs
        enable_siro     : in  STD_LOGIC   -- From XDC (ROattacks.vhd)
        -- siro_dummy_out : out STD_LOGIC    -- Forces routing
    );
end RO_SIRO;

architecture Behavioral of RO_SIRO is
    signal activate_SIRO : STD_LOGIC;
    constant SIRO_number : integer := 5;  -- Number of SIROs

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
            enable_ro  : in  STD_LOGIC;
            ro_out  : out STD_LOGIC
        );
    end component;

    component SIRO
        Port (
            enable_siro : in  STD_LOGIC
        );
    end component;

begin
    -- Activate all ROattacks instances
    activate_SIRO <= enable_siro;

    UUT_RO : RO
        port map (
            enable_ro  => enable_ro,
            ro_out  => ro_out
        );

    -- Generate SIRO_number ROattacks (for power/EM analysis)
    GENERATE_SIRO: for i in 0 to SIRO_number-1 generate    
    begin
        UUT_SIRO : SIRO
            port map (
                enable_siro => activate_SIRO
            );
    end generate GENERATE_SIRO;

    -- Force Vivado to keep the instance by driving an output
    -- siro_dummy_out <= activate_SIRO;

end Behavioral;