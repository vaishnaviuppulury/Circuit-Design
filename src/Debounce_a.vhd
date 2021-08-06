ARCHITECTURE ar1 of Debounce is  
TYPE 		state_name IS (init_st, set_st); 		
SIGNAL 	now_st 	: state_name;	
signal cntr_s : integer range 0 to prescaler_g-1;

BEGIN
  debounce : process (cp_i,s_i,rb_i) is
		BEGIN
			IF (rb_i='0') THEN now_st <= init_st;
			ELSIF (cp_i'EVENT AND cp_i='1') THEN 
        CASE now_st IS
------------------------------------------------------------------------          
          WHEN init_st =>    
            cntr_s <= 0;
				db_o <='0';
				IF(s_i = '1') THEN now_st <= set_st;
				END IF;
------------------------------------------------------------------------          
          WHEN set_st =>  
            IF (cntr_s = 0) then
  
                db_o <= '1';
                cntr_s <= cntr_s + 1;
  
  ------------cntr_s increases till 10ms
            ELSIF cntr_s < prescaler_g then
               cntr_s <= cntr_s + 1;
					now_st <= init_st;
				END IF;

        END CASE;
      END IF;
    END PROCESS debounce;
END ar1;

