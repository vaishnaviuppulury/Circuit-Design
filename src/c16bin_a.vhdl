-- ----------------------------------------------------------------------------
ARCHITECTURE ar1 OF c16bin IS

SIGNAL state_s : STD_LOGIC_VECTOR (4 DOWNTO 0);

BEGIN

cntx : PROCESS (rb_i,cp_i,en_i,cl_i)
BEGIN
  IF (rb_i='0') THEN state_s <= B"00000";
  ELSIF (cp_i='1' AND cp_i'EVENT) THEN
    IF (cl_i='1') THEN state_s <= "00000";
    ELSE
      CASE state_s IS
        WHEN B"00000" => IF (en_i='1') THEN state_s<= B"00001"; END IF;
        WHEN B"00001" => IF (en_i='1') THEN state_s<= B"00010"; END IF;
        WHEN B"00010" => IF (en_i='1') THEN state_s<= B"00011"; END IF;
        WHEN B"00011" => IF (en_i='1') THEN state_s<= B"00100"; END IF;
        WHEN B"00100" => IF (en_i='1') THEN state_s<= B"00101"; END IF;
        WHEN B"00101" => IF (en_i='1') THEN state_s<= B"00110"; END IF;
        WHEN B"00110" => IF (en_i='1') THEN state_s<= B"00111"; END IF;
        WHEN B"00111" => IF (en_i='1') THEN state_s<= B"01000"; END IF;
        WHEN B"01000" => IF (en_i='1') THEN state_s<= B"01001"; END IF;
        WHEN B"01001" => IF (en_i='1') THEN state_s<= B"01010"; END IF;
        WHEN B"01010" => IF (en_i='1') THEN state_s<= B"01011"; END IF;
        WHEN B"01011" => IF (en_i='1') THEN state_s<= B"01100"; END IF;
        WHEN B"01100" => IF (en_i='1') THEN state_s<= B"01101"; END IF;
        WHEN B"01101" => IF (en_i='1') THEN state_s<= B"01110"; END IF;
        WHEN B"01110" => IF (en_i='1') THEN state_s<= B"01111"; END IF;
        WHEN B"01111" => IF (en_i='1') THEN state_s<= B"10000"; END IF;
        WHEN B"10000" => IF (en_i='1') THEN state_s<= B"00000"; END IF;
        WHEN OTHERS  =>                     state_s<= B"00000";
        END CASE;
    END IF;
  END IF;
END PROCESS cntx;

q_o   <= state_s;
co_o  <= state_s(4) AND NOT(state_s(3)) AND NOT(state_s(2)) AND NOT(state_s(1)) AND NOT(state_s(0));

END ar1;

--------------------------------------------------------------