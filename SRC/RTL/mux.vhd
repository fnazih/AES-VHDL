library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library LIB_AES;
use LIB_AES.crypt_pack.all;
library LIB_RTL;


entity mux is
	port (
		text_i : in type_state;
		mc_o : in type_state;
		enableRoundComputing_i : in std_logic;
		mux_o : out type_state
		);
end entity mux;


architecture mux_arch of mux is

begin

mux_o <= text_i when enableRoundComputing_i = '0' else mc_o;

end architecture mux_arch;
