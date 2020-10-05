-- Date :  /  /  
-- Title : convert_to_bit128.vhd
-- Name : Fatima-Zohra NAZIH
-- Function : this function takes a type_state input and converts it into a bit128

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library LIB_AES;
use LIB_AES.crypt_pack.all;
library LIB_RTL;


entity convert_to_bit128 is
	port (
		etat_i : in type_state;
		text_o : out bit128
		);
end entity convert_to_bit128;


architecture convert_to_bit128_arch of convert_to_bit128 is

signal text_o_s : bit128;

begin

	pro2 : process
		begin
		loop1 : for i in 0 to 3 loop
			loop2 : for j in 0 to 3 loop
				text_o_s(127 - (4*j + i)*8 downto 127 - ((4*j + i)*8 + 7)) <= etat_i(i)(j);		-- creating the output type_state using the different indexes
			end loop loop2;
		end loop loop1;
		wait for 5 ns;
	end process pro2;

text_o <= text_o_s;

end architecture convert_to_bit128_arch;
