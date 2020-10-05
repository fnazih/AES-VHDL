library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library LIB_RTL;
use LIB_RTL.all;
library LIB_AES;
use LIB_AES.crypt_pack.all;


entity subbyte_tb is

end entity subbyte_tb;


architecture subbyte_tb_arch of subbyte_tb is

component subbyte
	port (
		etat_i : in type_state;
		etat_o : out type_state
		);
end component;

signal etat_i_s, etat_o_s : type_state;

begin

DUT : subbyte port map (
	etat_i => etat_i_s,
	etat_o => etat_o_s
	);

 etat_i_s <= ( (X"34", X"5D", X"12", X"AA") , (X"45", X"34", X"5D", X"12") , (X"AA", X"45", X"34", X"5D") , (X"12", X"AA", X"45", X"55") );


end architecture subbyte_tb_arch;


configuration subbyte_tb_conf of subbyte_tb is
	for subbyte_tb_arch
		for DUT : subbyte
			use entity LIB_RTL.subbyte(subbyte_arch);
		end for;
	end for;
end configuration subbyte_tb_conf;


