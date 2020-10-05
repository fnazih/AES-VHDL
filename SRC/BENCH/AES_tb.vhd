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


entity AES_tb is

end entity AES_tb;


architecture AES_tb_arch of AES_tb is

component AES
	port (
		clock_i : in std_logic;
		resetb_i : in std_logic;
		start_i : in std_logic;
		text_i : in bit128;
		cipher_text_o : out bit128;
		end_aes_o : out std_logic;
		aes_on_o : out std_logic
		);
end component AES;

signal clock_i_s : std_logic := '0';
signal resetb_i_s : std_logic := '1';
signal start_i_s : std_logic := '0';
signal text_i_s : bit128 := "01010010011001010111001101110100011011110010000001100101011011100010000001110110011010010110110001101100011001010010000000111111";
signal cipher_text_o_s : bit128;

begin

DUT : AES port map (
	clock_i => clock_i_s,
	resetb_i => resetb_i_s,
	start_i => start_i_s,
	text_i => text_i_s,
	cipher_text_o => cipher_text_o_s
	);

clock_i_s <= not clock_i_s after 50 ns;
--resetb_i_s <= '0' after 800 ns;
start_i_s <= '1' after 80 ns;

end architecture AES_tb_arch;



configuration AES_tb_conf of AES_tb is
	for AES_tb_arch
		for DUT : AES
			use entity LIB_RTL.AES(AES_arch);
		end for;
	end for;
end configuration AES_tb_conf;
