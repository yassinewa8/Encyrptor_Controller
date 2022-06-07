-----------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_misc.all;
use ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;
use work.all;

entity KEY_Register is
	port(
		clk : in STD_LOGIC;
		rst : in STD_LOGIC;
		KEY_IN : in STD_LOGIC_VECTOR ( 255 downto 0 );  	--take key from input
		KEY_OUT : out std_logic_vector(255 downto 0);   	--output key to encryptor
		SAVE_KEY : out std_logic_vector(255 downto 0)		--send key to BRAM/PCIE
);
end KEY_Register;

architecture dataflow of KEY_Register is

begin
	process(clk,rst)
	begin
		if 	rst = '1' then
			KEY_OUT <= (others=>'0');
			SAVE_KEY <= (others=>'0');
		elsif rising_edge(clk) then
		    SAVE_KEY <= KEY_IN;  
			KEY_OUT <= KEY_IN;
	    end if;
    end process;
end dataflow;