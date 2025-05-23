library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.all;
library UNISIM;
use UNISIM.VComponents.all;

--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
entity Bitstream is
  Port (Change_RO,clk   : in std_logic ;
        led1            : out std_logic:='0';
        led2            : out std_logic:='0';
        led3            : out std_logic:='0';
        led4            : out std_logic:='0';     
        uart_rx         : in STD_LOGIC;
        uart_tx         : out STD_LOGIC  ;
        reset_btn       : in STD_LOGIC);
end Bitstream;

architecture Behavioral of Bitstream is

--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
-- UART RX
signal rx_busy       : STD_LOGIC := '0';
signal received_word : STD_LOGIC_VECTOR(7 downto 0);
signal rdy           : STD_LOGIC;
-- UART Tx
signal tx_en         : STD_LOGIC:='0';
signal tx_busy       : STD_LOGIC;
signal tx_data_in    : STD_LOGIC_VECTOR(7 downto 0):= (others => '0');
    
type SHIFT_Transmission_State is (IDLE, SHIFT);
signal shift_state   : SHIFT_Transmission_State := IDLE;
signal cntrl         : STD_LOGIC := '0';
signal str_index     : integer range 0 to 7 := 0;
signal shift_reg     : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
signal output_data   : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
signal Mux_Selection : std_logic_vector(13 downto 0):= (others => '0');
signal temp_result : integer range 0 to 255:=0;
signal enable1 : std_logic:='0';
signal activate_2600 : std_logic:='0';
signal activate_3600 : std_logic:='0';
signal activate_4600 : std_logic:='0';


signal out_lut_goupe1 :  std_logic_vector(127 downto 0);
signal out_lut_goupe2 :  std_logic_vector(127 downto 0);
signal compteur_intern :  std_logic_vector(15 downto 0);
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------

--component Ros_selection is
--  Port ( 
--  challenge : in std_logic_vector(7 downto 0) ;
--  Output    : out std_logic ;
--  Enable    : in std_logic
--  );
--end component ;
----------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
component ROattacks is
Port (
        EnableROattack : in std_logic

);
end component;

--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
component Lut6_groupe1 is
  Port (
O6 :  out std_logic; -- Sortie
O5 :  out std_logic ; -- Sortie
lut_entre : in std_logic_vector( 5 downto 0)
  );
end component;

component Lut6_groupe2 is
  Port (
O6 :  out std_logic; -- Sortie
O5 :  out std_logic ; -- Sortie
lut_entre : in std_logic_vector( 5 downto 0)
  );
end component;



--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
signal Internal_Challenge_mux1 : std_logic_vector(8 downto 0) := "000000000" ;
signal Internal_Challenge_mux2 : std_logic_vector(8 downto 0) := "000000000" ;
signal PUF_Response       : std_logic_vector(63 downto 0):= (others => '0');
signal PUF_start          : STD_LOGIC:='0';
signal MUX_1_challenge    : std_logic_vector(7 downto 0):="00000000";
signal MUX_2_challenge    : std_logic_vector(7 downto 0):="00000000";
signal MUX_1_OUT          : std_logic:='0';
signal MUX_2_OUT          : std_logic:='0';
signal compteur_cycles    : unsigned(28 downto 0):= (others => '0');
signal MUX_1_Counter      : unsigned(30 downto 0) := (others => '0');
signal MUX_2_Counter      : unsigned(30 downto 0) := (others => '0');
signal Enable             : std_logic:='0';
signal Reset_Comparison   : std_logic := '0';
signal Reset_Counter      : std_logic := '0';
signal Enable_Comparison  : std_logic := '0';
signal Enable_Counter     : std_logic := '0';
signal full               : std_logic := '0'  ;     -- Signal indiquant que le registre est plein
signal active_prev        : std_logic := '0';  -- Stocke la valeur précédente de active
signal data_sent          : boolean := false;  -- Signal pour indiquer si les données ont déjà été envoyées
signal Counter_Timer      : std_logic_vector(2 downto 0);
signal Timer_size         : integer := 0;
signal Enable_Ro_Pairs_groupe1: std_logic_vector(127 downto 0) := (others => '0');
signal Enable_Ro_Pairs_groupe2: std_logic_vector(127 downto 0) := (others => '0');
signal Active_All_ROs: std_logic := '0';
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
type t_state is (PUF_State_0,PUF_State_1,PUF_State_2,PUF_State_3,PUF_State_4,PUF_State_5);
signal state : t_state; 
type Tr_state is (Tr_State_1,Tr_State_2,Tr_State_3,Tr_State_4,Tr_State_5,Tr_State_6,Tr_State_7,Tr_State_8,Tr_State_9,Tr_State_10,Tr_State_11,Tr_State_12,Tr_State_13,Tr_State_14,Tr_State_15,Tr_State_16);
signal Transmission_State : Tr_state; 
signal tx_count : integer range 0 to 15 := 0; -- Initialisation du compteur de transmission


attribute dont_touch : string;
attribute dont_touch of out_lut_goupe1 : signal is "true";  -- DONT_TOUCH appliqué au signal
attribute dont_touch of out_lut_goupe2 : signal is "true";  -- DONT_TOUCH appliqué au signal



--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
begin

--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------

-- UART Rx
uart_rx_inst : entity work.uart_rx PORT MAP(
    clk => clk,
    rx_in => uart_rx,
    busy_out => rx_busy,
    rdy => rdy,
    data_out => received_word
);

-- UART Tx
uart_tx_inst : entity work.uart_tx PORT MAP(
    clk => clk,
    reset => reset_btn,
    data_in => tx_data_in,
    en => tx_en,
    busy_out => tx_busy,
    tx_out => uart_tx
);


 --------------------------------------------------------------------------------------------------------------------------------
 --------------------------------------------------------------------------------------------------------------------------------
 --------------------------------------------------------------------------------------------------------------------------------
 
 
--process(clk)
--begin 
--     if rising_edge(clk)  then  if full = '1'  and tx_busy = '0' and not data_sent
--            then 
--           tx_en <= '1' ;
--           case Transmission_State is          
--                when Tr_State_1 =>
--                    tx_data_in <= PUF_Response(63 downto 56);                   
--                    Transmission_State <= Tr_State_2;
--                    tx_en <= '1' ;     
--                when Tr_State_2 =>
--                    tx_en <= '0' ;
--                    Transmission_State <= Tr_State_3;                                                   
--                when Tr_State_3 =>          
--                    tx_data_in <= PUF_Response(55 downto 48);
--                    Transmission_State <= Tr_State_4;
--                    tx_en <= '1' ;                                              
--               when Tr_State_4 =>         
--                    tx_en <= '0' ;
--                    Transmission_State <= Tr_State_5;                                   
--                when Tr_State_5 =>            
--                    tx_data_in <= PUF_Response(47 downto 40);
--                    Transmission_State <= Tr_State_6;
--                    tx_en <= '1' ;                                                           
--                when Tr_State_6 =>             
--                    tx_en <= '0' ;
--                    Transmission_State <= Tr_State_7;                         
--                when Tr_State_7 =>            
--                    tx_data_in <= PUF_Response(39 downto 32);
--                    Transmission_State <= Tr_State_8;
--                     tx_en <= '1' ;    
--               when Tr_State_8 =>            
--                     tx_en <= '0' ;
--                    Transmission_State <= Tr_State_9;                    
--                when Tr_State_9 =>            
--                    tx_data_in <= PUF_Response(31 downto 24);
--                    Transmission_State <= Tr_State_10;
--                    tx_en <= '1' ;               
--                when Tr_State_10 =>             
--                    tx_en <= '0' ;
--                    Transmission_State <= Tr_State_11; 
--                when Tr_State_11 =>
--                if full = '1' then
--                    tx_data_in <= PUF_Response(23 downto 16);
--                    Transmission_State <= Tr_State_12;
--                    tx_en <= '1' ;
--                     end if;         
--                when Tr_State_12 =>         
--                    tx_en <= '0' ;
--                    Transmission_State <= Tr_State_13;       
--                when Tr_State_13 =>     
--                    tx_data_in <= PUF_Response(15 downto 8);
--                    Transmission_State <= Tr_State_14;
--                    tx_en <= '1' ;
--               when Tr_State_14 =>       
--                    tx_en <= '0' ;
--                    Transmission_State <= Tr_State_15;
--                when Tr_State_15 =>        
--                    tx_data_in <= PUF_Response(7 downto 0);
--                    Transmission_State <= Tr_State_16;
--                    tx_en <= '1' ;           
--                when Tr_State_16 =>
--                    tx_en <= '0' ;
--                    Transmission_State <= Tr_State_1;
--                    data_sent <= true;                    
--                when others   =>                        
--                    Transmission_State <= Tr_State_1;

--                 -- Assurez-vous que cela se produit après la dernière donnée envoyée
--            end case;
--        elsif full = '0' then
--            data_sent <= false;  -- Réinitialiser le signal lorsque full revient à 0
            
--        end if;
--        end if;
--end process;

 --------------------------------------------------------------------------------------------------------------------------------
 --------------------------------------------------------------------------------------------------------------------------------
 --------------------------------------------------------------------------------------------------------------------------------
 process(clk)
 begin
        if rising_edge(clk) then
            if reset_btn = '1' then
                shift_state <= IDLE; -- Réinitialisation de la machine d'état lors du reset
            else
                case shift_state is
                    when IDLE =>
                        -- Attendre un signal de déclenchement pour passer à l'état SHIFT
                        if rdy = '1' then
                            shift_state <= SHIFT;
                        else
                            shift_state <= IDLE;
                        end if;

                    when SHIFT =>
                        -- Enregistrer les 8 premiers bits de received_word dans le registre à décalage
                        -- puis enregistrer les 8 bits suivants dans le registre à décalage et produire la sortie de 15 bits

                        output_data <=  received_word;
                        shift_state <= IDLE;
                end case;
            end if;
        end if;
    end process;

--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
 
 
PUF_start      <= output_data(7);
--Counter_Timer  <= output_data(2 downto 0);
activate_2600  <= not(output_data(6));
activate_3600  <= not(output_data(5));
activate_4600  <= not(output_data(4));

--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------


--uut1 : Ros_selection
--port map (
--  challenge => MUX_1_challenge ,
--  Output    => MUX_1_OUT ,
--  Enable    => enable );


--uut2 : Ros_selection
--port map (
--  challenge => MUX_2_challenge,
--  Output    => MUX_2_OUT ,
--  Enable    => enable1);

--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------

--process(Counter_Timer)
--begin 

--        if Counter_Timer     = "001" then
--            Timer_size <= 12000000;
--        elsif Counter_Timer  = "010" then
--            Timer_size <= 1200000; 
--        elsif Counter_Timer  = "011" then
--            Timer_size <= 120000;
--        elsif Counter_Timer  = "100" then
--            Timer_size <= 12000;
--        end if;
        
--end process;

--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--process(clk,Timer_size)
--begin 
--    if clk'event and clk = '1' then
--        if compteur_cycles = Timer_size then
--            compteur_cycles <= (others => '0');
--        else
--            compteur_cycles <= compteur_cycles + 1;
--        end if;
--    end if;
--end process;
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------


--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------


--process(clk)
--begin 
--    if rising_edge(clk) then 
--        -- Front montant détecté, changer l'état
--        if compteur_cycles = Timer_size and PUF_start = '1'then 
--            if Internal_Challenge_mux1 = "100000000" then             
--                  Internal_Challenge_mux1 <= (others => '0'); -- Remise à zéro de B                 
--            end if;   

--            case state is
--                when PUF_State_0 =>
--                    Enable_Comparison <= '0';
--                    Reset_Comparison<= '1';
--                    Reset_Counter<= '1';      
--                    state <= PUF_State_1;
--                    MUX_1_challenge <=  Internal_Challenge_mux1(7 downto 0) ;
--                    MUX_2_challenge  <= Internal_Challenge_mux1(7 downto 0) ;
--                    enable <= '0' ;
--                    Enable_Counter <= '0'; 

--                when PUF_State_1 =>
--                    Enable_Comparison <= '0';
--                    Reset_Comparison<= '1';
--                    Reset_Counter<= '0'; 
--                    state <= PUF_State_2;
--                    MUX_1_challenge <=  Internal_Challenge_mux1(7 downto 0) ;
--                    MUX_2_challenge  <= Internal_Challenge_mux1(7 downto 0);
--                    enable <= '1' ; 
--                    Enable_Counter <= '1'; 
                    
--                when PUF_State_2 =>
--                    Enable_Comparison <= '0';
--                    Reset_Comparison<= '0';
--                    Reset_Counter<= '0'; 
--                    state <= PUF_State_3;
--                    MUX_1_challenge <=  Internal_Challenge_mux1(7 downto 0) ;
--                    MUX_2_challenge  <= Internal_Challenge_mux1(7 downto 0) ;    
--                    enable <= '1' ;
--                    Enable_Counter <= '0'; 
                    
--                when PUF_State_3 =>
--                    Reset_Comparison<= '0';
--                    Reset_Counter<= '0'; 
--                    Enable_Comparison <= '1';
--                    state <= PUF_State_4;
--                    MUX_1_challenge <=  Internal_Challenge_mux1(7 downto 0) ;
--                    MUX_2_challenge  <= Internal_Challenge_mux1(7 downto 0);
--                    enable <= '0' ;  
--                    Enable_Counter <= '0';                   
                    
--                when PUF_State_4 =>
--                    Reset_Comparison<= '1';
--                    Reset_Counter<= '1'; 
--                    Enable_Comparison <= '0';
--                    state <= PUF_State_5;
--                    MUX_1_challenge <= Internal_Challenge_mux1(7 downto 0);
--                    MUX_2_challenge  <= Internal_Challenge_mux1(7 downto 0) ;
--                    enable <= '0' ;  
--                    Enable_Counter <= '0'; 
                    
                    
--                when PUF_State_5 =>
--                    -- Défaut, ne devrait pas arriver
--                    state <= PUF_State_0;
--                    Internal_Challenge_mux1 <= Internal_Challenge_mux1 + 1 ;

--            end case;
--        end if;
--    end if;
--end process;


----------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------

--process(Enable_Counter,MUX_1_Counter,MUX_2_OUT ,Reset_Counter)
--begin
--if Reset_Counter = '1' then  MUX_1_Counter <= (others =>'0');
--elsif Enable_Counter = '1' then if MUX_1_OUT'event and MUX_1_OUT  ='1' then MUX_1_Counter <= MUX_1_Counter + 1;
--end if;
--end if;


--if Reset_Counter = '1' then  MUX_2_Counter <= (others =>'0');
--elsif Enable_Counter = '1' then if MUX_2_OUT'event and MUX_2_OUT  ='1' then MUX_2_Counter <= MUX_2_Counter + 1;
--end if;
--end if;
--end process;

----------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------
--process(clk, Reset_Comparison)
--begin
--    if Reset_Comparison = '1' then 
--        led4 <= '0';
--        led3 <= '0';
--        PUF_Response <= (others => '0');
--        full <= '0';
--    elsif rising_edge(clk) then 
--        if Enable_Comparison = '1' then 
--            if MUX_1_Counter < MUX_2_Counter then 
--                led4 <= '1';         
--                PUF_Response(63) <= '0';

--                PUF_Response(61 downto 31) <= std_logic_vector(MUX_1_Counter);   
--                PUF_Response(30 downto 0) <= std_logic_vector(MUX_2_Counter);              
--            else 
--                led3 <= '1';
--                PUF_Response(63) <= '1';

--                PUF_Response(61 downto 31) <= std_logic_vector(MUX_1_Counter);   
--                PUF_Response(30 downto 0) <= std_logic_vector(MUX_2_Counter);     
--            end if;            
--               full <= '1';  -- Le registre est plein
--              else  
--              full <= '0';
--           end if;
--           end if;
--end process;


--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------

--process(Internal_Challenge)
--    begin
--        if Internal_Challenge(0) = '0' then
--            temp_result <= 129 * CONV_INTEGER(Internal_Challenge(7 downto 1));
--        else
--            temp_result <= 129 * CONV_INTEGER(Internal_Challenge(7 downto 1)) + 1;
--        end if;
--    end process;
--Mux_Selection <= std_logic_vector(to_unsigned(temp_result, 14));

--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
g_GENERATE_FOR_2600: for i in 0 to 2600 generate
    UUT_2600 : ROattacks
    port map(EnableROattack => activate_2600 );
    end generate g_GENERATE_FOR_2600;    

g_GENERATE_FOR_3600: for i in 0 to 1000 generate
    UUT_3600 : ROattacks
    port map(EnableROattack => activate_3600 );
    end generate g_GENERATE_FOR_3600; 
    
g_GENERATE_FOR_4600: for i in 0 to 1000 generate
    UUT_4600 : ROattacks
    port map(EnableROattack => activate_4600 );
    end generate g_GENERATE_FOR_4600; 

--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
process(clk)
begin
if clk'event and clk = '1' then 
    compteur_intern <= compteur_intern + '1';
end if;
end process;
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
Group1: for i in 0 to 63 generate  -- Limité à 7 pour éviter de dépasser l'indice du tableau
        lut_group1 : Lut6_groupe1
            port map (
                O6  => out_lut_goupe1(2*i),     -- Connexion O6 à i*2
                O5  => out_lut_goupe1(2*i+1),   -- Connexion O5 à i*2 + 1
                lut_entre => compteur_intern(15 downto 10)  -- Entrée commune pour tous les composants
            );
end generate;
  

--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------


Group2: for i in 0 to 63 generate  -- Limité à 7 pour éviter de dépasser l'indice du tableau
        lut_group2 : Lut6_groupe2
        port map (
                O6  => out_lut_goupe2(2*i),     -- Connexion O6 à i*2
                O5  => out_lut_goupe2(2*i+1),   -- Connexion O5 à i*2 + 1
                lut_entre => compteur_intern(15 downto 10)  -- Entrée commune pour tous les composants
            );
end generate;
  
--process(out_lut_goupe1)
--    variable result : std_logic := '1';
--begin
--    for i in out_lut_goupe1'range loop
--        result := result and out_lut_goupe1(i);
--    end loop;
--    led1 <= result;
--end process;

led1 <= out_lut_goupe1(127) and out_lut_goupe1(126) and out_lut_goupe1(125) and out_lut_goupe1(124) and
        out_lut_goupe1(123) and out_lut_goupe1(122) and out_lut_goupe1(121) and out_lut_goupe1(120) and
        out_lut_goupe1(119) and out_lut_goupe1(118) and out_lut_goupe1(117) and out_lut_goupe1(116) and
        out_lut_goupe1(115) and out_lut_goupe1(114) and out_lut_goupe1(113) and out_lut_goupe1(112) and
        out_lut_goupe1(111) and out_lut_goupe1(110) and out_lut_goupe1(109) and out_lut_goupe1(108) and
        out_lut_goupe1(107) and out_lut_goupe1(106) and out_lut_goupe1(105) and out_lut_goupe1(104) and
        out_lut_goupe1(103) and out_lut_goupe1(102) and out_lut_goupe1(101) and out_lut_goupe1(100) and
        out_lut_goupe1(99) and out_lut_goupe1(98) and out_lut_goupe1(97) and out_lut_goupe1(96) and
        out_lut_goupe1(95) and out_lut_goupe1(94) and out_lut_goupe1(93) and out_lut_goupe1(92) and
        out_lut_goupe1(91) and out_lut_goupe1(90) and out_lut_goupe1(89) and out_lut_goupe1(88) and
        out_lut_goupe1(87) and out_lut_goupe1(86) and out_lut_goupe1(85) and out_lut_goupe1(84) and
        out_lut_goupe1(83) and out_lut_goupe1(82) and out_lut_goupe1(81) and out_lut_goupe1(80) and
        out_lut_goupe1(79) and out_lut_goupe1(78) and out_lut_goupe1(77) and out_lut_goupe1(76) and
        out_lut_goupe1(75) and out_lut_goupe1(74) and out_lut_goupe1(73) and out_lut_goupe1(72) and
        out_lut_goupe1(71) and out_lut_goupe1(70) and out_lut_goupe1(69) and out_lut_goupe1(68) and
        out_lut_goupe1(67) and out_lut_goupe1(66) and out_lut_goupe1(65) and out_lut_goupe1(64) and
        out_lut_goupe1(63) and out_lut_goupe1(62) and out_lut_goupe1(61) and out_lut_goupe1(60) and
        out_lut_goupe1(59) and out_lut_goupe1(58) and out_lut_goupe1(57) and out_lut_goupe1(56) and
        out_lut_goupe1(55) and out_lut_goupe1(54) and out_lut_goupe1(53) and out_lut_goupe1(52) and
        out_lut_goupe1(51) and out_lut_goupe1(50) and out_lut_goupe1(49) and out_lut_goupe1(48) and
        out_lut_goupe1(47) and out_lut_goupe1(46) and out_lut_goupe1(45) and out_lut_goupe1(44) and
        out_lut_goupe1(43) and out_lut_goupe1(42) and out_lut_goupe1(41) and out_lut_goupe1(40) and
        out_lut_goupe1(39) and out_lut_goupe1(38) and out_lut_goupe1(37) and out_lut_goupe1(36) and
        out_lut_goupe1(35) and out_lut_goupe1(34) and out_lut_goupe1(33) and out_lut_goupe1(32) and
        out_lut_goupe1(31) and out_lut_goupe1(30) and out_lut_goupe1(29) and out_lut_goupe1(28) and
        out_lut_goupe1(27) and out_lut_goupe1(26) and out_lut_goupe1(25) and out_lut_goupe1(24) and
        out_lut_goupe1(23) and out_lut_goupe1(22) and out_lut_goupe1(21) and out_lut_goupe1(20) and
        out_lut_goupe1(19) and out_lut_goupe1(18) and out_lut_goupe1(17) and out_lut_goupe1(16) and
        out_lut_goupe1(15) and out_lut_goupe1(14) and out_lut_goupe1(13) and out_lut_goupe1(12) and
        out_lut_goupe1(11) and out_lut_goupe1(10) and out_lut_goupe1(9) and out_lut_goupe1(8) and
        out_lut_goupe1(7) and out_lut_goupe1(6) and out_lut_goupe1(5) and out_lut_goupe1(4) and
        out_lut_goupe1(3) and out_lut_goupe1(2) and out_lut_goupe1(1) and out_lut_goupe1(0);



led2 <= out_lut_goupe2(127) and out_lut_goupe2(126) and out_lut_goupe2(125) and out_lut_goupe2(124) and
        out_lut_goupe2(123) and out_lut_goupe2(122) and out_lut_goupe2(121) and out_lut_goupe2(120) and
        out_lut_goupe2(119) and out_lut_goupe2(118) and out_lut_goupe2(117) and out_lut_goupe2(116) and
        out_lut_goupe2(115) and out_lut_goupe2(114) and out_lut_goupe2(113) and out_lut_goupe2(112) and
        out_lut_goupe2(111) and out_lut_goupe2(110) and out_lut_goupe2(109) and out_lut_goupe2(108) and
        out_lut_goupe2(107) and out_lut_goupe2(106) and out_lut_goupe2(105) and out_lut_goupe2(104) and
        out_lut_goupe2(103) and out_lut_goupe2(102) and out_lut_goupe2(101) and out_lut_goupe2(100) and
        out_lut_goupe2(99) and out_lut_goupe2(98) and out_lut_goupe2(97) and out_lut_goupe2(96) and
        out_lut_goupe2(95) and out_lut_goupe2(94) and out_lut_goupe2(93) and out_lut_goupe2(92) and
        out_lut_goupe2(91) and out_lut_goupe2(90) and out_lut_goupe2(89) and out_lut_goupe2(88) and
        out_lut_goupe2(87) and out_lut_goupe2(86) and out_lut_goupe2(85) and out_lut_goupe2(84) and
        out_lut_goupe2(83) and out_lut_goupe2(82) and out_lut_goupe2(81) and out_lut_goupe2(80) and
        out_lut_goupe2(79) and out_lut_goupe2(78) and out_lut_goupe2(77) and out_lut_goupe2(76) and
        out_lut_goupe2(75) and out_lut_goupe2(74) and out_lut_goupe2(73) and out_lut_goupe2(72) and
        out_lut_goupe2(71) and out_lut_goupe2(70) and out_lut_goupe2(69) and out_lut_goupe2(68) and
        out_lut_goupe2(67) and out_lut_goupe2(66) and out_lut_goupe2(65) and out_lut_goupe2(64) and
        out_lut_goupe2(63) and out_lut_goupe2(62) and out_lut_goupe2(61) and out_lut_goupe2(60) and
        out_lut_goupe2(59) and out_lut_goupe2(58) and out_lut_goupe2(57) and out_lut_goupe2(56) and
        out_lut_goupe2(55) and out_lut_goupe2(54) and out_lut_goupe2(53) and out_lut_goupe2(52) and
        out_lut_goupe2(51) and out_lut_goupe2(50) and out_lut_goupe2(49) and out_lut_goupe2(48) and
        out_lut_goupe2(47) and out_lut_goupe2(46) and out_lut_goupe2(45) and out_lut_goupe2(44) and
        out_lut_goupe2(43) and out_lut_goupe2(42) and out_lut_goupe2(41) and out_lut_goupe2(40) and
        out_lut_goupe2(39) and out_lut_goupe2(38) and out_lut_goupe2(37) and out_lut_goupe2(36) and
        out_lut_goupe2(35) and out_lut_goupe2(34) and out_lut_goupe2(33) and out_lut_goupe2(32) and
        out_lut_goupe2(31) and out_lut_goupe2(30) and out_lut_goupe2(29) and out_lut_goupe2(28) and
        out_lut_goupe2(27) and out_lut_goupe2(26) and out_lut_goupe2(25) and out_lut_goupe2(24) and
        out_lut_goupe2(23) and out_lut_goupe2(22) and out_lut_goupe2(21) and out_lut_goupe2(20) and
        out_lut_goupe2(19) and out_lut_goupe2(18) and out_lut_goupe2(17) and out_lut_goupe2(16) and
        out_lut_goupe2(15) and out_lut_goupe2(14) and out_lut_goupe2(13) and out_lut_goupe2(12) and
        out_lut_goupe2(11) and out_lut_goupe2(10) and out_lut_goupe2(9) and out_lut_goupe2(8) and
        out_lut_goupe2(7) and out_lut_goupe2(6) and out_lut_goupe2(5) and out_lut_goupe2(4) and
        out_lut_goupe2(3) and out_lut_goupe2(2) and out_lut_goupe2(1) and out_lut_goupe2(0);



end Behavioral;






