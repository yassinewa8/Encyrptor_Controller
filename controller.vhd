-----------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_misc.all;
use ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;
use work.all;


entity controller is
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
end controller;

architecture Behavioral of controller is

------- signal declarations --------------------------------------------------

type state_type is (s0,s1,s2,s3,s4,s5,       s6,s7,s8,s9,s10,s11,s12,            s13,s14,s15,   s16,s17,s18,s19,s20);
signal next_state : state_type;

signal addr_r : std_logic_vector(31 downto 0);
signal dout_i : std_logic_vector( 255 downto 0 );


signal val : std_logic_vector(127 downto 0) := (others=>'0');

signal previous_sequence : std_logic_vector( 255 downto 0 );

signal ADD_position : std_logic_vector(31 downto 0);
signal ADD_position_r : std_logic_vector(31 downto 0);

signal counter : unsigned(31 downto 0);

signal counter1 : unsigned(31 downto 0); 

signal counter2 : unsigned(31 downto 0);

signal counter3 : unsigned(31 downto 0);



--------- OPCODE_SIGNALS----------------------------------------------------------
signal Read_Address_Sequentially : std_logic_vector( 127 downto 0 );
signal Read_initial_address : std_logic_vector( 127 downto 0 );
signal WRITE_on_top_of_memory : std_logic_vector( 127 downto 0 );
signal Over_write_memory : std_logic_vector( 127 downto 0 );
------- KEY_Register----------------------------------------------------------
component KEY_Register
	port(
		clk : in STD_LOGIC;
		KEY_IN : in STD_LOGIC_VECTOR ( 255 downto 0 );  	--take key from input
		KEY_OUT : out std_logic_vector(255 downto 0);   	--output key to encryptor
		SAVE_KEY : out std_logic_vector(255 downto 0)		--send key to BRAM/PCIE
);
end component; 
------- ID_Register-----------------------------------------------------------

component ID_Register
	port(
		clk : in STD_LOGIC;
		rst : in STD_LOGIC;
		ID_IN : in STD_LOGIC_VECTOR (255 downto 0);
		ID_OUT :out std_logic_vector(255 downto 0);
		SAVE_ID: out std_logic_vector(255 downto 0)
	);
end component; 
------- Switching_table-----------------------------------------------------------
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
------- STATE_MACHINE-----------------------------------------------------------
begin
------- Opcode VALUES-----------------------------------------------------------
Read_Address_Sequentially       <=  x"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"; --Read_Address_Sequentially
Read_initial_address            <=  x"BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB"; --Read_initial_address
WRITE_on_top_of_memory          <=  x"CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC"; --WRITE_on_top_of_memory
Over_write_memory               <=  x"DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD"; --Over_write_memory

addr <= addr_r;
dout <= dout_i;

Write_data : process(rst,clk)
begin
	if rst = '1' then
        addr_r <= x"00000020";
        ADD_position <= x"00000040";
		web <= (others=>'0');
		dout_i <= x"0000000000000000000000000000000000000000000000000000000000000000";
		val <=  (others=>'0');
		
		TABLE_OUTPUT<=x"0000000000000000000000000000000000000000000000000000000000000000";
		INPUT_KEY<=x"0000000000000000000000000000000000000000000000000000000000000000";
		INPUT_ID<=x"0000000000000000000000000000000000000000000000000000000000000000";
		next_state <= s0;
		counter <= (others=>'0');
		counter1 <= (others=>'0');
		counter2 <= (others=>'0');
		counter3 <= (others=>'0');
	elsif rising_edge(clk) then   
        case next_state is
------------------------------------------------------------------------------           
            when s0 =>
            web <= (others=>'0');
            --counter <= (others=>'0');
            --counter1 <= (others=>'0');
            --addr_r <= x"00000020";
            if  din(127 downto 0) = Read_Address_Sequentially then
                    val <= din(255 downto 128);
                    if  val /= din(255 downto 128) then
                        addr_r <= addr_r + x"20"; 
                        next_state <= s1; 
                    else
                        next_state <= s0;
                        addr_r <= x"00000020";    
                    end if;
---------------------------------------------------------------------------------
                elsif  din(127 downto 0) = Read_initial_address then
                    val <= din(255 downto 128);
                    if  val /= din(255 downto 128) then
                        counter2 <= (others=>'0');
                        next_state <= s6; 
                    else
                        next_state <= s0;
                        addr_r <= x"00000020";    
                    end if;
---------------------------------------------------------------------------------
                elsif   din(127 downto 0) = WRITE_on_top_of_memory then
                    val <= din(255 downto 128);
                    if  val /= din(255 downto 128) then
                        next_state <= s13; 
                    else
                        next_state <= s0;
                        addr_r <= x"00000020";    
                    end if;
---------------------------------------------------------------------------------
                elsif  din(127 downto 0) = Over_write_memory then
                    val <= din(255 downto 128);
                    if  val /= din(255 downto 128) then
                        next_state <= s16; 
                    else
                        next_state <= s0;
                        addr_r <= x"00000020";    
                    end if;
                    
-------------------------------------------------------------------------------------------------------------
            else
                    next_state <= s0;
                    addr_r <= x"00000020";    
            end if; 
------------READ_FROM_MEMORY_TO_KEY and ID regsiter----------------------------------------------------------------------------------------
            when s1 =>
				    next_state <= s2; 
			when s2 =>
			     addr_r <= addr_r + x"20";
                    INPUT_ID <= din;
                    next_state <= s3;
			when s3 =>
				    next_state <= s4;
			when s4 =>
				    addr_r <= addr_r + x"20";
				    INPUT_KEY <= din;
				    next_state <= s5;
			when s5 =>
				    next_state <= s0;
                    addr_r <= x"00000020";    
------------WRITE_from_registers_to_memory-------------------------------------------------------------------------------------------------
            when s6 =>
				next_state <= s7;
			when s7 =>
			    addr_r <= x"000000A0";
			    web <= (others=>'1'); 
                next_state <= s8;
            when s8 =>
				    next_state <= s9;    
            when s9 =>
                dout_i <= LOAD_ID;
                --wait for memory
                if  counter = 10 then
                    counter <= (others=>'0');
                else
                    counter <= counter + 1;
                    next_state <= s9;
                end if;
                if  counter = 10 then
                    addr_r <= addr_r + x"20";
                    next_state <= s10;
                end if;
            when s10 =>
                    counter2 <= counter2 + 1;
				    next_state <= s11;
            when s11 =>
                dout_i <= LOAD_KEY;
                --wait for memory
                if  counter1 = 10 then
                    counter1 <= (others=>'0');
                else
                    counter1 <= counter1 + 1;
                    next_state <= s11;
                end if;
                if counter1 = 10 then
                    next_state <= s12;
				    --addr_r <= x"00000020";
				    --ADD_position <= addr_r;
				    --web <= (others=>'0');
                end if;
             when s12 =>
--                    if counter2 = 5 then
                        dout_i <= x"0000000000000000000000000000000000000000000000000000000000000000";
                        addr_r <= x"00000020";
				        next_state <= s0;
--				    else
--				        next_state <= s6;
--                    end if;
------------WRITE_FROM_MEMORY-------------------------------------------------------------------------------------------------
            when s13 =>
				    next_state <= s14; 
			when s14 =>
			        addr_r <= addr_r + x"20";
                    TABLE_OUTPUT <= din;
                    next_state <= s15;
            when s15 =>
                    next_state <= s0;
                    addr_r <= x"00000020";       				    
-------------------------------------------------------------------------------------------------------------  
            when s16 =>
				next_state <= s17;
			when s17 =>
			    addr_r <= x"000000A0";
			    web <= (others=>'1'); 
                next_state <= s18;
            when s18 =>
				    next_state <= s19;    
            when s19 =>
                dout_i <= TABLE_INPUT;
                --wait for memory
                if  counter3 = 40 then
                    counter3 <= (others=>'0');
                else
                    counter3 <= counter3 + 1;
                    next_state <= s19;
                end if;
                if  counter3 = 40 then
                    --addr_r <= addr_r + x"20";
                    next_state <= s20;
                end if;
             when s20 =>
                dout_i <= x"0000000000000000000000000000000000000000000000000000000000000000";
                addr_r <= x"00000020";
				next_state <= s0;
                    
--------------check id for operation----------------------------------------------------
--            when s0 =>  
--              --addr_r <= x"00000020";
--				web <= (others=>'0');
--------------read_from_address_sequentially----------------------------------------------------------------------------
--                if  din(127 downto 0) = Read_Address_Sequentially then
--                    val <= din(255 downto 128);
--                    if val /= din(255 downto 128) then 
--                        next_state <= s1;
--                        addr_r <= addr_r + x"20";  
--                    else
--                        next_state <= s0;
--                        addr_r <= x"00000020";    
--                    end if;
--------------GO_back_to_initial_address----------------------------------------------------------------------------
--                elsif   din(127 downto 0) = Read_initial_address then
--                    next_state <= s1;
--                    addr_r <= addr_r + x"20";  
--------------WRITE_on_top_of_memory----------------------------------------------------------------------------
--                elsif   din(127 downto 0) = WRITE_on_top_of_memory then
--                    val <= din(255 downto 128);
--                    if val /= din(255 downto 128) then 
--                        addr_r <= ADD_position + x"20";
--                    web <= (others=>'1');
--                    next_state <= s6; 
--                    else
--                        next_state <= s0;
--                        addr_r <= x"00000020";    
--                    end if;
                    
----                    addr_r <= ADD_position + x"20";
----                    web <= (others=>'1');
----                    next_state <= s6;
--------------Over_write_memory--------------------------------------------------------------------------------
--                elsif   din(127 downto 0) = Over_write_memory then
--                    addr_r <= x"00000020";
--                    web <= (others=>'1');
--                    next_state <= s6;
--				end if;	
-------------State_logic--------------------------------------------------------------------------------------
--			when s1 => 
--				next_state <= s2;
--			when s2 =>
--				addr_r <= addr_r + x"20";
--                INPUT_ID <= din;
--                next_state <= s3;
--			when s3 =>
--				next_state <= s4;
--			when s4 => 
--				addr_r <= addr_r + x"20";
--				INPUT_KEY <= din;
--				next_state <= s5;
--			when s5 => 
-------------- Wait for the RAM --------------------------------------------------------------------------
--                next_state <= s0;
--                ADD_position <= addr_r;
----------------------------------------------------------------------------------------------------------               
---------------Writing_state_logic---------------------------------------------------------------------- 
---------------Load_id_---------------------------------------------------------------------------------           
--            when s6 =>
--                dout_i <= LOAD_ID;
--                --wait for memory
--                if counter = 5 then
--                    counter <= (others=>'0');
--                else
--                    counter <= counter + 1;
--                    next_state <= s6;
--                end if;
--                if counter = 5 then
--                    addr_r <= addr_r + x"20";
--                    next_state <= s7;
--                end if;
---------------Load_key---------------------------------------------------------------------------------                   
--             when s7 =>
--                dout_i <= LOAD_KEY;
--                --wait for memory
--                if counter1 = 5 then
--                    counter1 <= (others=>'0');
--                else
--                    counter1 <= counter1 + 1;
--                    next_state <= s7;
--                end if;
--                if counter1 = 5 then
--                    next_state <= s8;
--                end if;
--              when s8 =>
--                next_state <= s0;
            end case;
    end if;
end process;

end Behavioral;
