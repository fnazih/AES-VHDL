-- Date :  /  /  
-- Title : FSM_moore_tb.vhd
-- Name : Fatima-Zohra NAZIH
-- Function : ?????????

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library LIB_AES;
use LIB_AES.crypt_pack.all;
library LIB_RTL;



entity FSM_moore_tb is 

end entity FSM_moore_tb;


architecture FSM_moore_tb_arch of FSM_moore_tb is

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


signal clock_i_s : std_logic := '0';
signal resetb_i_s : std_logic := '1';
signal start_i_s : std_logic := '0';
signal end_k_e_i_s : std_logic := '0';
signal count_i_s : integer range 0 to 10 := 0;

begin

DUT : FSM_moore
	port map (
		clock_i => clock_i_s,
		resetb_i => resetb_i_s,
		start_i => start_i_s,
		end_k_e_i => end_k_e_i_s,
		count_i => count_i_s
		);

clock_i_s <= not clock_i_s after 50 ns;
resetb_i_s <= '0' after 600 ns;
start_i_s <= '1' after 200 ns;
end_k_e_i_s <= '1' after 35 ns;
count_i_s <= 1 after 450 ns, 2 after 550 ns, 3 after 650 ns, 4 after 750 ns, 5 after 850 ns, 6 after 950 ns, 7 after 1050 ns, 8 after 1150 ns, 9 after 1250 ns, 10 after 1350 ns;

end architecture FSM_moore_tb_arch;


configuration FSM_moore_tb_conf of FSM_moore_tb is
	for FSM_moore_tb_arch
		for DUT : FSM_moore
			use entity LIB_RTL.FSM_moore(FSM_moore_arch);
		end for;
	end for;
end configuration FSM_moore_tb_conf;

