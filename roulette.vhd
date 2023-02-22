LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
 
LIBRARY WORK;
USE WORK.ALL;

----------------------------------------------------------------------
--
--  This is the top level template for Lab 2.  Use the schematic on Page 4
--  of the lab handout to guide you in creating this structural description.
--  The combinational blocks have already been designed in previous tasks,
--  and the spinwheel block is given to you.  Your task is to combine these
--  blocks, as well as add the various registers shown on the schemetic, and
--  wire them up properly.  The result will be a roulette game you can play
--  on your DE2.
--
-----------------------------------------------------------------------

ENTITY roulette IS
	PORT(   CLOCK_50 : IN STD_LOGIC; -- the fast clock for spinning wheel
		KEY : IN STD_LOGIC_VECTOR(3 downto 0);  -- includes slow_clock and reset
		SW : IN STD_LOGIC_VECTOR(17 downto 0);
		LEDG : OUT STD_LOGIC_VECTOR(3 DOWNTO 0):="0000";  -- ledg
		HEX7 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);  -- digit 7
		HEX6 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);  -- digit 6
		HEX5 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);  -- digit 5
		HEX4 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);  -- digit 4
		HEX3 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);  -- digit 3
		HEX2 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);  -- digit 2
		HEX1 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);  -- digit 1
		HEX0 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)   -- digit 0
	);
END roulette;


ARCHITECTURE structural OF roulette IS
 
 ---------------------------------------------------------------------
	component win is 
		port(spin_result_latched : in unsigned(5 downto 0);  
					 bet1_value : in unsigned(5 downto 0); 
					 bet2_colour : in std_logic;  
					 bet3_dozen : in unsigned(1 downto 0);  
					 bet1_wins : out std_logic;  
					 bet2_wins : out std_logic;  
					 bet3_wins : out std_logic);
	end component;
 ------------------------------------------------------------------------	
	component new_balance IS
	  port(money : in unsigned(11 downto 0);
			 value1 : in unsigned(2 downto 0);  
			 value2 : in unsigned(2 downto 0); 
			 value3 : in unsigned(2 downto 0);  
			 bet1_wins : in std_logic;
			 bet2_wins : in std_logic; 
			 bet3_wins : in std_logic;  
			 new_money : out unsigned(11 downto 0)); 
	end component;
 --------------------------------------------------------------------------
	component digit7seg IS
		PORT( digit : IN  UNSIGNED(3 DOWNTO 0);
				 seg7 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
	end component;
 --------------------------------------------------------------------------	
	component spinwheel IS
		Port(	fast_clock : IN  STD_LOGIC;
				resetb : IN  STD_LOGIC;     
				spin_result  : OUT UNSIGNED(5 downto 0)); 
	end component;
 ---------------------------------------------------------------------------	
	component d_flip_flop is
    Port(input  : in  std_logic;
			clk    : in  std_logic;
			resetb : in std_logic;
			output : out std_logic);
	end component;
----------------------------------------------------------------------------
	component two_bit_register is
    Port(input  : in  unsigned(1 downto 0);
			clk    : in  std_logic;
			resetb : in std_logic;
			output : out unsigned(1 downto 0));
	end component;
----------------------------------------------------------------------------
	component three_bit_register is
    Port(input  : in  unsigned(2 downto 0);
			clk    : in  std_logic;
			resetb : in std_logic;
			output : out unsigned(2 downto 0));
	end component;
----------------------------------------------------------------------------
	component six_bit_register is
    Port(input  : in  unsigned(5 downto 0);
			clk    : in  std_logic;
			resetb : in std_logic;
			output : out unsigned(5 downto 0));
	end component;
----------------------------------------------------------------------------
	component twelve_bit_register is
    Port(input  : in  unsigned(11 downto 0);
			clk    : in  std_logic;
			resetb : in std_logic;
			output : out unsigned(11 downto 0));
	end component;
----------------------------------------------------------------------------

	component debouncer is
	  port ( clk : in std_logic;
				switch : in std_logic;
				switch_debounced : out std_logic);
	end component;
------------------------------------------------------------------------------------
	
	signal spin_result_from_spinwheel :unsigned(5 downto 0);
	signal bet1_number: unsigned(5 downto 0);
	signal bet2_colour_number: std_logic;
	signal bet3_group: unsigned(1 downto 0);
	signal bet1_result: std_logic :='0';
	signal bet2_result: std_logic:='0'; 
	signal bet3_result: std_logic:='0';
	signal bet1_money,bet2_money,bet3_money: unsigned(2 downto 0);
	signal updated_money: unsigned(11 downto 0);
	signal start_money: unsigned(11 downto 0);
	signal spin_number: unsigned (5 downto 0);
	
   signal money_ones_value : unsigned(11 downto 0);
	signal money_tens_value : unsigned(11 downto 0);
	signal money_hundred_value : unsigned(11 downto 0);
	signal money_thousand_value : unsigned(11 downto 0);
	signal roll_ones_value : unsigned(5 downto 0);
	signal roll_tens_value : unsigned(5 downto 0);
	signal key0_debounced: std_logic;
	signal key1_debounced: std_logic;
	
 
 begin
 
 money_ones_value <= ((updated_money mod 10));
 money_tens_value <= (((updated_money/10) mod 10));
 money_hundred_value <= (((updated_money/100) mod 10));
 money_thousand_value <= (((updated_money/100) mod 10));
 
 roll_ones_value<= ((spin_result_from_spinwheel mod 10));
 roll_tens_value<= (((spin_result_from_spinwheel /10) mod 10));
 
	d1:debouncer
	port map(clock_50,key(0),key0_debounced);
	
	d2:debouncer
	port map(clock_50,key(1),key1_debounced);
 
	obj1: spinwheel
	port map(clock_50, key(1) ,spin_number);
  
	obj2: six_bit_register
	port map(spin_number,not key0_debounced,not key1_debounced, spin_result_from_spinwheel);
	
	obj3: six_bit_register 
	port map(unsigned(SW(8 downto 3)),not key0_debounced, not key1_debounced,bet1_number);
	
	obj4: d_flip_flop
	port map(SW(12),not key0_debounced, not key1_debounced,bet2_colour_number);
	
	obj5 : two_bit_register
	port map(unsigned(SW(17 downto 16)),not key0_debounced, not key1_debounced,bet3_group);
	
	obj6: win
	port map(spin_result_from_spinwheel,bet1_number,bet2_colour_number,bet3_group,bet1_result,bet2_result,bet3_result);
	
	obj7: three_bit_register
	port map(unsigned(SW(2 downto 0)),not key0_debounced, not key1_debounced,bet1_money);
	
	obj8: three_bit_register
	port map(unsigned(SW(11 downto 9)),not key0_debounced, not key1_debounced,bet2_money);

	obj9: three_bit_register
	port map(unsigned(SW(15 downto 13)),not key0_debounced, not key1_debounced,bet3_money);
	
	obj10: twelve_bit_register
	port map(updated_money,not key0_debounced, not key1_debounced,start_money);
	
	obj11: new_balance
	port map(start_money,bet1_money,bet2_money,bet3_money,bet1_result,bet2_result,bet3_result,updated_money);
	
	obj12: digit7seg
	port map(money_hundred_value(3 downto 0),HEX2);
	
	obj13: digit7seg
	port map(money_tens_value(3 downto 0) ,HEX1);
	
	obj14: digit7seg
	port map(money_ones_value(3 downto 0) ,HEX0);
	
	obj15: digit7seg
	port map(roll_ones_value(3 downto 0),HEX6);
	
	obj16: digit7seg
	port map(roll_tens_value(3 downto 0) ,HEX7);
	
	t1: digit7seg
	port map(money_thousand_value(3 downto 0),HEX3);
	
	HEX4<="1111111";
	HEX5<="1111111";
	
	process (key1_debounced,key0_debounced,bet1_result,bet2_result,bet3_result)
	begin
	
	if(key0_debounced = '0') then
	ledg(0) <= bet1_result;
	ledg(1) <= bet2_result;
	ledg(2) <= bet3_result;
	end if;
	
	if(key1_debounced = '0') then
	ledg(0) <= '0';
	ledg(1) <= '0';
	ledg(2) <= '0';
	end if;
	
	end process;

END;
