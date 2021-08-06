ARCHITECTURE artop OF top IS
	-------------------------------------------------------------------------------
-- FPGA-PIN-ASSIGNMENT. SUBJECT TO BE CHANGED AT ANY TIME
-- ----------------------------------------------------------------------------
--                       +-------------------+
--                       +     --USB--       +
--                       +     --USB--       +
--                       +     --USB--     o +1 ?LED A8
--                       +     -------     o +2  LED A9
--         J4 JTAG       +                 o +3  LED A11
--         +1 GROUND     +                 o +4  LED A10
--         +2 E5 JTAGEN  +                 o +5  LED B10
--         +3 G2 TCK     +                 o +6  LED C9
--         +4 F6 TDO     +                 o +7  LED C10
--         +5 F5 TDI     +                 o +8 ?LED D8
--         +6 G1 TMS     +                   +
--                    J1 + J3            J4  J2
--              D3 AREF 1+ +1 AIN  D2    +1  +1  D6  L12
--              E1 AIN0 2+ +2            +2  +2  D7  J12
--              C2 AIN1 3+ +3 AIN7 B1    +3  +3  D8  J13
--              C1 AIN2 4+               +4  +4  D9  K11
--              D1 AIN3 5+               +5  +5  D10 K12
--              E3 AIN4 6+               +6  +6  D11 J10
--              F1 AIN5 7+                   +7  D12 H10
--              E4 AIN6 8+                   +8  D13 H13
--              H8 D0   9+                   +9  D14 G12
--             K10 D1  10+                   +10 RES E7  
--              H5 D2  11+                   +11 GROUND
--              H4 D3  12+                   +12 +3.3V
--              J1 D4  13+   V G M M L M     +13 VIN----EXT.VCC.IN
--              J2 D5  14+   C N 1 2 3 3     +14 +5V
--                           C D         
--                           6 5 4 3 2 1 
--                  PIO_04   + + + + + + J6 PIO_01
--                  PIO_08   + + + + + +    PIO_05
--  12MHz:  H6                1 1 1      
--  Optcp:  G5                2 1 0 9 8 7
--                           V G        
--  PART: 10M16SAU169C8G     C N K K N N
--                           C D 1 2 2 3
--  USER-Button: E6
--
--  POWER SUPPLY: VCC5V to J2,Pin 13 (has priority) or via USB-Bus
    
	
	  ATTRIBUTE chip_pin : string;
	
	------------------------------------------- Clock input --------------------------------------- 
    ATTRIBUTE chip_pin of rb_i      : SIGNAL IS  "E6"; -- S1_USR_BTN_akt_low;low logic when pressed
    ATTRIBUTE chip_pin of cp_i      : SIGNAL IS  "H6"; -- CLK_12MHz
    
	---------------------------Input Sensor : Placement is LEFT SIDE OF BOARD ---------------------- 
    
  	ATTRIBUTE chip_pin of clr_i     : SIGNAL IS  "D1"; --pin 11  
    ATTRIBUTE chip_pin of s1_i      : SIGNAL IS  "C1"; --pin 12  
    ATTRIBUTE chip_pin of s2_i      : SIGNAL IS  "C2"; --pin 13  
    ATTRIBUTE chip_pin of s3_i      : SIGNAL IS  "E1"; --pin 14  

  ---------------------------Output: Placement is LEFT SIDE OF BOARD ------------------------------- 
    
	  ATTRIBUTE chip_pin of   rb_o    : SIGNAL IS  "A8";  --led1 - reset
    ATTRIBUTE chip_pin of   sec_o   : SIGNAL IS  "H5";  --led2  second pulse 
    
    -------------------------------UART Transmission----------------------------------------------
    ATTRIBUTE chip_pin of txd_o     : SIGNAL IS  "G12"; 				--Serial data  
	  ATTRIBUTE chip_pin of txled_o   : SIGNAL IS  "A11"; 				--Serial data Active
    ATTRIBUTE chip_pin of lbt_o     : SIGNAL IS  "A10"; 				--Transmission Complete
	
    -------------------------------- STATUS LED-----------------------------------------------------
    ATTRIBUTE chip_pin of   red_o   : SIGNAL IS "J10"; --pin 6  
    ATTRIBUTE chip_pin of   grn_o   : SIGNAL IS "K12"; --pin 5  

 ----------------------------------PINS TO IC_s3-----------------------------------------------------
	  ATTRIBUTE chip_pin of sdi_o     : SIGNAL IS  "J13"; --serial data           pin 3 
	  ATTRIBUTE chip_pin of stx_o     : SIGNAL IS  "J12"; --Serial transmitting   pin 2 
	  ATTRIBUTE chip_pin of sdv_o     : SIGNAL IS  "L12"; --Serial data valid     pin 1
 
  SIGNAL hz_s 		: STD_LOGIC;

  
  SIGNAL deb1_s 		: STD_LOGIC;	
  SIGNAL deb2_s 		: STD_LOGIC;	
  SIGNAL deb3_s 		: STD_LOGIC;	
  SIGNAL debclr_s	: STD_LOGIC;	
  
  SIGNAL dv_s 			: STD_LOGIC;	
  SIGNAL red_s 		: STD_LOGIC;	
  SIGNAL grn_s 		: STD_LOGIC;	
  SIGNAL inc_s 		: STD_LOGIC;	
  SIGNAL dec_s 		: STD_LOGIC;	
  SIGNAL lbt_s 		: STD_LOGIC;	
 
  SIGNAL act_s 		: STD_LOGIC_VECTOR(1 DOWNTO 0);
  SIGNAL cnt_s 		: STD_LOGIC_VECTOR(7 DOWNTO 0);
  SIGNAL evnt_s 	: STD_LOGIC_VECTOR(7 DOWNTO 0);	
  SIGNAL txd_s 		: STD_LOGIC;
  SIGNAL txled_s 	: STD_LOGIC;
  SIGNAL sdi_s 		: STD_LOGIC;
  SIGNAL sdv_s 		: STD_LOGIC;
  SIGNAL stx_s 		: STD_LOGIC;
  
BEGIN



clk1    : clkh       PORT MAP    (rb_i,cp_i,hz_s);  
deb1    : Debounce  GENERIC MAP (prescaler_g=>7)PORT MAP (rb_i,cp_i,s1_i,deb1_s);
deb2    : Debounce  GENERIC MAP (prescaler_g=>7)PORT MAP (rb_i,cp_i,s2_i,deb2_s);
deb3    : Debounce  GENERIC MAP (prescaler_g=>7)PORT MAP (rb_i,cp_i,s3_i,deb3_s);
deb4    : Debounce  GENERIC MAP (prescaler_g=>7)PORT MAP (rb_i,cp_i,clr_i,debclr_s);

sen     : Sense     PORT MAP    (rb_i,cp_i, deb1_s,deb2_s,deb3_s,debclr_s,inc_s,dec_s);

coun    : Count	     PORT MAP    (rb_i,cp_i,inc_s,dec_s,dv_s,act_s,cnt_s,evnt_s); 

Cnt     : Control   PORT MAP    (rb_i,cp_i,act_s,grn_s,red_s);       

uat1    : uat       GENERIC MAP (cp_freq => 12000000, baud => 9600)
                    PORT MAP    (rb_i,cp_i ,dv_s,cnt_s,txled_s,lbt_s,txd_s);  
in1     : intf      PORT MAP    (rb_i,cp_i,dv_s,evnt_s,cnt_s,sdi_s,sdv_s,stx_s);

  rb_o   	<=  rb_i;
  sec_o 	<= hz_s;  
  
  s1_o 	<= deb1_s; 
  s2_o 	<= deb2_s; 
  s3_o 	<= deb3_s; 
  clr_o <= debclr_s; 
  
  grn_o 	<= grn_s; 
  red_o		<= red_s;
  lbt_o 	<= lbt_s; 
  txled_o	<= txled_s;    
  txd_o 	<= txd_s;    
  sdi_o 	<= sdi_s;     
  sdv_o 	<= sdv_s;     
  stx_o 	<= stx_s;     
      

END artop;