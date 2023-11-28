-- Example 73b: vga_bsprite_top
-- Copyright 2009, 2012 LBE Books, LLC
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use work.vga_components.all;

entity vga_bsprite_top is
	 port(
		mclk : in STD_LOGIC;
		btn : in STD_LOGIC_VECTOR(3 downto 0);
		sw : in STD_LOGIC_VECTOR(7 downto 0);
		hsync : out STD_LOGIC;
		vsync : out STD_LOGIC;
         	red : out std_logic_vector(2 downto 0);
         	green : out std_logic_vector(2 downto 0);
         	blue : out std_logic_vector(1 downto 0)
	     );
end vga_bsprite_top;

architecture vga_bsprite_top of vga_bsprite_top is 
signal clr, clk25, vidon: std_logic;
signal hc, vc: std_logic_vector(9 downto 0);
signal M: std_logic_vector(7 downto 0);
signal rom_addr16: std_logic_vector(15 downto 0);
begin
  
	clr <= btn(3);

U1 : clkdiv
	port map(mclk => mclk, clr => clr, clk25 => clk25);
	
U2 : vga_640x480
	port map(clk => clk25, clr => clr, hsync => hsync, 
      vsync => vsync, hc => hc, vc => vc, vidon => vidon); 
	
U3 : vga_bsprite
	port map(vidon => vidon, hc => hc, vc => vc, M => M, sw => sw,
		rom_addr16 => rom_addr16, red => red, green => green,
		blue => blue);

U4 : loons240x160
	port map (addr => rom_addr16, clk => clk25, dout => M);
	
end vga_bsprite_top;
	