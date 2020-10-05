-- Date :  /  /  
-- Title : AES.vhd
-- Name : Fatima-Zohra NAZIH
-- Function : ?????????

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library LIB_AES;
use LIB_AES.crypt_pack.all;
library LIB_RTL;

entity AES is
	port (
		clock_i : in std_logic;
		resetb_i : in std_logic;
		start_i : in std_logic;
		text_i : in bit128;
		cipher_text_o : out bit128;
		end_aes_o : out std_logic;
		aes_on_o : out std_logic
		);
end entity AES;


architecture AES_arch of AES is

component FSM_moore
	port (
		clock_i : in std_logic;
		resetb_i : in std_logic;
		start_i : in std_logic;
		end_k_e_i : in std_logic;
		count_i : in integer range 0 to 10;
		enableRoundComputing_o : out std_logic;
		start_k_e_o : out std_logic;
		init_o : out std_logic;
		enable_cpt_o : out std_logic;
		enable_mc_o : out std_logic;
		enable_aes_o : out std_logic;
		aes_on_o : out std_logic;
		end_aes_o : out std_logic
		);
end component FSM_moore;

component compteur
	port (
		clk_i : in std_logic;
		resetb_i : in std_logic;
		enable_i : in std_logic;
		init_i : in std_logic;
		count_o : out integer range 0 to 10
		);
end component compteur;

component AESround
	port (
		text_i : in bit128;
		currentKey_i : in bit128;
		clk_i : in std_logic;
		resetb_i : in std_logic;
		mix_i : in std_logic;
		enableRoundComputing_i : in std_logic;
		cipher_o : out bit128;
		aes_end_i : in std_logic
		);
end component AESround;

component KeyExpansion_I_O_table
	port (
		key_i           : in  bit128;
	        clock_i         : in  std_logic;
	        reset_i         : in  std_logic;
	        start_i         : in  std_logic;
	        round_i         : in  bit4;
	        end_o           : out std_logic;
	        expansion_key_o : out bit128
		);
end component KeyExpansion_I_O_table;

signal enable_output_s : std_logic;
signal count_s : integer range 0 to 10;
signal enableRC_s, init_s, enableCount_s, enableMC_s, endKE_s, end_aes_s, start_k_e_s : std_logic;
signal key_s : bit128;
signal round_key_s : bit4;
signal cipher_text_s : bit128;
signal state_null : bit128 := "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";

begin

DUT : FSM_moore port map (
	clock_i => clock_i,
	resetb_i => resetb_i,
	start_i => start_i,
	end_aes_o => end_aes_s,
	count_i => count_s,
	start_k_e_o => start_k_e_s,
	end_k_e_i => endKE_s,
	enableRoundComputing_o => enableRC_s,
	init_o => init_s,
	enable_cpt_o => enableCount_s,
	enable_mc_o => enableMC_s,
	enable_aes_o => enable_output_s,
	aes_on_o => aes_on_o
	);

DUT1 : AESround port map (
	text_i => text_i,
	currentKey_i => key_s,
	clk_i => clock_i,
	resetb_i => resetb_i,
	mix_i => enableMC_s,
	enableRoundComputing_i => enableRC_s,
	cipher_o => cipher_text_s,
	aes_end_i => end_aes_s
	);

DUT2 : compteur port map (
	clk_i => clock_i,
	resetb_i => resetb_i,
	enable_i => enableCount_s,
	init_i => init_s,
	count_o => count_s
	);

DUT3 : KeyExpansion_I_O_table port map (
	key_i => key_s,
	clock_i => clock_i,
        reset_i => resetb_i,
        start_i => start_i,
        round_i => round_key_s,
        end_o => endKE_s,
        expansion_key_o => key_s
	);

round_key_s <= "0001" when (count_s = 1) else "0010" when (count_s = 2) else "0011" when (count_s = 3) else "0100" when (count_s = 4) else "0101" when (count_s = 5) else "0110" when (count_s = 6) else "0111" when (count_s = 7) else "1000" when (count_s = 8) else "1001" when (count_s = 9) else "1010" when (count_s = 10) else "0000";

cipher_text_o <= cipher_text_s when end_aes_s = '1' else state_null;

end architecture AES_arch;

configuration AES_conf of AES is
for AES_arch
	for all : FSM_moore
		use entity LIB_RTL.FSM_moore(FSM_moore_arch);
	end for;
	for all : compteur
		use entity LIB_RTL.compteur(compteur_arch);
	end for;
	for all : AESround
		use entity LIB_RTL.AESround(AESround_arch);
	end for;
	for all : KeyExpansion_I_O_table
		use entity LIB_AES.KeyExpansion_I_O_table(KeyExpansion_I_O_table_arch);
	end for;
end for;
end configuration AES_conf;
