-- Date :  /  /  
-- Title : convert_to_state.vhd
-- Name : Fatima-Zohra NAZIH
-- Function : this function takes a bit128 input and converts it into a type_state

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library LIB_AES;
use LIB_AES.crypt_pack.all;
library LIB_RTL;


entity convert_to_state is
	port (
		text_i : in bit128;
		etat_o : out type_state
		);
end entity convert_to_state;


architecture convert_to_state_arch of convert_to_state is

signal etat_o_s : type_state;

begin

P0 : process
begin
	for i in 0 to 3 loop
		for j in 0 to 3 loop
			etat_o_s(i)(j) <= text_i((127 - (4*j + i)*8) downto (127 - ((4*j + i)*8 + 7)));		-- creating the output type_state using the different indexes 
		end loop;
	end loop;
wait for 10 ns;
end process P0;

etat_o <= etat_o_s;

end architecture convert_to_state_arch;
