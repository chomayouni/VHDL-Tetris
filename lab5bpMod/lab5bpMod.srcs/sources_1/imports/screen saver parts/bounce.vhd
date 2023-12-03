----Example 74b: bounce
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_unsigned.all;
entity bounce is
	 port(
		 cclk : in STD_LOGIC;
		 clr : in STD_LOGIC;
		 go : in STD_LOGIC;
		 c1A, c1B : out STD_LOGIC_VECTOR(9 downto 0);
		 r1A, r1B : out STD_LOGIC_VECTOR(9 downto 0)
	     );
end bounce;
architecture bounce of bounce is
begin
process(cclk, clr)
variable c1vA, r1vA, c1vB , r1vB: STD_LOGIC_VECTOR(9 downto 0);
variable dcvA, drvA, dcvB, drvB: STD_LOGIC_VECTOR(9 downto 0);
variable calc: std_logic := '0';
constant c1max: integer := 499; -- pixels are 0 indexed
constant r1max: integer := 339; -- pixels are 0 indexed

begin
	if clr = '1' then
		c1vA := "00" & X"5A";   -- 90 starting collumn 
		r1vA := "00" & X"00";   -- 0 starting row 
		dcvA := "00" & X"02";   -- +2 horizontal velocity
		drvA := "00" & X"01";   -- -1 vertical velocity

		c1vB := "01" & X"9A";   -- 410 starting collumn 
		r1vB := "00" & X"00";   -- 0 starting row
		dcvB := "11" & X"FF";   -- -1 horizontal velocity
		drvB := "00" & X"02";   -- -2 vertical velocity
		
		calc := '0';
	elsif cclk'event and cclk = '1' then	
		if go = '1' then
			calc := '1';
		elsif calc = '1' then
		    --sprite A
			c1vA := c1vA + dcvA;
			r1vA := r1vA + drvA;			
			if (c1vA <= 0 or c1vA >= c1max) then
				dcvA := 0 - dcvA;
			end if;
			if (r1vA <= 0 or r1vA >= r1max) then
				drvA := 0 - drvA;
			end if;
			
			
		    --sprite B
			c1vB := c1vB + dcvB;
			r1vB := r1vB + drvB;			
			if (c1vB <= 0 or c1vB >= c1max) then
				dcvB := 0 - dcvB;
			end if;
			if (r1vB <= 0 or r1vB >= r1max) then
				drvB := 0 - drvB;
			end if;	
		end if;
	end if;
	c1A <= c1vA;
	c1B <= c1vB;
	r1A <= r1vA;
	r1B <= r1vB;
end process;
end bounce;