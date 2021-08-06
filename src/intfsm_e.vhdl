-- ----------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE WORK.top_pack.ALL;

ENTITY intfsm IS
PORT(
	rb_i 	: IN STD_LOGIC;             -- Reset, active low
	cp_i 	: IN STD_LOGIC;             -- Syscp, @ 12MHz
	dv_i 	: IN STD_LOGIC;             -- Have new RTC or GPS-Data
	dne_i 	: IN STD_LOGIC;             -- Last Bit transmitted
	ldr_o 	: OUT STD_LOGIC;            -- enable register load
	act_o 	: OUT STD_LOGIC;
	vld_o	: OUT STD_LOGIC;
	clr_o 	: OUT STD_LOGIC;            -- clear Bit-Counters
	nxt_o 	: OUT STD_LOGIC);           -- next Bit, inc count
END intfsm;

-- ----------------------------------------------------------------------------