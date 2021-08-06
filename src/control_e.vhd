
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.NUMERIC_STD.all;
USE WORK.top_pack.all;

-- ----------------------------------------------------------------------------

ENTITY Control IS
	PORT(
		rb_i 	: IN std_logic;
		cp_i 	: IN std_logic;
		act_i : IN STD_LOGIC_VECTOR(1 DOWNTO 0);	
		grn_o : OUT std_logic;
		red_o : OUT std_logic);
 
END Control;