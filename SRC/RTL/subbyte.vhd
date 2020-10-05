-- Date :  /  /  
-- Title : subbyte.vhd
-- Name : Fatima-Zohra NAZIH
-- Function : Transforms each byte into its image according to the chosen sbox

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library LIB_AES;
use LIB_AES.crypt_pack.all;
library LIB_RTL;

entity subbyte is
	port (
		etat_i : in type_state;
		etat_o : out type_state
		);
end entity subbyte;



architecture subbyte_arch of subbyte is

component sbox
	port
	(
		data_i : in bit8;
		data_o : out bit8
	);
end component sbox;

type rang is array(0 to 15) of bit8;

signal data_i_s, data_o_s : rang;

begin

G1 : for i in 0 to 15 generate		-- mapping each block of the arrays to the 16 sboxes generated
	inter : sbox port map (
		data_i => data_i_s(i),
		data_o => data_o_s(i)
		);
end generate G1;

G2 : for j in 0 to 3 generate		-- connecting the sbox components to the i/o type_states to complete the conversion
	G3 : for k in 0 to 3 generate
		data_i_s(4*j + k) <= etat_i(j)(k);
		etat_o(j)(k) <= data_o_s(4*j + k);
	end generate G3;
end generate G2;

end architecture subbyte_arch;

library LIB_RTL;
use LIB_RTL.all;

configuration subbyte_conf of subbyte is 
	for subbyte_arch
		for G1
			for all : sbox
				use entity LIB_RTL.sbox(sbox_arch);
			end for;
		end for;
	end for;
end configuration;


