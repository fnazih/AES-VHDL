-- Date :  /  /  
-- Title : shiftrows.vhd
-- Name : Fatima-Zohra NAZIH
-- Function : this function switches some of the bytes of the type_state rows

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library LIB_AES;
use LIB_AES.crypt_pack.all;



entity shiftrows is
	port (
		etat_i : in type_state;
		etat_o : out type_state
		);
end entity shiftrows;


architecture shiftrows_arch of shiftrows is

begin

G1 : for i in 0 to 3 generate		-- manually switching each byte with its equivalent 
	if1 : if (i = 0) generate
		G2 : for j in  0 to 3 generate
			etat_o(i)(j) <= etat_i(i)(j);		-- no change concerning the first line
		end generate G2;
	end generate if1;
	if2 : if (i = 1) generate				-- shift of one byte to the left
		etat_o(i)(0) <= etat_i(i)(1);
		etat_o(i)(1) <= etat_i(i)(2);
		etat_o(i)(2) <= etat_i(i)(3);
		etat_o(i)(3) <= etat_i(i)(0);
	end generate if2;
	if3 : if (i = 2) generate				-- shift of two bytes to the left
		etat_o(i)(0) <= etat_i(i)(2);
		etat_o(i)(1) <= etat_i(i)(3);
		etat_o(i)(2) <= etat_i(i)(0);
		etat_o(i)(3) <= etat_i(i)(1);
	end generate if3;
	if4 : if (i = 3) generate				-- shift of three bytes to the left
		etat_o(i)(0) <= etat_i(i)(3);
		G5 : for m in  1 to 3 generate
			etat_o(i)(m) <= etat_i(i)(m - 1);
		end generate G5;
	end generate if4;			
end generate G1;

end  shiftrows_arch;
