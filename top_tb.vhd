library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

entity toptb is 
end toptb;
 
architecture toptb2 of toptb is
 
 
component top is
	port(
		clk : in STD_LOGIC;
		rst : in STD_LOGIC;
		addr : out STD_LOGIC_VECTOR ( 31 downto 0 );
		din : in STD_LOGIC_VECTOR ( 255 downto 0 ); ---- READ FROM PCI-E
		dout : out STD_LOGIC_VECTOR ( 255 downto 0 ); ----- WRITE to PCI-E
	  
		web : out STD_LOGIC_VECTOR ( 31 downto 0 );
	  
		KEY_OUT : out std_logic_vector(255 downto 0);   	--output key to encryptor
		
		ID_out : out std_logic_vector(255 downto 0);
		--switcher : out std_logic_vector(7 downto 0);
		
		--ports_ready :out STD_LOGIC;
		
		PORT0  :out std_logic_vector(7 downto 0); 
        PORT1  :out std_logic_vector(7 downto 0); 
        PORT2  :out std_logic_vector(7 downto 0); 
        PORT3  :out std_logic_vector(7 downto 0); 
                                                  
        PORT4  :out std_logic_vector(7 downto 0); 
        PORT5  :out std_logic_vector(7 downto 0); 
        PORT6  :out std_logic_vector(7 downto 0); 
        PORT7  :out std_logic_vector(7 downto 0); 
                                                  
        PORT8  :out std_logic_vector(7 downto 0); 
        PORT9  :out std_logic_vector(7 downto 0); 
        PORT10  :out std_logic_vector(7 downto 0);
        PORT11  :out std_logic_vector(7 downto 0);
                                                  
        PORT12  :out std_logic_vector(7 downto 0);
        PORT13  :out std_logic_vector(7 downto 0);
        PORT14  :out std_logic_vector(7 downto 0);
        PORT15  :out std_logic_vector(7 downto 0);
                                                  
        PORT16  :out std_logic_vector(7 downto 0);
        PORT17  :out std_logic_vector(7 downto 0);
        PORT18  :out std_logic_vector(7 downto 0);
        PORT19  :out std_logic_vector(7 downto 0);
                                                  
        PORT20  :out std_logic_vector(7 downto 0);
        PORT21  :out std_logic_vector(7 downto 0);
        PORT22  :out std_logic_vector(7 downto 0);
        PORT23  :out std_logic_vector(7 downto 0);
                                                  
        PORT24  :out std_logic_vector(7 downto 0);
        PORT25  :out std_logic_vector(7 downto 0);
        PORT26  :out std_logic_vector(7 downto 0);
        PORT27  :out std_logic_vector(7 downto 0);
                                                  
        PORT28  :out std_logic_vector(7 downto 0);
        PORT29  :out std_logic_vector(7 downto 0);
        PORT30  :out std_logic_vector(7 downto 0);
        PORT31  :out std_logic_vector(7 downto 0);
		
		SWITCH_EN : out STD_LOGIC
	);
end component top;
 
constant clockFrequency : integer := 100e6;
constant clockPeriod    : time := 1000ms /clockFrequency;
 
signal clk      :    STD_LOGIC                          :=  '1';
signal rst      :    STD_LOGIC                          :=  '0';
signal addr     :    STD_LOGIC_VECTOR ( 31 downto 0 );  -- := x"00000000";
signal din      :    STD_LOGIC_VECTOR ( 255 downto 0 );
signal dout     :    STD_LOGIC_VECTOR ( 255 downto 0 );
signal web      :    STD_LOGIC_VECTOR ( 31 downto 0 );
signal KEY_OUT  :    std_logic_vector(255 downto 0);
--signal switcher  :    std_logic_vector(7 downto 0);

signal ID_out : std_logic_vector(255 downto 0);
 
--signal ports_ready : STD_LOGIC;
 
 
signal  PORT0  : std_logic_vector(7 downto 0);
signal  PORT1  : std_logic_vector(7 downto 0);
signal	PORT2  : std_logic_vector(7 downto 0);
signal	PORT3  : std_logic_vector(7 downto 0);
		
signal	PORT4  : std_logic_vector(7 downto 0);
signal	PORT5  : std_logic_vector(7 downto 0);
signal	PORT6  : std_logic_vector(7 downto 0);
signal	PORT7  : std_logic_vector(7 downto 0);
		
signal	PORT8  : std_logic_vector(7 downto 0);
signal	PORT9  : std_logic_vector(7 downto 0);
signal	PORT10  : std_logic_vector(7 downto 0);
signal	PORT11  : std_logic_vector(7 downto 0);
		
signal	PORT12  : std_logic_vector(7 downto 0);
signal	PORT13  : std_logic_vector(7 downto 0);
signal	PORT14  : std_logic_vector(7 downto 0);
signal	PORT15  : std_logic_vector(7 downto 0);
		
signal	PORT16  : std_logic_vector(7 downto 0);
signal	PORT17  : std_logic_vector(7 downto 0);
signal	PORT18  : std_logic_vector(7 downto 0);
signal	PORT19  : std_logic_vector(7 downto 0);
		
signal	PORT20  : std_logic_vector(7 downto 0);
signal	PORT21  : std_logic_vector(7 downto 0);
signal	PORT22  : std_logic_vector(7 downto 0);
signal	PORT23  : std_logic_vector(7 downto 0);
		
signal	PORT24  : std_logic_vector(7 downto 0);
signal	PORT25  : std_logic_vector(7 downto 0);
signal	PORT26  : std_logic_vector(7 downto 0);
signal	PORT27  : std_logic_vector(7 downto 0);
		
signal	PORT28  : std_logic_vector(7 downto 0);
signal	PORT29  : std_logic_vector(7 downto 0);
signal	PORT30  : std_logic_vector(7 downto 0);
signal	PORT31  : std_logic_vector(7 downto 0);


 
 signal SWITCH_EN      :    STD_LOGIC;
 
 
 
signal Read_Address_Sequentially : std_logic_vector( 127 downto 0 );
signal Read_initial_address : std_logic_vector( 127 downto 0 );
signal WRITE_on_top_of_memory : std_logic_vector( 127 downto 0 );
signal Over_write_memory : std_logic_vector( 127 downto 0 );
 


 
 
begin
 
Read_Address_Sequentially   <=  x"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"; --opcode_update_key
Read_initial_address    <=  x"BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB"; --opcode_update_id
WRITE_on_top_of_memory     <=  x"CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC"; --opcode_READ_KEY
Over_write_memory      <=  x"DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD"; --opcode_READ_ID




 
clk <= not clk after clockPeriod/2; 
 
T1 : top port map(      clk => clk,
                        rst => rst,
                        addr => addr,
                        din =>din,
                        dout =>dout,
                        web =>web,
                        KEY_OUT => KEY_OUT,
                        ID_out => ID_out,
                        --ports_ready =>  ports_ready,                     
                       
                        PORT0   =>     PORT0,       
                        PORT1   =>     PORT1, 
                        PORT2   =>     PORT2, 
                        PORT3   =>     PORT3, 
                                            
                        PORT4   =>     PORT4, 
                        PORT5   =>     PORT5, 
                        PORT6   =>     PORT6, 
                        PORT7   =>     PORT7, 
                                            
                        PORT8   =>     PORT8 ,
                        PORT9   =>     PORT9 ,
                        PORT10  =>     PORT10,
                        PORT11  =>     PORT11,
                                            
                        PORT12  =>     PORT12,
                        PORT13  =>     PORT13,
                        PORT14  =>     PORT14,
                        PORT15  =>     PORT15,
                                            
                        PORT16  =>     PORT16,
                        PORT17  =>     PORT17,
                        PORT18  =>     PORT18,
                        PORT19  =>     PORT19,
                                            
                        PORT20  =>     PORT20,
                        PORT21  =>     PORT21,
                        PORT22  =>     PORT22,
                        PORT23  =>     PORT23,
                                            
                        PORT24  =>     PORT24,
                        PORT25  =>     PORT25,
                        PORT26  =>     PORT26,
                        PORT27  =>     PORT27,
                                            
                        PORT28  =>     PORT28,
                        PORT29  =>     PORT29,
                        PORT30  =>     PORT30,
                        PORT31  =>     PORT31,
                        SWITCH_EN  => SWITCH_EN
                        );
process
begin

rst <= '1';
wait for 20 ns;
rst <= '0';

--clk <= not clk after clockPeriod/2;
wait for 20 ns;
din(127 downto 0) <= Read_Address_Sequentially;
din(255 downto 128) <= x"11111111111111111111111111111111";
wait for 20 ns;
din <= x"BBB1116382412784687521631279846128937129254912548915245858145821";
wait for 20 ns;
din <= x"AAA1116423473382367323642386462129254912548915245858145821472318";
wait for 20 ns;
-------------------------------------------------------------------------
din(127 downto 0) <= Read_Address_Sequentially;
din(255 downto 128) <= x"11111111111111111111111111111111";
wait for 20 ns;
din <= x"BBB2226382412784687521631279846128937129254912548915245858145821";
wait for 20 ns;
din <= x"AAA2226423473382367323642386462129254912548915245858145821472318";
wait for 20 ns;
--------------------------------------------------------------------------------------------------

din(127 downto 0) <= Read_Address_Sequentially;
din(255 downto 128) <= x"33333333333333333333333333333333";
wait for 20 ns;
din <= x"BBB3336382412784687521631279846128937129254912548915245858145821";
wait for 20 ns;
din <= x"AAA3336423473382367323642386462129254912548915245858145821472318";
wait for 20 ns;
--------------------------------------------------------------------------------------------------





din(127 downto 0) <= Read_initial_address;
din(255 downto 128) <= x"44444444444444444444444444444444";
wait for 1000 ns;

--------------------------------------------------------------------------------------------------
din(127 downto 0) <= WRITE_on_top_of_memory;
din(255 downto 128) <= x"55555555555555555555555555555555";
wait for 20 ns;
din <= x"b488ce98cb768b4c69e80c10fe16635e2eb2d23317df93f5b50f551a4f01f1e3";
wait for 100 ns;


din(127 downto 0) <= WRITE_on_top_of_memory;
din(255 downto 128) <= x"66666666666666666666666666666666";
wait for 20 ns;
din <= x"220d5a51e0c1ea68de9b3b5b32d437e9220d5a51e0c1ea68de9b3b5b32d437e9";
wait for 100 ns;



din(127 downto 0) <= WRITE_on_top_of_memory;
din(255 downto 128) <= x"77777777777777777777777777777777";
wait for 20 ns;
din <= x"0000000000000000000000000000000000000000000000000000000000000000";
wait for 100 ns;


din(127 downto 0) <= WRITE_on_top_of_memory;
din(255 downto 128) <= x"88888888888888888888888888888888";
wait for 20 ns;
din <= x"AAA3336423473382367323642386462129254912548915245897145821472318";
wait for 100 ns;


--din(127 downto 0) <= WRITE_on_top_of_memory;
--din(255 downto 128) <= x"66666666666666666666666666666666";
--wait for 20 ns;
--din <= x"220d5a51e0c1ea68de9b3b5b32d437e9220d5a51e0c1ea68de9b3b5b32d437e9";
--wait for 100 ns;

rst <= '1';
wait for 20 ns;
rst <= '0';



-------------------------------------------------------------------------
--din(127 downto 0) <= Read_Address_Sequentially;
--din(255 downto 128) <= x"66666666666666666666666666666666";
--wait for 20 ns;
--din <= x"BBB6666382412784687521631279846128937129254912548915245858145821";
--wait for 20 ns;
--din <= x"AAA6666423473382367323642386462129254912548915245858145821472318";
--wait for 20 ns;
----------------------------------------------------------------------s----------------------------
--din(127 downto 0) <= Read_initial_address;
--din(255 downto 128) <= x"77777777777777777777777777777777";
--wait for 100 ns;


din(127 downto 0) <= Over_write_memory;
din(255 downto 128) <= x"88888888888888888888888888888888";
wait for 100 ns;



--------------------------------------------------------------------------------------------------
--din(127 downto 0) <= Read_Address_Sequentially;
--din(255 downto 128) <= x"44444444444444444444444444444444";
--wait for 20 ns;
--din <= x"BBB4446382412784687521631279846128937129254912548915245897145821";
--wait for 20 ns;
--din <= x"AAA4446423473382367323642386462129254912548915245858149721472318";
--wait for 20 ns;
--wait for 800 ns;
----------------------------------------------------------------------------------------------------
--din(127 downto 0) <= Read_Address_Sequentially;
--din(255 downto 128) <= x"33333333333333333333333333333333";
--wait for 20 ns;
--din <= x"BBB3336382412784687521631279846128937129254912548915245858145821";
--wait for 20 ns;
--din <= x"AAA3336423473382367323642386462129254912548915245858145821472318";
--wait for 20 ns;









--din(127 downto 0) <= WRITE_on_top_of_memory;
--din(255 downto 128) <= x"55555555555555555555555555555555";
--wait for 20 ns;
--din <= x"AAA5556423473382367323642386462129254912548915245897145821472318";
--wait for 20 ns;


--wait for 80 ns;
--din <= x"0000000000000000000000000000000000000000000000000000000000000000";
--wait for 100 ns;

--din(127 downto 0) <= Read_Address_Sequentially;
--din(255 downto 128) <= x"55555555555555555555555555555555";
--wait for 100 ns;
--din <= x"BBB5556382412784687521631279846128937129254912548915245858145821";
--wait for 20 ns;
--din <= x"AAA5556423473382367323642386462129254912548915245858145821472318";
--wait for 20 ns;

--din(127 downto 0) <= Read_Address_Sequentially;
--din(255 downto 128) <= x"66666666666666666666666666666666";
--wait for 20 ns;
--din <= x"BBB5556382412784687521631279846128937129254912548915245858145821";
--wait for 20 ns;
--din <= x"AAA5556423473382367323642386462129254912548915245858145821472318";
--wait for 20 ns;

--din(127 downto 0) <= Read_Address_Sequentially;
--din(255 downto 128) <= x"66666666666666666666666666666666";
--wait for 20 ns;
--din <= x"BBB3336382412784687521631279846128937129254912548915245858145821";
--wait for 20 ns;
--din <= x"AAA3336423473382367323642386462129254912548915245858145821472318";
--wait for 20 ns;
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
--din(127 downto 0) <= WRITE_on_top_of_memory;
--din(255 downto 128) <= x"55555555555555555555555555555555";
--wait for 20 ns;
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
--din(127 downto 0) <= Over_write_memory;
--din(255 downto 128) <= x"55555555555555555555555555555555";
--wait for 80 ns;
--din <= x"0000000000000000000000000000000000000000000000000000000000000000";

--wait for 100 ns;
wait;
end process;
 
end toptb2;