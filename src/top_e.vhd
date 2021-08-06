-- ----------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.NUMERIC_STD.all;
USE WORK.top_pack.all;

ENTITY top IS
PORT(
	rb_i    : IN  STD_LOGIC;
	cp_i    : IN  STD_LOGIC;
	s1_i    : IN  STD_LOGIC;
	s2_i    : IN  STD_LOGIC;
	s3_i    : IN  STD_LOGIC;
	clr_i    : IN  STD_LOGIC;
	rb_o    : OUT STD_LOGIC;
	sec_o   : OUT STD_LOGIC;
	grn_o   : OUT STD_LOGIC;
	red_o   : OUT STD_LOGIC;
	txled_o : OUT STD_LOGIC;
	txd_o   : OUT STD_LOGIC;
	lbt_o   : OUT STD_LOGIC;
	s1_o    : OUT STD_LOGIC;
	s2_o    : OUT STD_LOGIC;
	s3_o    : OUT STD_LOGIC;
	clr_o   : OUT STD_LOGIC;
	sdi_o   : OUT STD_LOGIC;
	sdv_o   : OUT STD_LOGIC;
	stx_o   : OUT STD_LOGIC
  );
END top;
-- ----------------------------------------------------------------------------