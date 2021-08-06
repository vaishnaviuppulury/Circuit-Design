-- ----------------------------------------------------------------------------
ARCHITECTURE ar1 OF intfsm IS

  TYPE 		state_name IS (wtdv_st, load_st, tick_st, incr_st,gaps_st, vali_st);
  SIGNAL 	now_st,nxt_st : state_name;

BEGIN

  clkd: PROCESS (rb_i,cp_i)
  BEGIN
    IF (rb_i='0') THEN now_st <= wtdv_st;
    ELSIF (cp_i'EVENT AND cp_i='1') THEN now_st <= nxt_st;
    END IF;
  END PROCESS clkd;

  st_trans: PROCESS (now_st,dv_i,dne_i)
  BEGIN
    nxt_st <= wtdv_st;
    CASE now_st IS
     WHEN wtdv_st  => IF (dv_i ='1') THEN nxt_st <= load_st;
	                  ELSE                nxt_st <= wtdv_st;
					  END IF;
     WHEN load_st  =>                     nxt_st <= tick_st;
     WHEN tick_st  => IF (dne_i='1') THEN nxt_st <= wtdv_st;
                      ELSE                nxt_st <= incr_st;
                      END IF;
     WHEN incr_st  =>                     nxt_st <= gaps_st;
     WHEN gaps_st  =>                     nxt_st <= vali_st;
     WHEN vali_st  =>                     nxt_st <= tick_st;
  END CASE;
  END PROCESS st_trans;

  ausgabe: PROCESS (now_st)
  BEGIN
    CASE now_st IS
     WHEN wtdv_st => clr_o <= '1'; nxt_o  <= '0'; ldr_o <= '0'; vld_o <= '0'; act_o <= '0';
     WHEN load_st => clr_o <= '0'; nxt_o  <= '0'; ldr_o <= '1'; vld_o <= '0'; act_o <= '0';
     WHEN tick_st => clr_o <= '0'; nxt_o  <= '0'; ldr_o <= '0'; vld_o <= '0'; act_o <= '1';
     WHEN incr_st => clr_o <= '0'; nxt_o  <= '1'; ldr_o <= '0'; vld_o <= '0'; act_o <= '1';
     WHEN gaps_st => clr_o <= '0'; nxt_o  <= '0'; ldr_o <= '0'; vld_o <= '0'; act_o <= '1';
     WHEN vali_st => clr_o <= '0'; nxt_o  <= '0'; ldr_o <= '0';	vld_o <= '1'; act_o <= '1';
    END CASE;
  END PROCESS ausgabe;
END ar1;

-- ----------------------------------------------------------------------------