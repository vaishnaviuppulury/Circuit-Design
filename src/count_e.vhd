-- ----------------------------------------------------------------------------
LIBRARY IEEE ;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.NUMERIC_STD.all;
USE WORK.top_pack.ALL;
-- ----------------------------------------------------------------------------
ENTITY Count IS   
    PORT (  
       rb_i         	:  IN STD_LOGIC;   							-- reset, active low
	    cp_i         	:  IN STD_LOGIC;   							-- sys_cp, 12MHz
	    inc_i    		:  IN STD_LOGIC;   							-- arrival to room
	    dec_i    		:  IN STD_LOGIC;						  	-- departure from roo
	    dv_o    		:  OUT STD_LOGIC;						  	-- Count Valid
       act_o			:  OUT STD_LOGIC_VECTOR(1 DOWNTO 0);		-- Status defined in binary states
       cnt_o			:  OUT STD_LOGIC_VECTOR(7 DOWNTO 0);		-- Number of persons
	    evnt_o			:  OUT STD_LOGIC_VECTOR(7 DOWNTO 0));		-- status of activity   
END Count;
-- ----------------------------------------------------------------------------
