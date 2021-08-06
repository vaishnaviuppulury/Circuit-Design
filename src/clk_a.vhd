library IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.NUMERIC_STD.all;

---Design Process: Use a 12Mhz to produce a 1Hz LED pulse
--- clock_frequency / Expected frequency --> 12MHz/1Hz = 12_000_000 ticks required!!
--- Make an FSM where you loop between "ON" and "OFF" state!
--- Use 6_000_000 ticks for ON State and also for OFF State
--- Jump to between states once ticks reached!!
--- Implement on an FPGA!!
--- Simple Blinking LED

ARCHITECTURE ar1 of clkh is  
TYPE 		state_name IS (init_st, on_st, off_st); 		
SIGNAL 	now_st 	: state_name;	
SIGNAL prescaler : UNSIGNED(23 downto 0);

BEGIN
  cpd: PROCESS (rb_i,cp_i)
		BEGIN
			IF (rb_i='0') THEN now_st <= init_st;
			ELSIF (cp_i'EVENT AND cp_i='1') THEN 
        CASE now_st IS
------------------------------------------------------------------------          
          WHEN init_st =>    
            hz_o <= '0';
				prescaler   <= (OTHERS => '0');
            now_st <= on_st;
				
------------------------------------------------------------------------          
          WHEN on_st =>  
            hz_o <= '1'; 
            IF prescaler = X"5B8D80" THEN     -- 6 000 000 in hex
              prescaler   <= (OTHERS => '0');
              now_st <= off_st;
            ELSE
              prescaler <= prescaler + "1";
              now_st <= on_st;
            END IF;
------------------------------------------------------------------------
          WHEN off_st =>      
            hz_o <= '0' ; 
            IF prescaler = X"5B8D80" THEN     -- 6 000 000 in hex
              prescaler   <= (OTHERS => '0');
              now_st <= on_st;
            ELSE
              prescaler <= prescaler + "1";
              now_st <= off_st;
            END IF;
------------------------------------------------------------------------
          WHEN OTHERS => now_st <= init_st;

        END CASE;
      END IF;
    END PROCESS cpd;
END ar1;