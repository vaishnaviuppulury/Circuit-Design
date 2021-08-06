-- ----------------------------------------------------------------------------
-- uat.vhd
-- ----------------------------------------------------------------------------
-- last edited: 2020-01-19
-- ----------------------------------------------------------------------------
-- FPGA-chip: 10M16SAU169C8G (most likely)  
-- ----------------------------------------------------------------------------
-- ENTITIES : UAT
-- ----------------------------------------------------------------------------
  LIBRARY IEEE;
  USE IEEE.STD_LOGIC_1164.ALL;
  USE WORK.top_pack.ALL;
-- ----------------------------------------------------------------------------
  ENTITY uat IS
  
  GENERIC(
	cp_freq : integer := 12000000;	     		--Set to correct value
	baud 	: integer := 9600
	);
  PORT (
    rb_i   	:  IN STD_LOGIC;                     		-- Reset, active low
    cp_i   	:  IN STD_LOGIC;                     		-- Syscp, @ 12MHz
    dv_i   	:  IN STD_LOGIC;                     		-- Have new RTC or GPS-Data
    cnt_i   :  IN STD_LOGIC_VECTOR(7 DOWNTO 0); 		-- RTC or GPS-Data, 6x4BCD
		txled_o : OUT STD_LOGIC;		     				-- Serial Data Active 
		lbt_o  	: OUT STD_LOGIC;							-- Last Bit transmitted
		txd_o   : OUT STD_LOGIC);                    		-- Serial Data to RS23
  END uat;
-- ----------------------------------------------------------------------------