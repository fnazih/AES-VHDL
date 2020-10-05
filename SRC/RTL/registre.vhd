-- Date :  /  /  
-- Title : registre.vhd
-- Name : Fatima-Zohra NAZIH
-- Function : the register memorizes the input data synchronously with the clock, and resets it asynchronously when the reset bit is active

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library LIB_AES;
use LIB_AES.crypt_pack.all;
library LIB_RTL;

entity registre is
	port (
		clk_i : in std_logic;
		data_i : in type_state;
		resetb_i : in std_logic;
		data_o : out type_state
		);
end entity registre;


architecture register_arch of registre is

signal aes_state_s : type_state;

begin

seq0 : process(clk_i, resetb_i) is
begin
	if resetb_i = '0' then		-- active at low level
		for i in 0 to 3 loop
			for j in 0 to 3 loop
				aes_state_s(i)(j) <= (others => '0');		-- resets the state
			end loop;
		end loop;
	elsif clk_i'event and clk_i = '1' then
		for i in 0 to 3 loop
			for j in 0 to 3 loop
				aes_state_s(i)(j) <= data_i(i)(j);		-- memorizes the state
			end loop;
		end loop;
	end if;
end process seq0;


G1 : for i in 0 to 3 generate
	G2 : for j in 0 to 3 generate
		data_o(i)(j) <= aes_state_s(i)(j);				-- copies the signal into the output
	end generate G2;
end generate G1;

end architecture register_arch;
