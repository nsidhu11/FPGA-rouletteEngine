LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

LIBRARY WORK;
USE WORK.ALL;

-----------------------------------------------------
--
--  This block will contain a decoder to decode a 4-bit number
--  to a 7-bit vector suitable to drive a HEX dispaly
--
--  It is a purely combinational block (think Pattern 1) and
--  is similar to a block you designed in Lab 1.
--
--------------------------------------------------------

ENTITY digit7seg IS
	PORT(
          digit : IN  UNSIGNED(3 DOWNTO 0);  -- number 0 to 0xF
          seg7 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)  -- one per segment
	);
END;

------------------------------------------------------
-- LED ON = '0'
-- LED OFF ='1' 
-------------------------------------------------------

ARCHITECTURE behavioral OF digit7seg IS
BEGIN

	process (digit) is
	begin
    case (digit) is
      when "0000" => seg7 <= "1000000"; -- 0
      when "0001" => seg7 <= "1111001"; -- 1
      when "0010" => seg7 <= "0100100"; -- 2
      when "0011" => seg7 <= "0110000"; -- 3
      when "0100" => seg7 <= "0011001"; -- 4
      when "0101" => seg7 <= "0010010"; -- 5
      when "0110" => seg7 <= "0000010"; -- 6
      when "0111" => seg7 <= "1111000"; -- 7
      when "1000" => seg7 <= "0000000"; -- 8
      when "1001" => seg7 <= "0010000"; -- 9
      when "1010" => seg7 <= "0001000"; -- A
      when "1011" => seg7 <= "0000011"; -- b
      when "1100" => seg7 <= "0000110"; -- C
      when "1101" => seg7 <= "0100001"; -- d
      when "1110" => seg7 <= "0000110"; -- E
      when "1111" => seg7 <= "0001110"; -- F
      when others => seg7 <= "1111111"; -- "OFF" 
    end case;
  end process;

END;
