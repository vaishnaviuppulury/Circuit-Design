-- ----------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE WORK.top_pack.ALL;
-- ---------------------------------------------------------------------------

ENTITY c16bin IS
PORT (rb_i   :  IN STD_LOGIC;                     -- Reset, active low
      cp_i   :  IN STD_LOGIC;                     -- Syscp, @ 12MHz
      en_i   :  IN STD_LOGIC;                     -- Enable Count
      cl_i   :  IN STD_LOGIC;                     -- Clear Counter
      co_o   : OUT STD_LOGIC;                     -- Carry Out
       q_o   : OUT STD_LOGIC_VECTOR(4 DOWNTO 0)   -- Counter Value
      );
END c16bin;
--------------------------------------------------------------