LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
 
LIBRARY WORK;
USE WORK.ALL;

entity two_bit_register is
    port(input  : in  unsigned(1 downto 0);
			clk    : in  std_logic;
			resetb : in std_logic;
			output : out unsigned(1 downto 0));
end entity two_bit_register;

architecture behavioral of two_bit_register is
 begin
	 process (clk, resetb)
	 begin
        if (rising_edge(clk)) then
            output <= input;
			end if;
        if resetb = '1' then
            output <= "00";
        end if;
    end process;

end;


