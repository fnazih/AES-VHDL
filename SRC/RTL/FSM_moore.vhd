-- Date :  /  /  
-- Title : FSM_moore.vhd
-- Name : Fatima-Zohra NAZIH
-- Function : this function cadences the AES ciphering, creating its different states and controlling its outputs (enable bits...)

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library LIB_AES;
use LIB_AES.crypt_pack.all;
library LIB_RTL;


entity FSM_moore is
		port (
			clock_i : in std_logic;
			resetb_i : in std_logic;
			start_i : in std_logic;
			end_k_e_i : in std_logic;
			count_i : in integer range 0 to 10;
			enableRoundComputing_o : out std_logic; --a coller au "enableRoundComputing du mux
			start_k_e_o : out std_logic;
			init_o : out std_logic;
			enable_cpt_o : out std_logic;
			enable_mc_o : out std_logic;
			enable_aes_o : out std_logic;
			aes_on_o : out std_logic;
			end_aes_o : out std_logic
			);
end entity FSM_moore;


architecture FSM_moore_arch of FSM_moore is

type etat is (ATTENTE, CALCUL_KEY, START, ROUND0, ROUND1_9, ROUND10);		-- list of states 

signal current_state, next_state : etat;

begin

P0 : process(clock_i, resetb_i)
	begin
		if resetb_i = '0' then						-- asynchronous reset : returning to the waiting state
			current_state <= ATTENTE;
		elsif clock_i'event and clock_i = '1' then			-- go to next state after each clock period
			current_state <= next_state;
		end if;
end process P0;


P1 : process(current_state, start_i, end_k_e_i, count_i, clock_i)
	begin
		case current_state is
		when ATTENTE =>
		if start_i = '0' then						-- if start_i is activated, then we go to the next state
			next_state <= ATTENTE;
		else
			next_state <= CALCUL_KEY;
		end if;
		when CALCUL_KEY =>
		if end_k_e_i = '0' then						-- if the key expansion is over (end_k_e_i = '1'), then we go to the next state
			next_state <= CALCUL_KEY;
		else
			next_state <= START;
		end if;
		when START =>
			next_state <= ROUND0;					-- no condition for going to the next step, we just need to wait for the next clock rising edge
		when ROUND0 =>
			next_state <= ROUND1_9;
		when ROUND1_9 =>
			if count_i >= 9 then
				next_state <= ROUND10;
			else
				next_state <= ROUND1_9;
			end if;
		when ROUND10 =>
			next_state <= ATTENTE;
		end case;
end process P1;

P2 : process(current_state)
	begin
		case current_state is
			when ATTENTE =>
				aes_on_o <= '0';
				enable_mc_o <= '0';
				enable_aes_o <= '0';
				enableRoundComputing_o <= '0';
				start_k_e_o <= '0';
				init_o <= '0';
				enable_cpt_o <= '0';
				end_aes_o <= '0';
			when CALCUL_KEY =>
				aes_on_o <= '1';
				start_k_e_o <= '1';
				enable_mc_o <= '0';
				enable_aes_o <= '0';
				enableRoundComputing_o <= '0';
				init_o <= '0';
				enable_cpt_o <= '0';
				end_aes_o <= '0';
			when START =>
				aes_on_o <= '1';
				init_o <= '1';
				enable_cpt_o <= '1';
				start_k_e_o <= '0';
				enable_mc_o <= '0';
				enable_aes_o <= '0';
				enableRoundComputing_o <= '0';
				end_aes_o <= '0';
			when ROUND0 =>
				enable_cpt_o <= '1';
				aes_on_o <= '1';
				init_o <= '0';
				start_k_e_o <= '0';
				enable_mc_o <= '0';
				enable_aes_o <= '0';
				enableRoundComputing_o <= '0';
				end_aes_o <= '0';
			when ROUND1_9 =>
				enable_cpt_o <= '1';
				aes_on_o <= '1';
				init_o <= '0';
				enable_cpt_o <= '1';
				start_k_e_o <= '0';
				enable_mc_o <= '1';
				enable_aes_o <= '0';
				enableRoundComputing_o <= '1';
				end_aes_o <= '0';
			when ROUND10 =>
				enable_cpt_o <= '1';
				aes_on_o <= '1';
				init_o <= '0';
				start_k_e_o <= '0';
				enable_mc_o <= '0';
				enable_aes_o <= '1';
				enableRoundComputing_o <= '1';
				end_aes_o <= '1';
			end case;
end process P2;

end architecture FSM_moore_arch;



