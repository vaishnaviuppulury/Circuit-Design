LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE WORK.top_pack.ALL;
-- ----------------------------------------------------------------------------
ENTITY clk_TB IS END clk_TB;
-- ----------------------------------------------------------------------------
ARCHITECTURE ar1 OF clk_TB IS
   
    SIGNAL rb_s,cp_s,hz_s : STD_LOGIC;
-- ----------------------------------------------------------------------------
BEGIN
-- ---------------------------------------------------------------------  
    clk1  : clkh    PORT    MAP (rb_s,cp_s,hz_s);   

    -------------------------------------------------------------------------------
    -- clock process
    -- ----------------------------------------------------------------------------
    clock_process: PROCESS
    BEGIN
        
--  -----Reset Cycle--------------------
        rb_s  <= '0'; WAIT FOR 42 NS;
        rb_s  <= '1'; WAIT FOR 42 NS;
-- ----------------------------------------------------------------------------
-- STEP 3: Run Test-Patterns
-- ----------------------------------------------------------------------------
-- Some SYScp-cycles:
        FOR i IN 1 TO 3 LOOP
            cp_s  <= '1'; WAIT FOR 42 NS; cp_s  <= '0'; WAIT FOR 42 NS;
            cp_s  <= '1'; WAIT FOR 42 NS; cp_s  <= '0'; WAIT FOR 42 NS;
            cp_s  <= '1'; WAIT FOR 42 NS; cp_s  <= '0'; WAIT FOR 42 NS;
        END LOOP;
    END PROCESS clock_process;
END ar1;