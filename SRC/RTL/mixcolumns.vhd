-- Date :  /  /  
-- Title : mixcolumns.vhd
-- Name : Fatima-Zohra NAZIH
-- Function : this function multiplies the input type_state with the chosen Rijndael matrix

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library LIB_AES;
use LIB_AES.crypt_pack.all;
library LIB_RTL;


entity mixcolumns is
	port (
		etat_i : in type_state;
		mix_i : in std_logic;
		etat_o : out type_state
	);
end entity mixcolumns;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library LIB_AES;
use LIB_AES.crypt_pack.all;
library LIB_RTL;


architecture mixcolumns_arch of mixcolumns is

signal etat2 : type_state;		-- will create the input matrix multiplied by two
signal etat3 : type_state;		-- will create the input matrix multiplied by three
signal etat_o_s : type_state;

begin

G1 : for i in 0 to 3 generate		-- x2 : the result depends on the MSB (check report for explanation)
	G2 : for j in 0 to 3 generate
		etat2(i)(j) <= etat_i(i)(j)(6 downto 0)&'0' when (etat_i(i)(j)(7) = '0') else etat_i(i)(j)(6 downto 0)&'0' xor b"00011011";
	end generate G2;
end generate G1;


G5 : for i in 0 to 3 generate		-- x3 = x2 XOR x1
	G6 : for j in 0 to 3 generate
		etat3(i)(j) <= etat_i(i)(j) xor etat2(i)(j);
	end generate G6;
end generate G5;

GTOT : for i in 0 to 3 generate		-- these choices depend on the Rijndael matrix; ours is : ( (2, 3, 1, 1), (1, 2, 3, 1), (1, 1, 2, 3), (3, 1, 1, 2) );
	etat_o_s(0)(i) <= etat2(0)(i) xor etat3(1)(i) xor etat_i(2)(i) xor etat_i(3)(i);
	etat_o_s(1)(i) <= etat_i(0)(i) xor etat2(1)(i) xor etat3(2)(i) xor etat_i(3)(i);
	etat_o_s(2)(i) <= etat_i(0)(i) xor etat_i(1)(i) xor etat2(2)(i) xor etat3(3)(i);
	etat_o_s(3)(i) <= etat3(0)(i) xor etat_i(1)(i) xor etat_i(2)(i) xor etat2(3)(i);
end generate GTOT;

etat_o <= etat_o_s when mix_i = '1' else etat_i;	-- mux created to consider the last round where mixcolumns is disabled

end architecture mixcolumns_arch;


