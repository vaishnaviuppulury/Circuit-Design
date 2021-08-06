LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

-- --------------------------------------------------------------------

PACKAGE top_pack IS

COMPONENT Top IS
PORT(
  rb_i    : IN  STD_LOGIC;
  cp_i    : IN  STD_LOGIC;
  s1_i    : IN  STD_LOGIC;
  s2_i    : IN  STD_LOGIC;
  s3_i    : IN  STD_LOGIC;
  clr_i   : IN  STD_LOGIC;
  rb_o    : OUT STD_LOGIC;
  sec_o   : OUT STD_LOGIC;
  grn_o   : OUT STD_LOGIC;
  red_o   : OUT STD_LOGIC;
  txled_o : OUT STD_LOGIC;
  txd_o   : OUT STD_LOGIC;
  lbt_o   : OUT STD_LOGIC;
  s1_o    : OUT STD_LOGIC;
  s2_o    : OUT STD_LOGIC;
  s3_o    : OUT STD_LOGIC;
  clr_o   : OUT STD_LOGIC;
  sdi_o   : OUT STD_LOGIC;
  sdv_o   : OUT STD_LOGIC;
  stx_o   : OUT STD_LOGIC
  );
END COMPONENT;

COMPONENT clkh IS
    PORT(
        rb_i : IN STD_LOGIC;
        cp_i : IN STD_LOGIC;
        hz_o : OUT STD_LOGIC);  						
END COMPONENT;

COMPONENT Debounce
    GENERIC ( 
        prescaler_g :integer := 7 --12MHz*0.01sec (10ms)
    );
    PORT (  rb_i   :  IN STD_LOGIC;  					-- Reset, active low
            cp_i   :  IN STD_LOGIC;  					-- Syscp, @ 12MHz
            s_i    :  IN STD_LOGIC;  					-- Sensor Input 
            db_o   :  OUT STD_LOGIC  					-- Debounced Input  
            );
END COMPONENT;

COMPONENT Sense IS
PORT(
		rb_i 	: IN STD_LOGIC;
		cp_i 	: IN STD_LOGIC;
		s1_i 	: IN STD_LOGIC;
		s2_i 	: IN STD_LOGIC;
        s3_i 	: IN STD_LOGIC;
        clr_i 	: IN STD_LOGIC;
		inc_o 	: OUT STD_LOGIC;
		dec_o 	: OUT STD_LOGIC);				
END COMPONENT;

COMPONENT Count IS
    PORT (
        rb_i         	:  IN STD_LOGIC;   							-- reset, active low
		cp_i         	:  IN STD_LOGIC;   							-- sys_cp, 12MHz
		inc_i    		:  IN STD_LOGIC;   							-- arrival to room
		dec_i    		:  IN STD_LOGIC;						  	-- departure from room
		dv_o				:  OUT STD_LOGIC;
		act_o				:  OUT STD_LOGIC_VECTOR(1 DOWNTO 0);		-- Number of persons
		cnt_o				:  OUT STD_LOGIC_VECTOR(7 DOWNTO 0);		-- Number of persons
		evnt_o			:  OUT STD_LOGIC_VECTOR(7 DOWNTO 0));		-- status of activity   
  END COMPONENT;

COMPONENT Control IS
    PORT(
        rb_i 	: IN std_logic;
        cp_i 	: IN std_logic;
        act_i  : IN STD_LOGIC_VECTOR(1 DOWNTO 0);	
        grn_o 	: OUT std_logic;
        red_o 	: OUT std_logic);
END COMPONENT;

COMPONENT uat IS
GENERIC(
	cp_freq : INTEGER := 120000;	     		--Set to correct value
	baud 	: INTEGER := 9600);
PORT (
    rb_i    :  IN STD_LOGIC;                     	-- Reset, active low
    cp_i   	:  IN STD_LOGIC;                     		-- Syscp, @ 12MHz
    dv_i   	:  IN STD_LOGIC;                     		-- Have new RTC or GPS-Data
    cnt_i   :  IN STD_LOGIC_VECTOR(7 DOWNTO 0); 		-- RTC or GPS-Data, 6x4BCD
    txled_o : OUT STD_LOGIC;		     				-- Serial Data Active 
	lbt_o  	: OUT STD_LOGIC;							-- last bit transmitted				
	txd_o   : OUT STD_LOGIC);                    		-- Serial Data to RS23
  END COMPONENT;

COMPONENT intf IS
PORT(
    rb_i      	: IN STD_LOGIC;   						--Reset, active low
	cp_i       	: IN STD_LOGIC;  						--Syscp, @ 12MHz
	en_i       	: IN STD_LOGIC;   						--Data Valid
	evnt_i		: IN STD_LOGIC_VECTOR(7 downto 0);		--Events
	cnt_i		: IN STD_LOGIC_VECTOR(7 downto 0);		--Events
    sdi_o		: OUT STD_LOGIC;   						--Serial data valid
    sdv_o 		: OUT STD_LOGIC;						--Seial data output
	stx_o 	   	: OUT STD_LOGIC);   					--Serial data active
END COMPONENT;


-- --------------------------------------------------------------------

COMPONENT reg24e IS
PORT(
  rb_i : IN STD_LOGIC;
  cp_i : IN STD_LOGIC;
  en_i : IN STD_LOGIC;
  d_i  : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
  q_o  : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
END COMPONENT;


COMPONENT reg16 IS
PORT(
  rb_i : IN STD_LOGIC;
  cp_i : IN STD_LOGIC;
  en_i : IN STD_LOGIC;
  de_i : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
  dc_i : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
  q_o  : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
  );
END COMPONENT;



COMPONENT intfsm IS
PORT (
  rb_i 	: IN STD_LOGIC;                     
  cp_i 	: IN STD_LOGIC;                    
  dv_i 	: IN STD_LOGIC;                     
  dne_i : IN STD_LOGIC;                     
  ldr_o : OUT STD_LOGIC;                     
  act_o : OUT STD_LOGIC;
  vld_o	: OUT STD_LOGIC;
  clr_o : OUT STD_LOGIC;                     
  nxt_o : OUT STD_LOGIC                      
      );
END COMPONENT;

-- --------------------------------------------------------------------

COMPONENT c16bin IS
PORT (rb_i   :  IN STD_LOGIC;                     -- Reset, active low
      cp_i   :  IN STD_LOGIC;                     -- Syscp, @ 12MHz
      en_i   :  IN STD_LOGIC;                     -- Enable Count
      cl_i   :  IN STD_LOGIC;                     -- Clear Counter
      co_o   : OUT STD_LOGIC;                     -- Carry Out
       q_o   : OUT STD_LOGIC_VECTOR(4 DOWNTO 0)   -- Counter Value
      );
END COMPONENT;

-- --------------------------------------------------------------------

COMPONENT mx2d IS
PORT (s_i  :  IN STD_LOGIC_VECTOR( 4 DOWNTO 0);  -- get bits
      d_i  :  IN STD_LOGIC_VECTOR(15 DOWNTO 0);  -- BYTE
    txd_o  : OUT STD_LOGIC);                      -- txd, Serial Output
END COMPONENT;

-- --------------------------------------------------------------------
END top_pack;

