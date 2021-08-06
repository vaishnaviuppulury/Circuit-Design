library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE WORK.top_pack.ALL;
-- ----------------------------------------------------------------------------
ENTITY Count_TB IS END Count_TB;
-- ----------------------------------------------------------------------------
ARCHITECTURE ar1 OF Count_TB IS
SIGNAL rb_s,cp_s,s1_s,s2_s,s3_s,clr_s : STD_LOGIC;
SIGNAL deb1_s,deb2_s,deb3_s,debclr_s : STD_LOGIC;
SIGNAL inc_s,dec_s   : STD_LOGIC;
SIGNAL grn_s,red_s,dv_s,hz_s: STD_LOGIC;
SIGNAL act_s                : STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL evnt_s,cnt_s         : STD_LOGIC_VECTOR(7 DOWNTO 0);
-- ----------------------------------------------------------------------------
BEGIN
-- ---------------------------------------------------------------------  
clk1    : clkh       PORT MAP    (rb_s,cp_s,hz_s);  
deb1    : Debounce  GENERIC MAP (prescaler_g=>7)PORT MAP (rb_s,cp_s,s1_s,deb1_s);
deb2    : Debounce  GENERIC MAP (prescaler_g=>7)PORT MAP (rb_s,cp_s,s2_s,deb2_s);
deb3    : Debounce  GENERIC MAP (prescaler_g=>7)PORT MAP (rb_s,cp_s,s3_s,deb3_s);
deb4    : Debounce  GENERIC MAP (prescaler_g=>7)PORT MAP (rb_s,cp_s,clr_s,debclr_s);

sen     : Sense     PORT MAP    (rb_s,cp_s, deb1_s,deb2_s,deb3_s,debclr_s,inc_s,dec_s);

coun    : Count    PORT MAP    (rb_s,cp_s,inc_s,dec_s,dv_s, act_s,cnt_s,evnt_s); 
    -------------------------------------------------------------------------------
    -- clock process
     -------------------------------------------------------------------------------
    simulation: PROCESS
    BEGIN 
         rb_s  <= '1';
			cp_s  <= '0';
			s1_s  <= '0'; 
			s2_s  <= '0'; 
			s3_s  <= '0';
			clr_s <= '0';
-- ----------------------------------------------------------------------------
-- STEP 2: Do a reset-cycle
-- ----------------------------------------------------------------------------
    rb_s  <= '0'; WAIT FOR 100 NS;
    rb_s  <= '1'; WAIT FOR 100 NS;
        
 -- ----------------------------------------------------------------------------
-- STEP 2: Do a Clock-cycle
-- ----------------------------------------------------------------------------        
        
		  WAIT FOR 100 NS;
        cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
        cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
        cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;

        --persons entering
            cp_s  <= '1'; WAIT FOR  10 NS; s1_s  <= '1'; WAIT FOR  90 NS; cp_s  <= '0'; WAIT FOR 100 NS;
            cp_s  <= '1'; WAIT FOR  10 NS; s1_s  <= '0'; WAIT FOR  90 NS; cp_s  <= '0'; WAIT FOR 100 NS;
            cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
            cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;

            cp_s  <= '1'; WAIT FOR  10 NS; s2_s  <= '1'; WAIT FOR  90 NS; cp_s  <= '0'; WAIT FOR 100 NS;
            cp_s  <= '1'; WAIT FOR  10 NS; s2_s  <= '0'; WAIT FOR  90 NS; cp_s  <= '0'; WAIT FOR 100 NS;
            cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
            cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
            
            cp_s  <= '1'; WAIT FOR  10 NS; s3_s  <= '1'; WAIT FOR  90 NS; cp_s  <= '0'; WAIT FOR 100 NS;
            cp_s  <= '1'; WAIT FOR  10 NS; s3_s  <= '0'; WAIT FOR  90 NS; cp_s  <= '0'; WAIT FOR 100 NS;
            cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
            cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
           
            assert(inc_s = '0') report "entry not occurs" severity error;
   

				cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
            cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
        
            cp_s  <= '1'; WAIT FOR  10 NS; s3_s  <= '1'; WAIT FOR  90 NS; cp_s  <= '0'; WAIT FOR 100 NS;
            cp_s  <= '1'; WAIT FOR  10 NS; s3_s  <= '0'; WAIT FOR  90 NS; cp_s  <= '0'; WAIT FOR 100 NS;
            cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
            cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;

            cp_s  <= '1'; WAIT FOR  10 NS; s2_s  <= '1'; WAIT FOR  90 NS; cp_s  <= '0'; WAIT FOR 100 NS;
            cp_s  <= '1'; WAIT FOR  10 NS; s2_s  <= '0'; WAIT FOR  90 NS; cp_s  <= '0'; WAIT FOR 100 NS;
            cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
            cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;

            cp_s  <= '1'; WAIT FOR  10 NS; s1_s  <= '1'; WAIT FOR  90 NS; cp_s  <= '0'; WAIT FOR 100 NS;
            cp_s  <= '1'; WAIT FOR  10 NS; s1_s  <= '0'; WAIT FOR  90 NS; cp_s  <= '0'; WAIT FOR 100 NS;
            cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
            cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;

       
            
        cp_s  <= '1'; WAIT FOR  10 NS; clr_s  <= '1'; WAIT FOR  90 NS; cp_s  <= '0'; WAIT FOR 100 NS;
        cp_s  <= '1'; WAIT FOR  10 NS; clr_s  <= '0'; WAIT FOR  90 NS; cp_s  <= '0'; WAIT FOR 100 NS;
        cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
        cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
            
        assert(inc_s = '1') report "clear not working" severity error;

        cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
        cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
		  cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
        cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
		   WAIT;
END PROCESS simulation;

END ar1;


