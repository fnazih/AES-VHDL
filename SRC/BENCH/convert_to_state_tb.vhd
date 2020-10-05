library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library LIB_AES;
use LIB_AES.crypt_pack.all;
library LIB_RTL;



entity convert_to_state_tb is

end entity convert_to_state_tb;


architecture convert_to_state_tb_arch of convert_to_state_tb is

component convert_to_state
	port (
		text_i : in bit128;
		etat_o : out type_state
	);
end component convert_to_state;

signal etat_o_s : type_state;
signal text_i_s : bit128 := "01010010010101100111001101110100011011110010000001100101011011100010000001110110011010010110110001101100011001010010000000111111";

begin

DUT : convert_to_state port map (
		text_i => text_i_s,
		etat_o => etat_o_s
	);

end architecture convert_to_state_tb_arch;


configuration convert_to_state_tb_conf of convert_to_state_tb is
	for convert_to_state_tb_arch
		for DUT : convert_to_state
			use entity LIB_RTL.convert_to_state(convert_to_state_arch);
		end for;
	end for;
end configuration convert_to_state_tb_conf;


