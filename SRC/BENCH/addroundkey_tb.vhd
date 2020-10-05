library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library LIB_AES;
use LIB_AES.crypt_pack.all;
library LIB_RTL;


entity addroundkey_tb is

end entity addroundkey_tb;


architecture addroundkey_tb_arch of addroundkey_tb is

component addroundkey
	port (
		etat_i, key_i : in type_state;
		etat_o : out type_state
	);

end component addroundkey;

signal etat_i_s, key_i_s, etat_o_s : type_state;

begin

DUT : addroundkey port map
	(
		etat_i => etat_i_s, 
		key_i => key_i_s,
		etat_o => etat_o_s
	);

etat_i_s <= ( ( X"52", X"6F", X"20", X"6C"), ( X"65", X"20", X"76", X"65"), ( X"73", X"65", X"69", X"20"), ( X"74", X"6E", X"6C", X"3F") );
key_i_s <= ( ( X"2B", X"28", X"AB", X"09"), ( X"7E", X"AE", X"F7", X"CF"), ( X"15", X"D2", X"15", X"4F"), ( X"16", X"A6", X"88", X"3C") );

end architecture addroundkey_tb_arch;


configuration addroundkey_tb_conf of addroundkey_tb is
	for addroundkey_tb_arch
		for DUT : addroundkey
			use entity LIB_RTL.addroundkey(addroundkey_arch);
		end for;
	end for;
end configuration addroundkey_tb_conf;

