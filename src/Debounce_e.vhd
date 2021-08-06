
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.NUMERIC_STD.all;
USE WORK.top_pack.all;

ENTITY Debounce IS
    GENERIC ( 
        prescaler_g :integer := 7 				--12MHz*0.01sec (10ms)
    );
    PORT (  rb_i   :  IN STD_LOGIC;  					-- Reset, active low
            cp_i   :  IN STD_LOGIC;  					-- Syscp, @ 12MHz
            s_i    :  IN STD_LOGIC;  					-- Sensor Input 
            db_o   :  OUT STD_LOGIC  					-- Debounced Input  
            );
END Debounce;