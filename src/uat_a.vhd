

-- ----------------------------------------------------------------------------
  ARCHITECTURE ar1 OF uat IS

  TYPE 		state_name IS (init_st, start_st, data_st, stop_st, clean_st); 		
  SIGNAL 	now_st 	: state_name;	

  SIGNAL br_s			: INTEGER RANGE 0 TO cp_freq/baud -1;
  SIGNAL dlen_s 	 	: INTEGER RANGE 0 TO  7;  	    					-- 8 Bits 
  SIGNAL d08_s  		: STD_LOGIC_VECTOR(7 DOWNTO 0); 					--Signal for Serial Data
  
  
  BEGIN
  cpd: PROCESS (rb_i,cp_i,dv_i)
		BEGIN
			IF (rb_i='0') THEN now_st <= init_st;
			ELSIF (cp_i'EVENT AND cp_i='1') THEN 
			
	CASE now_st IS
  
-------------------- Drive Line High for Idle ------------------------	
--- Once dv_i is 1, we set the Signal to take the bits in the input---
		WHEN init_st =>	
				txled_o <= '0';  txd_o <= '1'; lbt_o <= '0';
				IF (dv_i = '1') 	THEN	
					now_st    <= start_st;
					d08_s 	 <= cnt_i;		
					
				ELSE now_st <= init_st;
				END IF;   

---------------------SEND out Start Bit. Start bit = 0 ---------------
------------------------- Wait one baud cycle  -----------------------------			
		WHEN start_st=>
				txled_o <= '1';  txd_o <= '0'; lbt_o <= '0';
				IF br_s < cp_freq/baud -1 	THEN 		
					now_st      <= start_st;
					br_s 	    <= br_s + 1;
					
				ELSE now_st <= data_st;
					  br_s <= 0;
				END IF;
------------------------- SEND out Data Bit.  ------------------------
------------------------- Wait one baud cycle ------------------------
---------------- Check if all the have been transmitted---------------	
		WHEN data_st=>		
				txled_o <= '0';  txd_o <= d08_s(dlen_s); lbt_o <= '0';
				IF br_s < cp_freq/baud -1 	THEN		
					now_st    <= data_st;
					br_s 	  <= br_s + 1;
					
				ELSE 
					br_s <= 0;

					IF dlen_s < 7 	THEN		
						now_st <= data_st;
						dlen_s <= dlen_s + 1;
					
					ELSE												
						now_st <= stop_st;
						dlen_s <= 0;
					END IF;
				END IF;
---------------Send out Stop Bit. stop bit = 1 -----------------------
------------ Wait baud cycles for Stop bit to finish------------------		
		WHEN stop_st =>
				txled_o <= '1';  txd_o <= '1'; lbt_o <= '0';
				IF br_s < cp_freq/baud -1 		THEN		
					now_st    <= stop_st;
					br_s 	  <= br_s + 1;
					
				ELSE												
					now_st  <= clean_st;
					br_s 	<= 0;
				END IF;
					
--------------------	Stay here 1 Clock -------------------------------
		WHEN clean_st =>	
				txled_o <= '0';  txd_o <= '1'; lbt_o <= '1'; 
				now_st    <= init_st;
					
		WHEN OTHERS=>		
				lbt_o <= '0'; txled_o <= '0';  txd_o <= '0';
				now_st    <= init_st;


		
	END CASE;
	 END IF; 
 END PROCESS cpd;
	
		
	END ar1;

-- ----------------------------------------------------------------------------


