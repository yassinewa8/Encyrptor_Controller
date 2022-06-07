-------------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_misc.all;
use ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;
use work.all;

entity ID_Register is
	port(
		clk : in STD_LOGIC;
		rst : in STD_LOGIC;
		ID_IN : in STD_LOGIC_VECTOR (255 downto 0);
		ID_OUT :out std_logic_vector(255 downto 0);
		SAVE_ID: out std_logic_vector(255 downto 0)
	);
end ID_Register;

architecture dataflow of ID_Register is


begin
	process(clk,rst)
	begin
		if 	rst = '1' then
			ID_OUT <= (others=>'0');
			SAVE_ID <= (others=>'0');
		elsif rising_edge(clk) then
			ID_OUT <= ID_IN;
			SAVE_ID <= ID_IN;
	    end if;
    end process;

end dataflow;