----------------------------------------------------------------------------------

ARCHITECTURE ar1 OF Control IS

  TYPE state_name IS (init_st,arr_st, dept_st, max_st);
  SIGNAL now_st,nxt_st : state_name;

BEGIN

  fsm: PROCESS (rb_i,cp_i)
  BEGIN
    IF    (rb_i='0')       			THEN now_st <= init_st;
    ELSIF (cp_i'EVENT AND cp_i='1') THEN now_st <= nxt_st;
    END IF;
  END PROCESS fsm;

  st_fsm: PROCESS (now_st,act_i)
  BEGIN
    nxt_st <= init_st;
    CASE now_st IS
      WHEN init_st	=> 
               IF   (act_i = "01") 	THEN nxt_st <= arr_st;
					ELSIF (act_i = "10") 	THEN nxt_st <= dept_st;
				    ELSIF (act_i = "11") 	THEN nxt_st <= max_st;
					ELSIF (act_i = "00") 	THEN nxt_st <= init_st;
					END IF;
      WHEN arr_st 	=> 
                    IF   (act_i = "01") 	THEN nxt_st <= arr_st;
					ELSIF (act_i = "10") 	THEN nxt_st <= dept_st;
				    ELSIF (act_i = "11") 	THEN nxt_st <= max_st;
					ELSIF (act_i = "00") 	THEN nxt_st <= init_st;
					END IF;
                      
      WHEN dept_st 	=> 
                    IF   (act_i = "01") 	THEN nxt_st <= arr_st;
					ELSIF (act_i = "10") 	THEN nxt_st <= dept_st;
				    ELSIF (act_i = "11") 	THEN nxt_st <= max_st;
					ELSIF (act_i = "00") 	THEN nxt_st <= init_st;
					END IF;
	  
      WHEN max_st 	=>          
                    IF   (act_i = "01") 	THEN nxt_st <= arr_st;
					ELSIF (act_i = "10") 	THEN nxt_st <= dept_st;
				    ELSIF (act_i = "11") 	THEN nxt_st <= max_st;
					ELSIF (act_i = "00") 	THEN nxt_st <= init_st;
					END IF;
	  
    END CASE;
  END PROCESS st_fsm;

  st_define: PROCESS (now_st)
  BEGIN
    CASE now_st IS
      WHEN init_st   	=> grn_o <= '1'; red_o <= '0'; 
      WHEN arr_st	 	=> grn_o <= '1'; red_o <= '0'; 
      WHEN dept_st		=> grn_o <= '1'; red_o <= '0'; 
      WHEN max_st 		=> grn_o <= '0'; red_o <= '1'; 
    END CASE;
  END PROCESS st_define;

END ar1;