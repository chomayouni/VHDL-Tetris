-- Example 71a: vga_640x480
-- Copyright 2009, 2012 LBE Books, LLC
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Tetris_VGA_640x480 is
    port ( clk, clr : in std_logic;
           hsync : out std_logic;
           vsync : out std_logic;
           hc : out std_logic_vector(9 downto 0);
           vc : out std_logic_vector(9 downto 0);
           vidon : out std_logic
	);
end Tetris_VGA_640x480;

architecture Behavioral of Tetris_VGA_640x480 is
constant hpixels: std_logic_vector(9 downto 0) := "1100100000";	 
	--Value of pixels in a horizontal line = 800
constant vlines: std_logic_vector(9 downto 0) := "1000001101";	 -- changed
	--Number of horizontal lines in the display = 525
constant hbp: std_logic_vector(9 downto 0) := "0010010000";	 
	--Horizontal back porch = 144 (128+16)
constant hfp: std_logic_vector(9 downto 0) := "1100010000";	 
	--Horizontal front porch = 784 (128+16+640)
constant vbp: std_logic_vector(9 downto 0) := "0000100011";	 -- changed
	--Vertical back porch = 35 (2+33)
constant vfp: std_logic_vector(9 downto 0) := "1000000011";	 -- changed
	--Vertical front porch = 515 (2+33+480)
signal hcs, vcs: std_logic_vector(9 downto 0);				
     --These are the Horizontal and Vertical counters
signal vsenable: std_logic;					
	--Enable for the Vertical counter
					
begin
	--Counter for the horizontal sync signal
  	process(clk, clr)
  	begin
	   if clr = '1' then
	   	hcs <= "0000000000";
	   elsif(clk'event and clk = '1') then
	   	if hcs = hpixels - 1 then						   
	   	--The counter has reached the end of pixel count
			hcs <= "0000000000";					
			--reset the counter
			vsenable <= '1';	--Enable the vertical counter 
	   	else
			hcs <= hcs + 1;						
			--Increment the horizontal counter
			vsenable <= '0';						
			--Leave the vsenable off
	   	end if;
	   end if;
  	end process;

  	hsync <= '0' when hcs < 96 else '1';		
  		--Horizontal Sync Pulse is low when hc is 0 - 96
 	
	--Counter for the vertical sync signal
	process(clk, clr)
	begin
   	   if clr = '1' then
		vcs <= "0000000000";
   	   elsif(clk'event and clk = '1' and vsenable='1') then
   		--Increment when enabled
		if vcs = vlines - 1 then						
			--Reset when the number of lines is reached
	   		vcs <= "0000000000";
		else 
			vcs <= vcs + 1;	--Increment vertical counter
		end if;
   	   end if;
	end process;

	--Vertical Sync Pulse is low when vc is 0 or 1
	vsync <= '0' when vcs < 2 else '1';		
		
	--Enable video out when within the porches
	vidon <= '1' when (((hcs < hfp) and (hcs >= hbp)) 
                   and ((vcs < vfp) and (vcs >= vbp))) else '0';	

	-- output horizontal and vertical counters
	hc <= hcs;
	vc <= vcs;
	

end Behavioral;
