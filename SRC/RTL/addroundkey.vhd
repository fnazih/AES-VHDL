-- Date :  /  /  
-- Title : addroundkey.vhd
-- Name : Fatima-Zohra NAZIH
-- Function : this function makes a XOR operation bit by bit between the round key and the input type_state

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library LIB_AES;
use LIB_AES.crypt_pack.all;


entity addroundkey is
	port (
		etat_i, key_i : in type_state;
		etat_o : out type_state 
	);
end entity addroundkey;


architecture addroundkey_arch of addroundkey is

begin

	G1 : for i in 0 to 3 generate
		G2 : for j in 0 to 3 generate
			G3 : for k in 0 to 7 generate
				etat_o(i)(j)(k) <= etat_i(i)(j)(k) xor key_i(i)(j)(k);		-- simple XOR operation bit by bit between the input state and key
			end generate G3;
		end generate G2;
	end generate G1;

end architecture addroundkey_arch;
