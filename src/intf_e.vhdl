-- ----------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE WORK.top_pack.ALL;

ENTITY intf IS
PORT(
	rb_i 	: IN STD_LOGIC;
	cp_i 	: IN STD_LOGIC;
	en_i 	: IN STD_LOGIC;
	evnt_i 	: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	cnt_i 	: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	sdi_o 	: OUT STD_LOGIC;
	sdv_o 	: OUT STD_LOGIC;
	stx_o 	: OUT STD_LOGIC
  );
END intf;
-- ----------------------------------------------------------------------------