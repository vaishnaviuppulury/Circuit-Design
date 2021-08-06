-- ----------------------------------------------------------------------------

ARCHITECTURE ar1 OF Sense IS

    ---** >>>>>>>>>>>> S1 >>>>>>>>>>>>>>>>>>>>>>>>>>> S2 >>>>>>>>>>>>>>>>> S3 >>>>>>>>> Arrival Occurs**


	-----s1--PRIORITY SENSOR |<**>|--------------------------------------------------------------------
	--------------------------------------s2-- PRIORITY SENSOR |<''>-------------------------------------
    ------------------------------------------------------------------s3-- PRIORITY SENSOR |<**>-------
    
    ---** Departure Occurs <<<<<<<<<<< S1 <<<<<<<<<<<<< S2 <<<<<<<<<<<<<<<<<<<<<< S3**
  
  TYPE state_name IS (      
                            init_st,     -- Initial State
                            wait_st,     -- Wait State
                            wait_ar_st,  -- Wait State
                            wait_dp_st,  -- Wait State
							 --Person entering room
							arr_2_st,	 --Sensor 2 Triggered
							arr_3_st,	 --Sensor 3 Triggered
							arrival_st,	 -- Person Arrived
							-----------------------------------------------------
							stop_st,	-- undefined condition, trigger red light on
							-----------------------------------------------------
							
							--Person Leaving room
							dep_2_st,	 --Sensor 2 Triggered
							dep_1_st,	 --Sensor 1 Triggered
							depart_st	 -- Person Arrived
							
							);
  SIGNAL now_st,nxt_st : state_name;

BEGIN

  fsm: PROCESS (rb_i,cp_i)
  BEGIN
    IF    (rb_i='0')       			      THEN now_st <= init_st;
    ELSIF (cp_i'EVENT AND cp_i='1')		THEN now_st <= nxt_st;
    END IF;
  END PROCESS fsm;

  st_fsm: PROCESS (now_st, s1_i,s2_i,s3_i,clr_i)
  BEGIN
    nxt_st <= init_st;
    CASE now_st IS
      WHEN init_st		=> 
						
						IF    (s1_i='1' AND s2_i='0' AND s3_i='0' AND clr_i ='0')   THEN nxt_st <= wait_st; 			--s1 persons enters
						ELSIF (s1_i='0' AND s2_i='0' AND s3_i='1' AND clr_i ='0') 	THEN nxt_st <= wait_st;			  --s3 persons leaves
            ELSE  nxt_st <= init_st;
						END IF;
						
--------------------------------------------------------- Waiting Transitions --------------------------------------------------------------
        WHEN wait_st 		=>  

            IF    (s1_i='0' AND s2_i='1' AND s3_i='0' AND clr_i ='0') 	THEN nxt_st <= arr_2_st;			  --Sensor s3 triggered 
            ELSIF (s1_i='0' AND s2_i='0' AND s3_i='1' AND clr_i ='0') 	THEN nxt_st <= dep_2_st;			--Expected : All sensors set to zero for a time
            ELSE	nxt_st <= wait_st;
            END IF;
--------------------------------------------------------- Person Entering transitions --------------------------------------------------------------
        WHEN arr_2_st 		=>  
						IF    (s1_i='0' AND s2_i='1' AND s3_i='0' AND clr_i ='0') 	THEN nxt_st <= wait_ar_st;			--Still at Sensor 2
            ELSIF (s1_i='1' AND s2_i='0' AND s3_i='0' AND clr_i ='0') 	THEN nxt_st <= init_st;			  --Sensor s3 triggered 
            ELSIF (s1_i='0' AND s2_i='0' AND s3_i='0' AND clr_i ='1') 	THEN nxt_st <= init_st;			  --Sensor s3 triggered 
						ELSIF (s1_i='0' AND s2_i='0' AND s3_i='0' AND clr_i ='0') 	THEN nxt_st <= arr_2_st;			--Expected : All sensors set to zero for a time
						ELSE	nxt_st <= stop_st;
            END IF;
        --------------------------------------------------------- Waiting Transitions --------------------------------------------------------------
        WHEN wait_ar_st 		=>  

            IF    (s1_i='0' AND s2_i='0' AND s3_i='1' AND clr_i ='0') 	THEN nxt_st <= arr_3_st;			  --Sensor s3 triggered 
            ELSE	nxt_st <= wait_ar_st;
            END IF;
--------------------------------------------------------- Person Entering transitions --------------------------------------------------------------
        WHEN arr_3_st 		=>  
						IF    (s1_i='0' AND s2_i='0' AND s3_i='1' AND clr_i ='0') 	THEN nxt_st <= arrival_st;		--All Sensor train triggered: Person Arrives
						ELSIF (s1_i='0' AND s2_i='1' AND s3_i='0' AND clr_i ='0') 	THEN nxt_st <= arr_2_st;			--Sensor s2 triggered : Moves back 
            ELSIF (s1_i='1' AND s2_i='0' AND s3_i='0' AND clr_i ='1') 	THEN nxt_st <= init_st;			  --Sensor s3 triggered 
            ELSIF (s1_i='0' AND s2_i='0' AND s3_i='0' AND clr_i ='0') 	THEN nxt_st <= arr_3_st;			--Still at Sensor 3
						ELSE	nxt_st <= stop_st;
						END IF;
		
	    WHEN arrival_st	=>  	nxt_st <= init_st; 															--Person enters room complete 
		
		
--------------------------------------------------------- Person Departing transitions --------------------------------------------------------------

        WHEN dep_2_st 		=>  
						IF    (s1_i='0' AND s2_i='1' AND s3_i='0' AND clr_i ='0') 	THEN nxt_st <= wait_dp_st;			--Moving to Sensor 1: Departure Expected!!
            ELSIF (s1_i='0' AND s2_i='0' AND s3_i='1' AND clr_i ='0') 	THEN nxt_st <= init_st;			  -- 
            ELSIF (s1_i='0' AND s2_i='0' AND s3_i='1' AND clr_i ='1') 	THEN nxt_st <= init_st;			  --Sensor s3 triggered 
            ELSIF (s1_i='0' AND s2_i='0' AND s3_i='0' AND clr_i ='0') 	THEN nxt_st <= dep_2_st;			--Expected : All sensors set to zero for a time
						ELSE	nxt_st <= stop_st;
            END IF;
        WHEN wait_dp_st 		=>  
            IF    (s1_i='1' AND s2_i='0' AND s3_i='0' AND clr_i ='0') 	THEN nxt_st <= dep_1_st;			  --Sensor s3 triggered 
            ELSE	nxt_st <= wait_dp_st;
            END IF;
        WHEN dep_1_st 		=>  
						IF    (s1_i='1' AND s2_i='0' AND s3_i='0' AND clr_i ='0') 	THEN nxt_st <= depart_st;			--All Sensor train triggered: Person Leaves
						ELSIF (s1_i='0' AND s2_i='1' AND s3_i='0' AND clr_i ='0') 	THEN nxt_st <= dep_2_st;			--Sensor s2 triggered : Moves back 
            ELSIF (s1_i='1' AND s2_i='0' AND s3_i='0' AND clr_i ='1') 	THEN nxt_st <= init_st;			  --Sensor s3 triggered 
            ELSIF (s1_i='0' AND s2_i='0' AND s3_i='0' AND clr_i ='0') 	THEN nxt_st <= dep_1_st;			--All Sensor train triggered: Detection complete
						ELSE	nxt_st <= stop_st;
						END IF;
		
		WHEN depart_st	=>  	nxt_st <= init_st; 													--Person exit room complete 
		
		WHEN stop_st		=>  	nxt_st <= init_st; 													--Person path Wrong!! 
	  END CASE;
  END PROCESS st_fsm;

  st_define: PROCESS (now_st)
  BEGIN
    CASE now_st IS
        WHEN init_st   	=> inc_o <= '0'; dec_o <= '0'; 
        WHEN wait_st   	=> inc_o <= '0'; dec_o <= '0';
        WHEN wait_ar_st => inc_o <= '0'; dec_o <= '0'; 
        WHEN wait_dp_st => inc_o <= '0'; dec_o <= '0'; 
--------------------------------------------------------- Person Entering transitions --------------------------------------------------------------
		
        WHEN arr_2_st	  => inc_o <= '0'; dec_o <= '0'; 
        WHEN arr_3_st 	=> inc_o <= '0'; dec_o <= '0'; 
	      WHEN arrival_st => inc_o <= '1'; dec_o <= '0';  
		
--------------------------------------------------------- Person Departing transitions --------------------------------------------------------------

        WHEN dep_2_st	  => inc_o <= '0'; dec_o <= '0'; 
        WHEN dep_1_st 	=> inc_o <= '0'; dec_o <= '0'; 
	      WHEN depart_st 	=> inc_o <= '0'; dec_o <= '1';

----------------------------------------------- Stop! User Path Wrong.. User cannot enter/exit ------------------------------------------------------

		WHEN stop_st 	=> inc_o <= '0'; dec_o <= '0'; 
	  
    END CASE;
  END PROCESS st_define;

END ar1; 