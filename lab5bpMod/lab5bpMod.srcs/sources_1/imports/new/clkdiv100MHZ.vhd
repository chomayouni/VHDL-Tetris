-- Example 52: clock divider
-- Copyright 2009, 2012 LBE Books, LLC
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_unsigned.all;


entity clkdiv100MHZ is
	 port(
		 mclk : in STD_LOGIC;
		 clr : in STD_LOGIC;
		 clk25 : out STD_LOGIC;
		 clk190 : out STD_LOGIC
	     );
end clkdiv100MHZ;

architecture Behavioral of clkdiv100MHZ is
signal q:STD_LOGIC_VECTOR(24 downto 0);
begin
  -- clock divider
  process(mclk, clr)
  begin
    if clr = '1' then
	q <= X"000000" & '0';
    elsif mclk'event and mclk='1' then
	q <= q + 1;
    end if;
  end process;
  
  clk25 <= q(1);	-- 25 MHz
  clk190 <= q(18);
end Behavioral;
