-------------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_misc.all;
use ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;
use work.all;

entity switching_table is
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
end switching_table;
architecture dataflow of switching_table is

signal sigma : std_logic_vector(255 downto 0);
signal Prevoius_witch_map : std_logic_vector(255 downto 0);

type RAM is array (0 to 31) of std_logic_vector(7 downto 0);
signal r_Mem : RAM;

signal counter : unsigned(31 downto 0);

begin

sigma   <=  TABLE_IN;
process(clk)
begin

if rising_edge(clk) and sigma  /= x"0000000000000000000000000000000000000000000000000000000000000000" then


                r_Mem(0) <= TABLE_IN( 255 downto 248);
                r_Mem(1) <= TABLE_IN( 247 downto 240);
                r_Mem(2) <= TABLE_IN( 239 downto 232);
                r_Mem(3) <= TABLE_IN( 231 downto 224);
                
                r_Mem(4) <= TABLE_IN( 223 downto 216);
                r_Mem(5) <= TABLE_IN( 215 downto 208);
                r_Mem(6) <= TABLE_IN( 207 downto 200);
                r_Mem(7) <= TABLE_IN( 199 downto 192);
                
                r_Mem(8) <= TABLE_IN( 191 downto 184);
                r_Mem(9) <= TABLE_IN( 183 downto 176);
                r_Mem(10) <= TABLE_IN( 175 downto 168);
                r_Mem(11) <= TABLE_IN( 167 downto 160);
                
                r_Mem(12) <= TABLE_IN( 159 downto 152);
                r_Mem(13) <= TABLE_IN( 151 downto 144);
                r_Mem(14) <= TABLE_IN( 143 downto 136);
                r_Mem(15) <= TABLE_IN( 135 downto 128);
                
                r_Mem(16) <= TABLE_IN( 127 downto 120);
                r_Mem(17) <= TABLE_IN( 119 downto 112);
                r_Mem(18) <= TABLE_IN( 111 downto 104);
                r_Mem(19) <= TABLE_IN( 103 downto 96);
                
                r_Mem(20) <= TABLE_IN( 95 downto 88);
                r_Mem(21) <= TABLE_IN( 87 downto 80);
                r_Mem(22) <= TABLE_IN( 79 downto 72);
                r_Mem(23) <= TABLE_IN( 71 downto 64);
                
                r_Mem(24) <= TABLE_IN( 63 downto 56);
                r_Mem(25) <= TABLE_IN( 55 downto 48);
                r_Mem(26) <= TABLE_IN( 47 downto 40);
                r_Mem(27) <= TABLE_IN( 39 downto 32);
                
                r_Mem(28) <= TABLE_IN( 31 downto 24);
                r_Mem(29) <= TABLE_IN( 23 downto 16);
                r_Mem(30) <= TABLE_IN( 15 downto 8);
                r_Mem(31) <= TABLE_IN( 7 downto 0);
                
                

      end if;
end process;     






process(clk,rst)
	begin
	if 	rst = '1' then
	
	
	

            PORT0 <=  b"00000000";
            PORT1 <=  b"00000000";
            PORT2 <=  b"00000000";
            PORT3 <=  b"00000000";
                  
            PORT4 <=  b"00000000";
            PORT5 <=  b"00000000";
            PORT6 <=  b"00000000";
            PORT7 <=  b"00000000";
                  
            PORT8 <=  b"00000000";
            PORT9 <=  b"00000000";
            PORT10<=  b"00000000";
            PORT11<=  b"00000000";
            
            PORT12<=  b"00000000";
            PORT13<=  b"00000000";
            PORT14<=  b"00000000";
            PORT15<=  b"00000000";
                  
            PORT16<=  b"00000000";
            PORT17<=  b"00000000";
            PORT18<=  b"00000000";
            PORT19<=  b"00000000";
                  
            PORT20<=  b"00000000";
            PORT21<=  b"00000000";
            PORT22<=  b"00000000";
            PORT23<=  b"00000000";
                  
            PORT24<=  b"00000000";
            PORT25<=  b"00000000";
            PORT26<=  b"00000000";
            PORT27<=  b"00000000";
                  
            PORT28<=  b"00000000";
            PORT29<=  b"00000000";
            PORT30<=  b"00000000";
            PORT31<=  b"00000000";
            
		elsif rising_edge(clk) then
	           
	
	        
	        
	        
            
        
                        
                    
                  TABLE_OUT( 255 downto 248)    <=       r_Mem(0);
                  TABLE_OUT( 247 downto 240)    <=       r_Mem(1);
                  TABLE_OUT( 239 downto 232)    <=       r_Mem(2);
                  TABLE_OUT( 231 downto 224)    <=       r_Mem(3);
                                              
	              TABLE_OUT( 223 downto 216)    <=       r_Mem(4);
	              TABLE_OUT( 215 downto 208)    <=       r_Mem(5);
	              TABLE_OUT( 207 downto 200)    <=       r_Mem(6);
	              TABLE_OUT( 199 downto 192)    <=       r_Mem(7);
	                                           
	              TABLE_OUT( 191 downto 184)    <=       r_Mem(8) ;
	              TABLE_OUT( 183 downto 176)    <=       r_Mem(9) ;
	               TABLE_OUT( 175 downto 168)   <=       r_Mem(10);
	               TABLE_OUT( 167 downto 160)   <=       r_Mem(11);
	                                          
	               TABLE_OUT( 159 downto 152)   <=       r_Mem(12);
	               TABLE_OUT( 151 downto 144)   <=       r_Mem(13);
	               TABLE_OUT( 143 downto 136)   <=       r_Mem(14);
	               TABLE_OUT( 135 downto 128)   <=       r_Mem(15);
	                                      
	               TABLE_OUT( 127 downto 120)   <=       r_Mem(16);
	               TABLE_OUT( 119 downto 112)   <=       r_Mem(17);
	               TABLE_OUT( 111 downto 104)   <=       r_Mem(18);
	               TABLE_OUT( 103 downto 96)    <=       r_Mem(19);
	                                                    
	               TABLE_OUT( 95 downto 88)     <=       r_Mem(20);
	               TABLE_OUT( 87 downto 80)     <=       r_Mem(21);
	               TABLE_OUT( 79 downto 72)     <=       r_Mem(22);
	               TABLE_OUT( 71 downto 64)     <=       r_Mem(23);
	                                         
	               TABLE_OUT( 63 downto 56)     <=       r_Mem(24);
	               TABLE_OUT( 55 downto 48)     <=       r_Mem(25);
	               TABLE_OUT( 47 downto 40)     <=       r_Mem(26);
	               TABLE_OUT( 39 downto 32)     <=       r_Mem(27);
	                                           
	               TABLE_OUT( 31 downto 24)     <=       r_Mem(28);
	               TABLE_OUT( 23 downto 16)     <=       r_Mem(29);
	               TABLE_OUT( 15 downto 8)      <=       r_Mem(30);
	               TABLE_OUT( 7 downto 0)       <=       r_Mem(31);
	            
	            
	            
	            
	            
	            
	            
	            
	            
	            
	            
	            
	            
	            
	            
	            
	            
	            
	            
                PORT0 <=  r_Mem(0) ;
                PORT1 <=  r_Mem(1) ;
                PORT2 <=  r_Mem(2) ;
                PORT3 <=  r_Mem(3) ;
                      
                PORT4 <=  r_Mem(4) ;
                PORT5 <=  r_Mem(5) ;
                PORT6 <=  r_Mem(6) ;
                PORT7 <=  r_Mem(7) ;
                      
                PORT8 <=  r_Mem(8) ;
                PORT9 <=  r_Mem(9) ;
                PORT10<=  r_Mem(10);
                PORT11<=  r_Mem(11);
                      
                PORT12<=  r_Mem(12);
                PORT13<=  r_Mem(13);
                PORT14<=  r_Mem(14);
                PORT15<=  r_Mem(15);
                      
                PORT16<=  r_Mem(16);
                PORT17<=  r_Mem(17);
                PORT18<=  r_Mem(18);
                PORT19<=  r_Mem(19);
                      
                PORT20<=  r_Mem(20);
                PORT21<=  r_Mem(21);
                PORT22<=  r_Mem(22);
                PORT23<=  r_Mem(23);
                      
                PORT24<=  r_Mem(24);
                PORT25<=  r_Mem(25);
                PORT26<=  r_Mem(26);
                PORT27<=  r_Mem(27);
                      
                PORT28<=  r_Mem(28);
                PORT29<=  r_Mem(29);
                PORT30<=  r_Mem(30);
                PORT31<=  r_Mem(31);     
                
               
           
        end if;
    end process;
end dataflow;


--r_Mem(1(0 to 7)) <= some_value;

--	process(clk,rst)
--	begin
--		if 	rst = '1' then
--			SAVE_switch <= (others=>'0');
--			--switcher <= (others=>'0');
--			sigma <= (others=>'0');
--			counter <= (others=>'0');
--			Prevoius_witch_map <= (others=>'0');
--			next_state <= s0;
			
			
--		elsif rising_edge(clk) then 
--		  case next_state is
--		      when s0 =>
--		        sigma <= switch_IN;
--		        if    sigma  /= x"0000000000000000000000000000000000000000000000000000000000000000" then 
--		             if switch_IN/= Prevoius_witch_map then
--                        SAVE_switch <= switch_IN;
--                        sigma <= switch_IN;
--                        next_state <= s1;
--                     else 
--                        next_state <= s0;
--                     end if;
--                 else
--                      next_state <= s0;   
--                end if;  
-----------------------------------------------------------------------------------
--              when s1 =>
--                --switcher( 7 downto 0 ) <= sigma(7 downto 0);
--                --sigma(7 downto 0) <= b"00000000";
--                next_state <= s2;
-----------------------------------------------------------------------------------
--              when s2 =>        
--                sigma( 247 downto 0 )<=sigma( 255 downto 8 );
--                sigma( 255 downto 248 ) <= b"00000000";
--                next_state <= s1;
--                if sigma (255 downto 0) =  x"0000000000000000000000000000000000000000000000000000000000000000" then
--                    Prevoius_witch_map <= switch_IN;
--                    next_state <= s0;
--                end if;
--            end case;
--        end if;
--    end process;
--end dataflow;

-------------------------------------------------------------------------------------------

--PORT0 <=  r_Mem(0) ;
--PORT1 <=  r_Mem(1) ;
--PORT2 <=  r_Mem(2) ;
--PORT3 <=  r_Mem(3) ;
      
--PORT4 <=  r_Mem(4) ;
--PORT5 <=  r_Mem(5) ;
--PORT6 <=  r_Mem(6) ;
--PORT7 <=  r_Mem(7) ;
      
--PORT8 <=  r_Mem(8) ;
--PORT9 <=  r_Mem(9) ;
--PORT10<=  r_Mem(10);
--PORT11<=  r_Mem(11);
      
--PORT12<=  r_Mem(12);
--PORT13<=  r_Mem(13);
--PORT14<=  r_Mem(14);
--PORT15<=  r_Mem(15);
      
--PORT16<=  r_Mem(16);
--PORT17<=  r_Mem(17);
--PORT18<=  r_Mem(18);
--PORT19<=  r_Mem(19);
      
--PORT20<=  r_Mem(20);
--PORT21<=  r_Mem(21);
--PORT22<=  r_Mem(22);
--PORT23<=  r_Mem(23);
      
--PORT24<=  r_Mem(24);
--PORT25<=  r_Mem(25);
--PORT26<=  r_Mem(26);
--PORT27<=  r_Mem(27);
      
--PORT28<=  r_Mem(28);
--PORT29<=  r_Mem(29);
--PORT30<=  r_Mem(30);
--PORT31<=  r_Mem(31);






