-- ----------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE WORK.top_pack.ALL;

ENTITY reg16 IS
PORT(
  rb_i : IN std_logic;
  cp_i : IN std_logic;
  en_i : IN std_logic;
  de_i  : IN std_logic_vector(7 DOWNTO 0);
  dc_i  : IN std_logic_vector(7 DOWNTO 0);
  q_o  : OUT std_logic_vector(15 DOWNTO 0)
  );
END reg16;

-- ----------------------------------------------------------------------------