library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MdR is
    Port (
        clk_s       : in  STD_LOGIC;                      -- Main clock signal
        enable_ro   : in  STD_LOGIC;                      -- Enable signal for the shared RO
        enable_siro : in  STD_LOGIC;                      -- SIRO enable signal (not used in this design)
        ro_out      : out STD_LOGIC;                      -- Shared RO output
        Alarme      : out STD_LOGIC;                      -- Alarm output from Detector
        q_str       : out STD_LOGIC_VECTOR(6 downto 0)    -- Stored value from Detector
    );
end MdR;

architecture Behavioral of MdR is

    signal ro_out_internal : STD_LOGIC;  -- Internal signal for shared RO output

    component Detector
        Port (
            clk_s     : in  STD_LOGIC;
            Alarme    : out STD_LOGIC;
            q_str     : out STD_LOGIC_VECTOR(6 downto 0);
            ro_output    : in  STD_LOGIC
        );
    end component;

    component RO_SIRO
        Port (
            enable_ro             : in  STD_LOGIC;   -- From XDC (RO.vhd)
            ro_out             : out STD_LOGIC;  -- Outputs from ROs
            enable_siro     : in  STD_LOGIC   -- From XDC (ROattacks.vhd)
            -- siro_dummy_out : out STD_LOGIC    -- Forces routing
        );
    end component;

begin

    -- Assign the internal signal to the top-level output
    ro_out <= ro_out_internal;

    -- Instantiate Detector module
    Detector_inst : Detector
        port map (
            clk_s     => clk_s,      -- Main clock signal
            Alarme    => Alarme,     -- Alarm output
            q_str     => q_str,      -- Stored value output
            ro_output => ro_out_internal  -- Connects to the shared RO output
        );
    
    -- Instantiate RO_SIRO module
    RO_SIRO_inst : RO_SIRO
        port map (
            enable_ro     => enable_ro,  -- Enable signal for the shared RO
            ro_out        => ro_out_internal,  -- Shared RO output
            enable_siro   => enable_siro          -- SIRO enable signal (not used in this design)
            -- siro_dummy_out => '0'       -- Forces routing (not used in this design)
        );

end Behavioral;