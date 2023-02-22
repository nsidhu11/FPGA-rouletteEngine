LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
 
LIBRARY WORK;
USE WORK.ALL;

entity d_flip_flop is
    port(input  : in  std_logic;
			clk    : in  std_logic;
			resetb : in std_logic;
			output : out std_logic);
end entity d_flip_flop;

architecture behavioral of d_flip_flop is
 begin
	 process (clk, resetb)
	 begin
        if (rising_edge(clk)) then
            output <= input;
			end if;
        if resetb = '1' then
            output <= '0';
        end if;
    end process;
end;