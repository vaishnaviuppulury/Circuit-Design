-- ----------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE WORK.top_pack.ALL;

ENTITY mx2d IS
	PORT (s_i   : IN STD_LOGIC_VECTOR( 4 DOWNTO 0);  -- get bits
		  d_i  	: IN STD_LOGIC_VECTOR(15 DOWNTO 0);  -- BYTE
		  txd_o : OUT STD_LOGIC);                      -- txd, Serial Output
END mx2d;
-- ----------------------------------------------------------------------------