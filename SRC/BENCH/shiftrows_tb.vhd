library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library LIB_AES;
use LIB_AES.crypt_pack.all;
library LIB_RTL;


entity shiftrows_tb is

end entity shiftrows_tb;




architecture shiftrows_tb_arch of shiftrows_tb is

component shiftrows
	port (
		etat_i : in type_state;		
		etat_o : out type_state
	);

end component;

signal data_i_s, data_o_s : type_state;

begin

DUT : shiftrows port map
	(
		etat_i => data_i_s,
		etat_o => data_o_s
	);


data_i_s <= ( ( X"AF", X"16", X"CE", X"BC") , ( X"44", X"E6", X"91", X"62") , ( X"D3", X"20", X"01", X"06") , ( X"AB", X"B1", X"AE", X"D5") );

end architecture shiftrows_tb_arch;


configuration shiftrows_tb_conf of shiftrows_tb is
	for shiftrows_tb_arch
		for DUT : shiftrows
			use entity LIB_RTL.shiftrows(shiftrows_arch);
		end for;
	end for;
end configuration shiftrows_tb_conf;




