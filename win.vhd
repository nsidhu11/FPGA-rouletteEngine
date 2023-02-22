LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
 
LIBRARY WORK;
USE WORK.ALL;

--------------------------------------------------------------
--
--  This is a skeleton you can use for the win subblock.  This block determines
--  whether each of the 3 bets is a winner.  As described in the lab
--  handout, the first bet is a "straight-up" bet, teh second bet is 
--  a colour bet, and the third bet is a "dozen" bet.
--
--  This should be a purely combinational block.  There is no clock.
--  Remember the rules associated with Pattern 1 in the lectures.
--
---------------------------------------------------------------

ENTITY win IS
	PORT(spin_result_latched : in unsigned(5 downto 0);  -- result of the spin (the winning number)
             bet1_value : in unsigned(5 downto 0); -- value for bet 1
             bet2_colour : in std_logic;  -- colour for bet 2
             bet3_dozen : in unsigned(1 downto 0);  -- dozen for bet 3
             bet1_wins : out std_logic;  -- whether bet 1 is a winner
             bet2_wins : out std_logic;  -- whether bet 2 is a winner
             bet3_wins : out std_logic); -- whether bet 3 is a winner
END win;
 --------------------------------------------
 -- Bet 0: 
 --		Amount: $0 - $7 --> switches 2-0
 --		No. to bet on: 0 -36 --> switches 8-3
 -- Bet 1:
 --		Amount: $0 - $7 --> switches 9-11
 --		Colour to bet on: 0,1 --> switches 12  [red=1, black=0]
 -- Bet 3:
 --		Amount: $0 - $7 --> switches 15 - 13
 --		Dozen to bet on: 0, 1, 2 --> switches 17-16
 -- win: 1		lost: 0
------------------------------------------------ 
ARCHITECTURE behavioural OF win IS
BEGIN
	
	process(spin_result_latched, bet1_value,bet2_colour,bet3_dozen)
	begin
	
	if (spin_result_latched = bet1_value) then
		bet1_wins <= '1';
	else
		bet1_wins <='0';
	end if;
	
	
	if( (((spin_result_latched >="000001" and spin_result_latched <="001010") or (spin_result_latched >= "010011" and spin_result_latched <="011100")) and (spin_result_latched(0)=bet2_colour)) 
				or 
			(((spin_result_latched >="001011" and spin_result_latched<= "010010") or (spin_result_latched >= "011101" and spin_result_latched <="100100")) and (not(spin_result_latched(0)=bet2_colour))) )then
		bet2_wins<= '1';
	else
		bet2_wins<= '0';
	end if;
	
	--if( (bet3_dozen = "00" and (spin_result_latched>= "000001" and spin_result_latched<="001100")) or (bet3_dozen = "01" and (spin_result_latched>= "001101" and spin_result_latched  <="011000")) or (bet3_dozen = "10" and (spin_result_latched>="011001" and spin_result_latched<="100010")) ) then
	--	bet3_wins <='1';
	--else
	--	bet3_wins<= '0';
  --end if;
  case bet3_dozen is
	when "00" =>
		if(spin_result_latched>= "000001" and spin_result_latched<="001100")then
			bet3_wins<= '1';
		else
			bet3_wins<= '0';
		end if;
	when "01" =>
		if(spin_result_latched>= "001101" and spin_result_latched  <="011000")then
			bet3_wins<= '1';
		else
			bet3_wins<= '0';
		end if;
	when "10" =>
		if(spin_result_latched>="011001" and spin_result_latched<="100100")then
			bet3_wins<= '1';
		else
			bet3_wins<= '0';
		end if;
	when others =>
		bet3_wins<= '0';
	
	end case;
	end process;
	
END;
