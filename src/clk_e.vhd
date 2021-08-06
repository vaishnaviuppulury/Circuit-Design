LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY clkh is
    PORT (
      rb_i : IN  STD_LOGIC;
      cp_i : IN  STD_LOGIC;
      hz_o : OUT STD_LOGIC);
END clkh;
  