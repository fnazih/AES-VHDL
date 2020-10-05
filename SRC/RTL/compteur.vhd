-- Date :  /  /  
-- Title : compteur.vhd
-- Name : Fatima-Zohra NAZIH
-- Function : this function sets the counter that controls the key expansion and therefore the AES rounds

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library LIB_AES;
use LIB_AES.crypt_pack.all;
library LIB_RTL;


entity compteur is
	port (
		clk_i : in std_logic;
		resetb_i : in std_logic;
		enable_i : in std_logic;
		init_i : in std_logic;
		count_o : out integer range 0 to 20		-- choice of an integer : easier
		);
end entity compteur;


architecture compteur_arch of compteur is

signal cpt_s : integer range 0 to 10;

begin

seq0 : process(clk_i, resetb_i, enable_i, init_i)

	begin
		if resetb_i = '0' then				-- asynchronous reset : resets counter
			cpt_s <= 0;
		elsif clk_i'event and clk_i = '1' then
			if enable_i = '1' then			-- enable counting bit
				if init_i = '1' then		-- initialization bit : the counter is initialized to 0
					cpt_s <= 0;
				elsif cpt_s < 12 then		-- incrementing counter
					cpt_s <= cpt_s + 1;
				end if;
			else
				cpt_s <= cpt_s;
			end if;
		end if;
end process seq0;

count_o <= cpt_s;

end architecture compteur_arch;



