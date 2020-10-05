library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library LIB_AES;
use LIB_AES.crypt_pack.all;
library LIB_RTL;


entity compteur_tb is

end entity compteur_tb;


architecture compteur_tb_arch of compteur_tb is

component compteur
	port (
		clk_i : in std_logic;
		resetb_i : in std_logic;
		enable_i : in std_logic;
		init_i : in std_logic;
		count_o : out integer range 0 to 10
		);
end component compteur;

signal clk_i_s : std_logic := '0';
signal resetb_i_s : std_logic := '1';
signal enable_i_s : std_logic := '1';
signal init_i_s : std_logic := '0';
signal count_o_s : integer range 0 to 10;

begin

DUT : compteur port map (
			clk_i => clk_i_s,
			resetb_i => resetb_i_s,
			enable_i => enable_i_s,
			init_i => init_i_s,
			count_o => count_o_s
			);

clk_i_s <= not clk_i_s after 50 ns;
resetb_i_s <= '0' after 800 ns;
enable_i_s <= '0' after 400 ns, '1' after 440 ns;
init_i_s <= '1' after 80 ns, '0' after 120 ns;

end architecture compteur_tb_arch;


configuration compteur_tb_conf of compteur_tb is
	for compteur_tb_arch 
		for DUT : compteur
			use entity LIB_RTL.compteur(compteur_arch);
		end for;
	end for;
end configuration compteur_tb_conf;
