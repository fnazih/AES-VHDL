library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library LIB_AES;
use LIB_AES.crypt_pack.all;
library LIB_RTL;


entity AESround is
	port (
		text_i : in bit128;
		currentKey_i : in bit128;
		clk_i : in std_logic;
		resetb_i : in std_logic;
		mix_i : in std_logic;
		enableRoundComputing_i : in std_logic;
		aes_end_i : in std_logic;
		cipher_o : out bit128
		);
end entity AESround;


architecture AESround_arch of AESround is

component subbyte
	port
	(
		etat_i : in type_state;
		etat_o : out type_state
	);
end component subbyte;

component shiftrows
	port (
		etat_i : in type_state;
		etat_o : out type_state
		);
end component shiftrows;


component mixcolumns
	port (
		etat_i : in type_state;
		mix_i : in std_logic;
		etat_o : out type_state
	);
end component mixcolumns;

component addroundkey
	port (
		etat_i, key_i : in type_state;
		etat_o : out type_state 
	);
end component addroundkey;

component registre
	port (
		clk_i : in std_logic;
		data_i : in type_state;
		resetb_i : in std_logic;
		data_o : out type_state
		);
end component registre;

component convert_to_state
	port (
		text_i : in bit128;
		etat_o : out type_state
	);
end component convert_to_state;

component convert_to_bit128
	port (
		etat_i : in type_state;
		text_o : out bit128
	);
end component convert_to_bit128;

component mux
	port (
		text_i : in type_state;
		mc_o : in type_state;
		enableRoundComputing_i : in std_logic;
		mux_o : out type_state
	);
end component mux;

signal convert_key_s, sb_o_s, sr_o_s, mc_o_s, ark_o_s, aes_output_s, plain_text_state_s, mux_o_s, mux2_o_s : type_state;
signal state_null : type_state := ( (X"00", X"00", X"00", X"00"), (X"00", X"00", X"00", X"00"), (X"00", X"00", X"00", X"00"), (X"00", X"00", X"00", X"00") );

begin

DUT : subbyte port map (
		etat_i => aes_output_s,
		etat_o => sb_o_s
	);

DUT1 : shiftrows port map (
	etat_i => sb_o_s,
	etat_o => sr_o_s
	);

DUT2 : mixcolumns port map (
	etat_i => sr_o_s,
	mix_i => mix_i,
	etat_o => mc_o_s
	);

DUT3 : addroundkey port map (
		etat_i => mux_o_s,
		key_i => convert_key_s,
		etat_o => ark_o_s
	);


DUT4 : registre port map (
		clk_i => clk_i,
		data_i => ark_o_s,
		resetb_i => resetb_i,
		data_o => aes_output_s
	);

DUT5 : convert_to_state port map (
		text_i => text_i,
		etat_o => plain_text_state_s
	);


DUT6 : convert_to_bit128 port map (
		etat_i => mux2_o_s,
		text_o => cipher_o
	);

DUT7 : mux port map (
		text_i => plain_text_state_s,
		mc_o => mc_o_s,
		enableRoundComputing_i => enableRoundComputing_i,
		mux_o => mux_o_s
	);

DUT8 : convert_to_state port map (
		text_i => currentKey_i,
		etat_o => convert_key_s
	);

DUT9 : mux port map (
		text_i => state_null,
		mc_o => aes_output_s,
		enableRoundComputing_i => aes_end_i,
		mux_o => mux2_o_s
	);

end architecture AESround_arch;


configuration AESround_conf of AESround is
for AESround_arch
	for all : subbyte
		use entity LIB_RTL.subbyte(subbyte_arch);
	end for;
	for all : shiftrows
		use entity LIB_RTL.shiftrows(shiftrows_arch);
	end for;
	for all : mixcolumns
		use entity LIB_RTL.mixcolumns(mixcolumns_arch);
	end for;
	for all : addroundkey 
		use entity LIB_RTL.addroundkey(addroundkey_arch);
	end for;
	for all : registre
		use entity LIB_RTL.registre(register_arch);
	end for;
	for all : convert_to_state
		use entity LIB_RTL.convert_to_state(convert_to_state_arch);
	end for;
	for all : convert_to_bit128
		use entity LIB_RTL.convert_to_bit128(convert_to_bit128_arch);
	end for;
	for all : mux
		use entity LIB_RTL.mux(mux_arch);
	end for;
end for;
end configuration AESround_conf;

