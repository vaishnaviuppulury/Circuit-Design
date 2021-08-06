-- ----------------------------------------------------------------------------
ARCHITECTURE ar1 OF intf IS

  SIGNAL ld_s,clr_s,dne_s,nxt_s : STD_LOGIC;
  SIGNAL sel_s : STD_LOGIC_VECTOR( 4 DOWNTO 0);
  SIGNAL dat_s : STD_LOGIC_VECTOR(15 DOWNTO 0);

BEGIN

  ifsm	: intfsm 	PORT MAP (rb_i,cp_i,en_i,dne_s,ld_s,stx_o,sdv_o,clr_s,nxt_s);
  regevt: reg16 	PORT MAP (rb_i,cp_i,ld_s,evnt_i,cnt_i,dat_s);
  cnt	: c16bin 	PORT MAP (rb_i,cp_i,nxt_s,clr_s,dne_s,sel_s);
  mx	: mx2d 		PORT MAP (sel_s,dat_s,sdi_o);
END ar1;
-- ----------------------------------------------------------------------------