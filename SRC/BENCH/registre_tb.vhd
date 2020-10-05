library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library LIB_AES;
use LIB_AES.crypt_pack.all;
library LIB_RTL;


entity registre_tb is

end entity registre_tb;


architecture registre_tb_arch of registre_tb is

component registre
	port (
		clk_i : in std_logic;
		data_i : in type_state;
		resetb_i : in std_logic;
		data_o : out type_state
	);
end component registre;

signal data_i_s, data_o_s : type_state;
signal resetb_i_s : std_logic := '1';
signal clk_i_s : std_logic := '0';

begin

DUT : registre port map (
			clk_i => clk_i_s,
			data_i => data_i_s,
			resetb_i => resetb_i_s,
			data_o => data_o_s
			);


clk_i_s <= not clk_i_s after 100 ns;
data_i_s <= ( (X"2B", X"15", X"DE", X"37"), (X"49", X"DC", X"B3", X"B8"), (X"34", X"E5", X"2E", X"3D"), (X"30", X"9A", X"B6", X"51") );
resetb_i_s <= not resetb_i_s after 400 ns;

end architecture registre_tb_arch;



configuration registre_tb_conf of registre_tb is
	for registre_tb_arch
		for DUT : registre
			use entity LIB_RTL.registre(register_arch);
		end for;
	end for;
end configuration registre_tb_conf;


