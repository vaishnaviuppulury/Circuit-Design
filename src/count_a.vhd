

-- ----------------------------------------------------------------------------
ARCHITECTURE ar1 OF Count IS
  
SIGNAL cnt_value : UNSIGNED(7 downto 0);
SIGNAL evnt_s    : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL act_s     : STD_LOGIC_VECTOR(1 DOWNTO 0);

BEGIN

	cp_d: PROCESS(rb_i,cp_i,inc_i, dec_i)
	BEGIN
		IF 	(rb_i='0')  THEN 
			cnt_value	<=	"00000000";
			evnt_s <= "00000000";
			act_s <= "00";
			dv_o <= '0';
			
			
		ELSIF (cp_i'EVENT AND cp_i='1') THEN
------------------------    CHECK FOR INCREMENT   -----------------------------				
			IF (inc_i='1' AND dec_i = '0') 	 THEN
------------------------    CHECK IF FULL ROOM   -----------------------------
				IF (cnt_value = "00000011") THEN 
					evnt_s <= "00100001";
					act_s <= "11";
					dv_o <= '1';
				ELSE
					evnt_s <= "00101101";
					cnt_value <=cnt_value + 1;
					act_s <= "01";
					dv_o <= '1';
				END IF;

------------------------    CHECK FOR NOTHING HAPPENS   -----------------------------				
			ELSIF (inc_i='0' AND dec_i = '0' ) 	 THEN 
------------------------    CHECK IF  ROOM  EMPTY  -----------------------------
				IF(cnt_value = "00000000") 	THEN 
					evnt_s <= "00101101";
					dv_o <= '1';
					act_s <= "00";
------------------------    CHECK IF  ROOM  FULL  -----------------------------
				ELSIF(cnt_value = "00000011") 	THEN 
					evnt_s <= "00100001";
					act_s <= "11";
					dv_o <= '1'; 
				END IF;
------------------------    CHECK FOR DECREMENT   -----------------------------							
			ELSIF (inc_i='0' AND dec_i = '1' )  THEN
------------------------    CHECK IF  ROOM  EMPTY  -----------------------------
				IF(cnt_value = "00000000") 	THEN 
					evnt_s <= "00101101";
					act_s <= "00";
					dv_o <= '1';
				ELSE
					cnt_value <=cnt_value - 1;
					evnt_s <= "00101011";
					act_s <= "10";
					dv_o <= '1';
				END IF;
			END IF;
		END IF;	
	END PROCESS cp_d;
	cnt_o <= STD_LOGIC_VECTOR(cnt_value) ;
	evnt_o <= evnt_s;
	act_o <= act_s;
END ar1;