library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library LIB_AES;
use LIB_AES.crypt_pack.all;
library LIB_RTL;


entity AESround_tb is

end entity AESround_tb;


architecture AESround_tb_arch of AESround_tb is

component AESround
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
end component AESround;

signal cipher_o_s : bit128;
signal text_i_s : bit128 := "01010010010101100111001101110100011011110010000001100101011011100010000001110110011010010110110001101100011001010010000000111111";
signal currentKey_i_s : bit128 := "01111001000110110110011001100010010001111000111010110111110010001000110010000001011111001110010001100101101010100110111100000011";
signal clk_i_s : std_logic := '0';
signal resetb_i_s : std_logic := '1';
signal mix_i_s : std_logic := '0';
signal enableRoundComputing_i_s : std_logic := '0';
signal aes_end_s : std_logic := '1';

begin

DUT : AESround 
	port map (
			text_i => text_i_s,
			currentKey_i => currentKey_i_s,
			clk_i => clk_i_s,
			resetb_i => resetb_i_s,
			mix_i => mix_i_s,
			enableRoundComputing_i => enableRoundComputing_i_s,
			aes_end_i => aes_end_s,
			cipher_o => cipher_o_s
			);

clk_i_s <= not clk_i_s after 50 ns;
-- resetb_i_s <= '0' after 900 ns;
--mix_i_s <= '1' after 250 ns;
--aes_end_s <= '1' after 1000 ns;
enableRoundComputing_i_s <= '1' after 400 ns;

end architecture AESround_tb_arch;


configuration AESround_tb_conf of AESround_tb is
	for AESround_tb_arch
		for DUT : AESround
			use entity LIB_RTL.AESround(AESround_arch);
		end for;
	end for;
end configuration AESround_tb_conf;


