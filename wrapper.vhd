library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

entity wrapper is
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
end wrapper;

architecture Behavioral of wrapper is

component controller 
  Port (
	
	--INTERFACE with Bram
	
      clk : in STD_LOGIC;
      rst : in STD_LOGIC;
      addr : out STD_LOGIC_VECTOR ( 31 downto 0 );
      din : in STD_LOGIC_VECTOR ( 255 downto 0 ); ---- READ FROM PCI-E
      dout : out STD_LOGIC_VECTOR ( 255 downto 0 ); ----- WRITE to PCI-E
	  web : out STD_LOGIC_VECTOR ( 31 downto 0 );
	  
	--INTERFACE with Bank registers
	
      INPUT_KEY : out STD_LOGIC_VECTOR( 255 downto 0 );
      LOAD_KEY : in  STD_LOGIC_VECTOR( 255 downto 0 );
      
      INPUT_ID : out STD_LOGIC_VECTOR( 255 downto 0 );
      LOAD_ID : in STD_LOGIC_VECTOR( 255 downto 0 );
      
      TABLE_OUTPUT : out STD_LOGIC_VECTOR( 255 downto 0 );
      TABLE_INPUT : in STD_LOGIC_VECTOR( 255 downto 0 );
      
      SWITCH_EN : out STD_LOGIC
   );
end component;

component KEY_Register
	port(
		clk : in STD_LOGIC;
		rst : in STD_LOGIC;
		KEY_IN : in STD_LOGIC_VECTOR ( 255 downto 0 );  	--take key from input
		KEY_OUT : out std_logic_vector(255 downto 0);   	--output key to encryptor
		SAVE_KEY : out std_logic_vector(255 downto 0)		--send key to BRAM/PCIE
	);
end component;

component ID_Register
	port(
		clk : in STD_LOGIC;
		rst : in STD_LOGIC;
		ID_IN : in STD_LOGIC_VECTOR (255 downto 0);
		ID_OUT :out std_logic_vector(255 downto 0);
		SAVE_ID: out std_logic_vector(255 downto 0)
	);
end component;

component switching_table
	port(
		clk : in STD_LOGIC;
		rst : in STD_LOGIC;
		
		TABLE_IN : in STD_LOGIC_VECTOR (255 downto 0);
		TABLE_OUT : out STD_LOGIC_VECTOR (255 downto 0);
		
		
		--ports_ready :out STD_LOGIC;
		--switcher :out std_logic_vector(7 downto 0);
		
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
		PORT31  :out std_logic_vector(7 downto 0)
	   );
end component; 

signal 	key_o 		: std_logic_vector( 255 downto 0 );
signal	addr_0 		: std_logic_vector( 31 	downto 0 );
signal	din_i 		: std_logic_vector( 255 downto 0 );
signal	dout_o		: std_logic_vector( 255 downto 0 );
signal 	web_o 		: std_logic_vector( 31 	downto 0 );
signal 	INPUT_KEY_o	: std_logic_vector( 255 downto 0 );
signal	LOAD_KEY_i	: std_logic_vector( 255 downto 0 );

signal	INPUT_ID_o	: std_logic_vector( 255 downto 0 );
signal	LOAD_ID_i	: std_logic_vector( 255 downto 0 );


signal	INPUT_switch_i	: std_logic_vector( 255 downto 0 );
signal 	LOAD_switch_o	: std_logic_vector( 255 downto 0 );


begin

controller_i: controller

  port map (
	clk 		=> 	clk,
	rst 		=> 	rst,
    addr( 31 downto 0 ) 		=> 	addr( 31 downto 0 ),
	din(255 downto 0) 		=> 	din(255 downto 0),
	dout(255 downto 0) 		=> 	dout(255 downto 0),
	web( 31 downto 0 ) 		=> 	web( 31 downto 0 ),
	INPUT_KEY	=> 	INPUT_KEY_o,
	LOAD_KEY	=>	LOAD_KEY_i,
	INPUT_ID	=>	INPUT_ID_o,
	LOAD_ID		=>	LOAD_ID_i,
	TABLE_OUTPUT =>  INPUT_switch_i,
	TABLE_INPUT  =>  LOAD_switch_o,
	SWITCH_EN => SWITCH_EN
  );

KEY_Register_i: KEY_Register 
  port map (
	clk 			=> clk,
    rst 			=> rst,
	KEY_IN 			=> INPUT_KEY_o,
	KEY_OUT(255 downto 0)			=> KEY_OUT(255 downto 0),
	SAVE_KEY		=> LOAD_KEY_i
  );
  
  
ID_Register_i: ID_Register 
  port map (
	clk 	=>		clk,
    rst 	=> 		rst,
	ID_IN	=>		INPUT_ID_o,
	SAVE_ID	=>		LOAD_ID_i,
	ID_OUT =>  ID_OUT
  );
  
  
switching_table_i: switching_table 
  port map (
	clk 	=>		clk,
    rst 	=> 		rst,
    --switcher(7 downto 0)    =>      switcher(7 downto 0),
	TABLE_IN	=>		INPUT_switch_i,
	TABLE_OUT	=>		LOAD_switch_o,
	
	--ports_ready => ports_ready,
	
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
    PORT31  =>     PORT31
	

  );
  
  end Behavioral;
  
