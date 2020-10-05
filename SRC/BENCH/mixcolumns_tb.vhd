library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library LIB_AES;
use LIB_AES.crypt_pack.all;
library LIB_RTL;


entity mixcolumns_tb is

end entity mixcolumns_tb;

architecture mixcolumns_tb_arch of mixcolumns_tb is
component mixcolumns
	port (
		etat_i : in type_state;
		mix_i : in std_logic;
		etat_o : out type_state
	);
end component mixcolumns;

signal etat_i_s, etat_o_s : type_state;
signal mix_i_s : std_logic;

begin

DUT : mixcolumns port map (
		etat_i => etat_i_s,
		mix_i => mix_i_s,
		etat_o => etat_o_s
	);

etat_i_s <= ( ( X"AF", X"16", X"CE", X"BC"),
	      ( X"E6", X"91", X"62", X"44"),
	      ( X"01", X"06", X"D3", X"20"),
	      ( X"D5", X"AB", X"B1", X"AE") );
mix_i_s <= '1', '0' after 200 ns;

end architecture mixcolumns_tb_arch;


configuration mixcolumns_tb_conf of mixcolumns_tb is
	for mixcolumns_tb_arch
		for DUT : mixcolumns
			use entity LIB_RTL.mixcolumns(mixcolumns_arch);
		end for;
	end for;
end configuration mixcolumns_tb_conf;



