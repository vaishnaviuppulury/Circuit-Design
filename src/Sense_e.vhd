-- ----------------------------------------------------------------------------
LIBRARY IEEE;
    USE IEEE.STD_LOGIC_1164.all;
    USE IEEE.NUMERIC_STD.all;
    USE WORK.top_pack.all;

-- ----------------------------------------------------------------------------

ENTITY Sense IS
	PORT(
		rb_i 	: IN STD_LOGIC;
		cp_i 	: IN STD_LOGIC;
		s1_i 	: IN STD_LOGIC;
        s2_i 	: IN STD_LOGIC;
        s3_i 	: IN STD_LOGIC;
        clr_i   : IN STD_LOGIC;
		inc_o 	: OUT STD_LOGIC;		-- Entry occurs
		dec_o 	: OUT STD_LOGIC);		-- Exit occurs
END Sense;

-- ----------------------------------------------------------------------------