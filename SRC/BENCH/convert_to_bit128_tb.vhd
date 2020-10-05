library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library LIB_AES;
use LIB_AES.crypt_pack.all;
library LIB_RTL;


entity convert_to_bit128_tb is

end entity convert_to_bit128_tb;


architecture convert_to_bit128_tb_arch of convert_to_bit128_tb is

component convert_to_bit128
	port (
		etat_i : in type_state;
		text_o : out bit128
	);
end component convert_to_bit128;

signal etat_i_s : type_state := ( (X"52", X"65", X"73", X"74"), (X"6F", X"20", X"65", X"6E"), (X"20", X"76", X"69", X"6C"), (X"6C", X"65", X"20", X"3F") );
signal text_o_s : bit128;

begin

DUT : convert_to_bit128 port map (
		etat_i => etat_i_s,
		text_o => text_o_s
	);


end architecture convert_to_bit128_tb_arch;


configuration convert_to_bit128_tb_conf of convert_to_bit128_tb is
	for convert_to_bit128_tb_arch
		for DUT : convert_to_bit128
			use entity LIB_RTL.convert_to_bit128(convert_to_bit128_arch);
		end for;
	end for;
end configuration convert_to_bit128_tb_conf;

